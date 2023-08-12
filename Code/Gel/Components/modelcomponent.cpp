//****************************************************************************
//* MODULE:         Gel/Components
//* FILENAME:       ModelComponent.cpp
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  10/17/2002
//****************************************************************************

#include <Gel/Components/modelcomponent.h>

#include <Core/String/stringutils.h>
									
#include <Gel/Object/compositeobject.h>
#include <Gel/Object/compositeobjectmanager.h>

#include <Gel/Components/animationcomponent.h>
#include <Gel/Components/skeletoncomponent.h>
#include <Gel/Components/SuspendComponent.h>

#include <Gel/Net/Server/netserv.h>
#include <Gel/Net/Client/netclnt.h>

#include <Gel/Scripting/array.h>
#include <Gel/Scripting/checksum.h>
#include <Gel/Scripting/script.h>								
#include <Gel/Scripting/struct.h>
#include <Gel/Scripting/utils.h>

#include <Gfx/gfxutils.h>
#include <Gfx/ModelAppearance.h>
#include <Gfx/ModelBuilder.h>
#include <Gfx/nx.h>
#include <Gfx/NxGeom.h>
#include <Gfx/NxLight.h>
#include <Gfx/NxModel.h>
#include <Gfx/Skeleton.h>

#include <Sk/GameNet/GameNet.h>
#include <Sk/Engine/feeler.h>
#include <Sk/Modules/Skate/skate.h>
#include <Sk/Objects/moviecam.h>
					 
namespace Obj
{

#define vMAX_PATH (512)
    
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CModelComponent::init_model_from_level_object( uint32 checksumName )
{
	Nx::CSector *p_sector = Nx::CEngine::sGetSector(checksumName);
	Dbg_MsgAssert( p_sector, ( "WARNING: sGetSector(0x%x) returned nullptr (%s)\n", checksumName, Script::FindChecksumName(checksumName) ) );
	if ( p_sector )
	{
		// need to clone the source, not the instance?
		Nx::CGeom* pGeom = p_sector->GetGeom();
		if( pGeom )
		{
			Nx::CGeom* pClonedGeom = pGeom->Clone( true );
			pClonedGeom->SetActive(true);
			mp_model->AddGeom( pClonedGeom, 0 );
			m_isLevelObject = true;
		}
		// Also get the collision data pointer
//				Dbg_Assert(p_sector->GetCollSector());
//				Nx::CCollObjTriData* p_coll_tri_data = p_sector->GetCollSector()->GetGeometry();
//				Dbg_Assert(p_coll_tri_data);
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
// This static function is what is registered with the component factory 
// object, (currently the CCompositeObjectManager) 
CBaseComponent *	CModelComponent::s_create()
{
	return static_cast<CBaseComponent*>(new CModelComponent);	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CModelComponent::CModelComponent() : CBaseComponent()
{
	SetType(Crc::ConstCRC("Model"));
    mp_model = Nx::CEngine::sInitModel();
	
	// since it's uninitialized
	m_display_rotation_offset.Set( 0.0f, 0.0f, 0.0f );		
	
	mpDisplayRotationInfo[0].Clear();
	mpDisplayRotationInfo[1].Clear();
	mpDisplayRotationInfo[2].Clear();

	m_numLODs = 0;
	m_isLevelObject = false;
	
	mDisplayOffset.Set();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CModelComponent::~CModelComponent()
{
    Dbg_MsgAssert( mp_model, ( "No model" ) );
    Nx::CEngine::sUninitModel( mp_model );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
void CModelComponent::InitFromStructure( Script::CStruct* pParams )
{
	// needs to come before the geoms get added,
	// because otherwise we've cause some fragmentaton
	// when we switch models...
	if ( pParams->ContainsFlag( Crc::ConstCRC("UseModelLights") ) )
	{
		if ( !mp_model->GetModelLights() )
		{
			mp_model->CreateModelLights();
			Nx::CModelLights *p_lights = mp_model->GetModelLights();
			p_lights->SetPositionPointer(&GetObj()->m_pos);
		}
	}
	else
	{
		if ( mp_model->GetModelLights() )
		{
			mp_model->DestroyModelLights();
		}
	}

	// this function assumes that the skeletoncomponent
	// will be correctly added BEFORE the modelcomponent
	
	// not all models are initialized using InitFromStructure,
	// so we should find someplace better to put the following 
	// call to SetSkeleton()
	CSkeletonComponent *p_skeleton_component = GetSkeletonComponentFromObject(GetObj());
	if (p_skeleton_component)
	{
		GetModel()->SetSkeleton( p_skeleton_component->GetSkeleton() );
	}

	int doShadowVolume = 0;
	pParams->GetInteger( Crc::ConstCRC("shadowVolume"), &doShadowVolume, Script::NO_ASSERT );
	mp_model->EnableShadowVolume( doShadowVolume );
	
	InitModel( pParams );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
void CModelComponent::InitModel( Script::CStruct* pParams )
{
	// should destroy the existing model
	mp_model->ClearGeoms();

	// update its scale, if any
	// (need to do this before init_model(), 
	// which can potentially override the scale)
	Mth::Vector theScale(1.0f,1.0f,1.0f);
	if ( Gfx::GetScaleFromParams( &theScale, pParams ) )
	{
		mp_model->SetScale( theScale );
	}
	
	const char* pModelName;
	uint32 model_name_checksum=0;
	uint32 assetName;
	uint32 refObjectName;
	uint32 cloneID;

	// check first if it is a LevelObject
	// in which case it will have a "name" which is the name of the sector
	uint32 ClassChecksum = 0;
	pParams->GetChecksum( Crc::ConstCRC("Class"), &ClassChecksum );
	if ( ClassChecksum == Crc::ConstCRC("LevelObject") )
	{
		uint32	checksumName;	
		pParams->GetChecksum( Crc::ConstCRC("Name"), &checksumName, Script::ASSERT );
		init_model_from_level_object(checksumName);
	}
	else
	{
		// by default, use the asset manager
		int useAssetManager = 1;
		pParams->GetInteger( Crc::ConstCRC("use_asset_manager"), &useAssetManager, Script::NO_ASSERT );

		int texDictOffset = 0;
		pParams->GetInteger( Crc::ConstCRC("texDictOffset"), &texDictOffset, Script::NO_ASSERT );

		if ( pParams->GetChecksum( Crc::ConstCRC("refObjectName"), &refObjectName, Script::NO_ASSERT ) )
		{
			m_refObjectName = refObjectName;
			m_hasRefObject = true;
			mp_model->SetRenderMode( Nx::vNONE );
		}
		else if ( pParams->GetChecksum( Crc::ConstCRC("assetName"), &assetName, Script::NO_ASSERT ) )
		{														  
			// this means that the asset name was faked somehow
			// (for example, if we've loaded it up from a data stream
			// instead of a filename)
			Dbg_MsgAssert( mp_model, ( "No model" ) );

			int supportMultipleMaterialColors = 0;
			pParams->GetInteger( Crc::ConstCRC("multicolor"), &supportMultipleMaterialColors, Script::NO_ASSERT );
			
			// component name doesn't matter...  give it a dummy
			uint32 componentName = 0;
			mp_model->AddGeom( assetName, componentName, supportMultipleMaterialColors );
		}
		else if ( pParams->GetChecksum( Crc::ConstCRC("cloneFrom"), &cloneID, Script::NO_ASSERT ) )
		{														  
			// Clone the geometry off of an existing model
			CCompositeObject* pObject = static_cast<CCompositeObject *>(CCompositeObjectManager::Instance()->GetObjectByID(cloneID));
			Dbg_MsgAssert( pObject, ( "Couldn't find object id %d to clone", cloneID ) );

			CModelComponent *p_src_model_comp = GetModelComponentFromObject(pObject);
			Dbg_MsgAssert( p_src_model_comp, ( "Couldn't find model component in object id %d", cloneID ) );
			Dbg_MsgAssert( p_src_model_comp->mp_model, ( "Couldn't find CModel in model component of object id %d", cloneID ) );

			uint32 geomName;
			Script::CArray *p_geom_array=nullptr;
			if ( pParams->GetChecksum( Crc::ConstCRC("geom"), &geomName, Script::NO_ASSERT ) )
			{
				Nx::CGeom *p_orig_geom = p_src_model_comp->mp_model->GetGeom(geomName);
				Dbg_MsgAssert(p_orig_geom, ("Couldn't find CGeom %s", Script::FindChecksumName(geomName)));

				Nx::CGeom *p_new_geom = p_orig_geom->Clone(true, mp_model);
				Dbg_MsgAssert(p_new_geom, ("Couldn't clone CGeom %s", Script::FindChecksumName(geomName)));

				p_new_geom->SetActive(true);
				mp_model->AddGeom(p_new_geom, geomName);
			}
			else if (pParams->GetArray(Crc::ConstCRC("geoms"), &p_geom_array))
			{
				for (uint i = 0; i < p_geom_array->GetSize(); i++)
				{
					geomName = p_geom_array->GetChecksum(i);
					if (geomName)
					{
						Nx::CGeom *p_orig_geom = p_src_model_comp->GetModel()->GetGeom(geomName);
						Dbg_MsgAssert(p_orig_geom, ("Couldn't find CGeom %s", Script::FindChecksumName(geomName)));

						Nx::CGeom *p_new_geom = p_orig_geom->Clone(true, mp_model);
						Dbg_MsgAssert(p_new_geom, ("Couldn't clone CGeom %s", Script::FindChecksumName(geomName)));

						p_new_geom->SetActive(true);
						mp_model->AddGeom(p_new_geom, geomName);
					}
				}
			}
		}
		else if ( pParams->GetText( Crc::ConstCRC("model"), &pModelName, Script::NO_ASSERT )
			|| pParams->GetText( Crc::ConstCRC("modelName"), &pModelName, Script::NO_ASSERT ) )
		{
			// TODO:  If the model name is "none", then we shouldn't
			// have added the modelcomponent in the first place...
			// we should have some kind of higher-level logic decide
			// whether or not to create the modelcomponent, based on
			// whether the node specifies:  model="none".
			if ( Script::GenerateCRC(pModelName) == Crc::ConstCRC("none") )
			{
				;	// do nothing
			}
			else
			{
				char fullModelName[vMAX_PATH];

				uint32 skeletonName;
				if ( pParams->GetChecksum( Crc::ConstCRC("skeletonName"), &skeletonName, Script::NO_ASSERT ) )
				{
					// if it's a skinned model
					Gfx::GetModelFileName(pModelName, ".skin", fullModelName);
				}
				else
				{
					// if it's a nonskinned model
					Gfx::GetModelFileName(pModelName, ".mdl", fullModelName);
				}

				Str::LowerCase( fullModelName );

				bool forceTexDictLookup = pParams->ContainsFlag( Crc::ConstCRC("AllowReplaceTex") );

				// TODO: remove this for thps5 (it's only used for the boards
				// in the skateshop, which need to do texture replacement, and 
				// thus cannot use the asset manager...)
				if ( strstr( fullModelName, "thps4board_" ) )
				{
					useAssetManager = false;
				}

				// Model file name should look like this:  "models/testcar/testcar.mdl"
				Dbg_MsgAssert( strlen(fullModelName) < vMAX_PATH, ( "String too long" ) );
				mp_model->AddGeom( fullModelName, 0, useAssetManager, texDictOffset, forceTexDictLookup );
				
#ifdef __PLAT_NGPS__
				int lodIndex = 0;
				// now load up the other LODs, if they exist
				for ( int i = 0; i < vNUM_LODS; i++ )
				{
					char paramName[256];
					sprintf( paramName, "modelLOD%d", lodIndex + 1 ); 
					if ( pParams->GetText( paramName, &pModelName, Script::NO_ASSERT ) )
					{
						float modelDist;
						sprintf( paramName, "modelLODdist%d", lodIndex + 1 );
						if ( pParams->GetFloat( paramName, &modelDist, Script::NO_ASSERT ) )
						{
							uint32 skeletonName;
							if ( pParams->GetChecksum( Crc::ConstCRC("skeletonName"), &skeletonName, Script::NO_ASSERT ) )
							{
								// if it's a skinned model
								Gfx::GetModelFileName(pModelName, ".skin", fullModelName);
							}
							else
							{
								// if it's a nonskinned model
								Gfx::GetModelFileName(pModelName, ".mdl", fullModelName);
							}

							Str::LowerCase( fullModelName );
							
							mp_model->AddGeom( fullModelName, lodIndex + 1, useAssetManager, texDictOffset );
							enable_lod( lodIndex + 1, modelDist );
							lodIndex++;
						}
						else
						{
							Dbg_MsgAssert( 0, ( "Expected to find parameter for LOD model dist: %s", paramName ) );
						}
					}
				}
#endif
			}
		}
		else if ( pParams->GetChecksum( Crc::ConstCRC("model"), &model_name_checksum, Script::NO_ASSERT ))
		{
			Nx::CSector *p_source_sector = Nx::CEngine::sGetSector(model_name_checksum);
			Dbg_MsgAssert(p_source_sector,("Could not find sector %s\n",Script::FindChecksumName(model_name_checksum)));
			
			Nx::CGeom *p_orig_geom = p_source_sector->GetGeom();
			Dbg_MsgAssert(p_orig_geom, ("Couldn't find CGeom for %s",Script::FindChecksumName(model_name_checksum)));

			Nx::CGeom *p_new_geom = p_orig_geom->Clone(true, (Nx::CScene*)nullptr);
			Dbg_MsgAssert(p_new_geom, ("Couldn't clone CGeom %s", Script::FindChecksumName(model_name_checksum)));
			p_new_geom->SetActive(true);
			
			mp_model->AddGeom(p_new_geom, 0);
		}
	}

	// update its position
	if ( GetObj()->IsFinalized() )
	{
		FinalizeModelInitialization();
	}

	// now that the model has been created,
	// remember the bounding sphere
	m_original_bounding_sphere = mp_model->GetBoundingSphere();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// create-a-ped, create-a-skater
void CModelComponent::InitModelFromProfile( Gfx::CModelAppearance* pAppearance, bool useAssetManager, uint32 texDictOffset, uint32 buildScript  )
{
	Dbg_MsgAssert( mp_model, ( "No model?" ) );
	Nx::CModel* pModel = mp_model;

	// GJ:  shouldn't destroy the existing model
	// it's up to each build script to do this...
	// (in case we just want to re-apply a few
	// operations)
	//	pModel->ClearGeoms();

    Gfx::CSkeleton* pSkeleton = nullptr;
	Obj::CSkeletonComponent* pSkeletonComponent = GetSkeletonComponentFromObject( GetObj() );
	if ( pSkeletonComponent )
	{
		pSkeleton = pSkeletonComponent->GetSkeleton();
	}

	Gfx::CModelBuilder theBuilder( useAssetManager, texDictOffset );
	if ( buildScript )
	{
		theBuilder.BuildModel( pAppearance, pModel, pSkeleton, buildScript );
	}
	else
	{
		theBuilder.BuildModel( pAppearance, pModel, pSkeleton );
	}

	// update its position
	if ( GetObj()->IsFinalized() )
	{
		FinalizeModelInitialization();
	}

	// now that the model has been created,
	// remember the bounding sphere
	m_original_bounding_sphere = pModel->GetBoundingSphere();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CModelComponent::enable_lod(uint32 componentName, float distance)
{
	if ( m_numLODs >= vNUM_LODS )
	{
		Dbg_MsgAssert( 0, ( "Too many LODs!" ) );
		return false;
	}

	Nx::CGeom* pGeom = mp_model->GetGeom( componentName );
	if ( !pGeom )
	{
		Dbg_MsgAssert( 0, ( "Couldn't find geom named %s", Script::FindChecksumName(componentName) ) );
		return false;
	}

//	printf( "Enabled lod %08x\n", componentName );

	// GJ TODO:  should sort the lods by distance, 
	// and check for duplicates!

	m_LODdist[m_numLODs] = distance;

	m_numLODs++;

	// GJ TODO:  each client needs to do this
	// on a case-by-case basis...

	return true;
}
		
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CModelComponent::HideGeom( uint32 geomName, bool hidden, bool propagate )
{
    if( propagate )
	{
		GameNet::Manager* gamenet_man = GameNet::Manager::Instance();
		GameNet::PlayerInfo* player;

		player = gamenet_man->GetPlayerByObjectID( GetObj()->GetID() );
		if( player && player->IsLocalPlayer())
		{
			Net::Client* client;
			GameNet::MsgHideAtomic msg;
			Net::MsgDesc msg_desc;

			client = gamenet_man->GetClient( player->GetSkaterNumber() );
			Dbg_Assert( client );

			//msg.m_Time = client->m_Timestamp;
			msg.m_Hide = hidden;
			msg.m_AtomicName = geomName;
			msg.m_ObjId = (char)GetObj()->GetID();

			msg_desc.m_Data = &msg;
			msg_desc.m_Length = sizeof( GameNet::MsgHideAtomic );
			msg_desc.m_Id = GameNet::MSG_ID_SET_HIDE_ATOMIC;
			client->EnqueueMessageToServer( &msg_desc );
		}
	}

	if ( mp_model )
	{
		mp_model->HideGeom( geomName, hidden );
	}

	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CModelComponent::GeomHidden( uint32 geomName )
{
    return (mp_model->GeomHidden( geomName ));
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
void CModelComponent::GetDisplayMatrixWithExtraRotation( Mth::Matrix& displayMatrix )
{
    CCompositeObject* pObject = GetObj();
    Dbg_MsgAssert( pObject, ( "Couldn't find parent object" ) );
	
	displayMatrix = pObject->GetDisplayMatrix();
	displayMatrix[Mth::POS] = Mth::Vector( 0.0f, 0.0f, 0.0f, 1.0f );
	
	if (mFlipDisplayMatrix)
	{
		displayMatrix[Z] = -displayMatrix[Z];
		displayMatrix[X] = -displayMatrix[X];
	}

	// Record the display matrix for use by the camera before applying any extra rotation.
//	m_camera_display_matrix=m_display_matrix;

	Mth::Matrix extra_display_rotation;
	
	// only do the math if we're not dealing w/ the identity...
	bool is_identity = true;

	float new_angle;
	if (mpDisplayRotationInfo[0].m_active)
	{
		new_angle=mpDisplayRotationInfo[0].CalculateNewAngle();	
		if ( new_angle )
		{
			if (is_identity)
			{
				extra_display_rotation.Ident();
			}
			is_identity = false;
			extra_display_rotation.RotateX(Mth::DegToRad(new_angle));
		}
	}
	
	if (mpDisplayRotationInfo[1].m_active)
	{
		new_angle=mpDisplayRotationInfo[1].CalculateNewAngle();	
		if ( new_angle )
		{
			if (is_identity)
			{
				extra_display_rotation.Ident();
			}
			is_identity = false;
			extra_display_rotation.RotateY(Mth::DegToRad(new_angle));
		}
	}
	
	if (mpDisplayRotationInfo[2].m_active)
	{
		new_angle=mpDisplayRotationInfo[2].CalculateNewAngle();	
		if ( new_angle )
		{
			if (is_identity)
			{
				extra_display_rotation.Ident();
			}
			is_identity = false;
			extra_display_rotation.RotateZ(Mth::DegToRad(new_angle));
		}
	}

	Mth::Vector off(0.0f, 0.0f, 0.0f, 0.0f);	
	if ( !is_identity )
	{
		off=m_display_rotation_offset;	
		if ( !( off[X] == 0.0f && off[Y] == 0.0f && off[Z] == 0.0f ) )
		{
	//		is_identity = false;
			off=off-off*extra_display_rotation;		  // Would zero it if it's the identity
			off=off*displayMatrix;		
		}
	
	//	if ( !is_identity )
		{
			displayMatrix=extra_display_rotation*displayMatrix;
		}
	}

//#ifdef		DEBUG_DISPLAY_MATRIX
//	dodgy_test(); printf("%d: Setting display_matrix[Y][Y] to %f, [X][X] to %f\n",__LINE__,m_display_matrix[Y][Y],m_display_matrix[X][X]);
//#endif

	displayMatrix[Mth::POS] = GetObj()->GetPos();
	displayMatrix[Mth::POS] += off;
	displayMatrix[Mth::POS] += mDisplayOffset;
	displayMatrix[Mth::POS][W] = 1.0f;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CModelComponent::Hide( bool shouldHide )
{
	if ( mp_model )
	{
		mp_model->Hide( shouldHide );
	}	  
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CModelComponent::Teleport()
{
	Dbg_MsgAssert( GetObj()->IsFinalized(), ( "Teleporting unfinalized component!" ) );

	FinalizeModelInitialization();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
void CModelComponent::Update()
{
	if ( m_hasRefObject )
	{
#ifdef __NOPT_ASSERT__
		Obj::CMovieManager* pMovieManager = Mdl::Skate::Instance()->GetMovieManager();
		Dbg_MsgAssert( !pMovieManager->IsRolling(), ( "Wasn't expecting cutscene to be rolling" ) );
#endif

		// this code was lifted from cutscenedetails.cpp,
		// which is why it has all these weird temp
		// variables referencing its own member vars.
		// it's used for doing the create-a-trick skater
		Obj::CModelComponent* pModelComponent = this;
		Obj::CCompositeObject* pCompositeObject = GetObj();

		uint32 refObjectName = pModelComponent->GetRefObjectName();
		Obj::CCompositeObject* pRefObject = (Obj::CCompositeObject*)Obj::ResolveToObject( refObjectName );
		Dbg_Assert( pRefObject );
		Obj::CModelComponent* pRefModelComponent = GetModelComponentFromObject( pRefObject );
		Dbg_Assert( pRefModelComponent );
		Nx::CModel* pRefModel = pRefModelComponent->GetModel();
		bool should_animate = true;
		Obj::CSkeletonComponent* pSkeletonComponent = GetSkeletonComponentFromObject( pCompositeObject );
		Dbg_MsgAssert( pSkeletonComponent, ( "Was expecting a skeleton component" ) );
		Dbg_Assert( pSkeletonComponent == mp_skeleton_component );

		Mth::Matrix theDisplayMatrix;
		this->GetDisplayMatrixWithExtraRotation( theDisplayMatrix );
		
		// the return matrix already takes the position (plus an additional offset)
		// into account, so we don't have to do the following:
		// theDisplayMatrix[Mth::POS] = GetObj()->GetPos();
		
		pRefModel->Render( &theDisplayMatrix, !should_animate, pSkeletonComponent->GetSkeleton() );
		pRefModel->SetBoneMatrixData( pSkeletonComponent->GetSkeleton() );
	}
	// Mick: Don't need to update it if not active, just leave it where it is
	else if (mp_model && mp_model->GetActive())
	{
		
		Dbg_MsgAssert(GetObj()->IsFinalized(),("Update() to UnFinalized Composite object %s",Script::FindChecksumName(GetObj()->GetID())));
	
		Mth::Matrix theDisplayMatrix;

		GetDisplayMatrixWithExtraRotation( theDisplayMatrix );
			
//			theDisplayMatrix = GetObj()->GetDisplayMatrix();
//			theDisplayMatrix[Mth::POS] = GetObj()->GetPos();
//			theDisplayMatrix[Mth::POS][W] = 1.0f;
		
		// TODO:  The interface between different components
		// should be more generic, maybe...
		Gfx::CSkeleton* pSkeleton = nullptr;
		if ( mp_skeleton_component )
		{
			pSkeleton = mp_skeleton_component->GetSkeleton();
		}
		
		// default to true, for skeletal cars...
		bool should_animate = true;
	
		if ( mp_animation_component )
		{
			// either the animation component should cache this
			// data rather than doing the visibility test twice,
			// or it should be able to set some member inside
			// the model component (CModelComponent::MarkAnimationAsDirty?)
			should_animate = mp_animation_component->ShouldAnimate();
		}
	
	#ifdef __PLAT_NGPS__
		// if it has LODs, then hide all the unnecessary ones
		if ( m_numLODs > 0 )
		{
			// first hide all the models, including the base one (0)
			for ( int i = 0; i < m_numLODs + 1; i++ )
			{
				mp_model->HideGeom( i, true );
			}
	
			// now go through and unhide the correct one
			float distanceSqrToCamera = mp_suspend_component->GetDistanceSquaredToCamera();
			
	//		printf( "distance to camera: %f feet\n", sqrtf(distanceSqrToCamera)/12.0f );
	
			bool found = false;
			for ( int i = 0; i < m_numLODs; i++ )
			{
				if ( distanceSqrToCamera < ( m_LODdist[i] * m_LODdist[i] ) )
				{
					mp_model->HideGeom( i, false );
					found = true;
				}
			}
			if ( !found )
			{
				// then the last lod is active
				mp_model->HideGeom( m_numLODs, false );
			}
		}
	#endif
	
		// TODO:  if it's offscreen, the data shouldn't be copied over either...
	
		mp_model->Render( &theDisplayMatrix, !should_animate, pSkeleton );
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CModelComponent::Finalize()
{
	mp_skeleton_component =  GetSkeletonComponentFromObject( GetObj() );
	mp_animation_component =  GetAnimationComponentFromObject( GetObj() );
	mp_suspend_component =  GetSuspendComponentFromObject( GetObj() );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CModelComponent::SetModelLODDistance( int lodIndex, float distance )
{
	if ( !mp_model )
	{
		Dbg_Message( "No model!" );
		return;
	}

	if ( m_numLODs == 0 )
	{
		Dbg_Message( "Model %s has no lods", Script::FindChecksumName(GetObj()->GetID()) );
	}

	if ( lodIndex < 1 || lodIndex > m_numLODs )
	{
		Dbg_Message( "Was expecting an lod index between 1 and %d", m_numLODs);
		return;
	}

	m_LODdist[lodIndex-1] = distance;
	Dbg_Message( "ModelLODDist%d is now %f", lodIndex, distance );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CModelComponent::SetBoundingSphere( const Mth::Vector& newSphere )
{
	if ( mp_model )
	{
		mp_model->SetBoundingSphere( newSphere );
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CModelComponent::UpdateBrightness()
{
	Dbg_MsgAssert(mp_model, ("UpdateBrightness: CModel is nullptr"));
	Dbg_MsgAssert(mp_model->GetModelLights(), ("UpdateBrightness: MovingObject has no model lights"));
	mp_model->GetModelLights()->UpdateBrightness();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent::EMemberFunctionResult CModelComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	bool success = true;

	/*
    Script::CStruct *p_script_params;
	 
	p_script_params = nullptr;
	if( pScript )
	{
		p_script_params = pScript->GetParams();
	}
	*/

	switch (Checksum)
	{
		// @script | Obj_EnableScaling | in case you want to dynamically
        // turn on scaling
		case ( 0x347ff11b ):	// Obj_EnableScaling
			if ( mp_model )
			{
				mp_model->EnableScaling( true );
			}
			break;

        // @script | Obj_DisableScaling | in case you want to dynamically
        // turn off scaling
		case ( 0xf951aa64 ):	// Obj_DisableScaling
			if ( mp_model )
			{
				mp_model->EnableScaling( false );
			}
			break;

        // @script | Obj_ApplyScaling | scale on x,y,z 
        // @parm float | x | 
        // @parm float | y | 
        // @parm float | z | 
		case ( 0x657ff1ed ):	// Obj_ApplyScaling
		{
			// GJ:  Scaling only refers to the renderable
			// model, not the collision volume...
			if ( mp_model )
			{
				Mth::Vector theScale(1.0f,1.0f,1.0f);
				if ( Gfx::GetScaleFromParams( &theScale, pParams ) )
				{
					mp_model->SetScale( theScale );
					mp_model->EnableScaling( true );
				}
			}
		}
		break;
        
		// @script | Obj_ClearColor | turns off color modulation on this resetting it to the default color
		case ( 0x6052480a ):	// Obj_ClearColor
		{
			if ( mp_model )
			{
				mp_model->ClearColor( Crc::ConstCRC("all") );
			}
		}
		break;

        // @script | Obj_SetColor | 
        // @parm int | h | hue - between 0 and 360
        // @parm int | s | saturation - between 0 and 100
        // @parm int | v | value - between 0 and 100
        case ( 0x76ecfa1c ):	// Obj_SetColor
		{
            if ( mp_model )
			{
				int h, s, v;
				if ( pParams->GetInteger( Crc::ConstCRC("h"), &h, false )
					&& pParams->GetInteger( Crc::ConstCRC("s"), &s, false )
					&& pParams->GetInteger( Crc::ConstCRC("v"), &v, false ) )
				{
					mp_model->ModulateColor( Crc::ConstCRC("all"), (float)h, (float)s / 100.0f, (float)v / 100.0f );
				}
			}
		}
		break;

        // @script | Obj_ReplaceTexture | Replaces a texture in the model's dictionary
        // @parm text | src | filename of the source texture
        // @parm text | dest | filename of the destination texture
        // @parmopt name | in | all | name of geom in which to look for texture (defaults to global replacement)
		// Ex:  Obj_ReplaceTexture src="knee_l.png" dest="textures/skater_m/knee_scuff"	in=skater_m_legs
		case 0x83f9be15: // Obj_ReplaceTexture
		{
			const char* pSrcTexture;
			const char* pDstTexture;
			
			success = false;
			
			Script::CArray* pArray;
			if ( pParams->GetArray( Crc::ConstCRC("array"), &pArray, Script::NO_ASSERT ) )
			{
				for ( uint32 i = 0; i < pArray->GetSize(); i++ )
				{
					Script::CStruct* pSubParams = pArray->GetStructure( i );
				
					pSubParams->GetText( Crc::ConstCRC("src"), &pSrcTexture, Script::ASSERT );
					pSubParams->GetText( Crc::ConstCRC("dest"), &pDstTexture, Script::ASSERT );

					// by default, it searches globally in the model for the correct texture
					uint32 partChecksumToReplace = Nx::CModel::vREPLACE_GLOBALLY;
					pSubParams->GetChecksum( Crc::ConstCRC("in"), &partChecksumToReplace, Script::NO_ASSERT );
					if ( mp_model )
					{
						if ( mp_model->ReplaceTexture( partChecksumToReplace, pSrcTexture, pDstTexture ) )
						{
							success = true;
						}
					}
				}
			}
			else
			{
				pParams->GetText( Crc::ConstCRC("src"), &pSrcTexture, Script::ASSERT );
				pParams->GetText( Crc::ConstCRC("dest"), &pDstTexture, Script::ASSERT );

				// by default, it searches globally in the model for the correct texture
				uint32 partChecksumToReplace = Nx::CModel::vREPLACE_GLOBALLY;
				pParams->GetChecksum( Crc::ConstCRC("in"), &partChecksumToReplace, Script::NO_ASSERT );
				if ( mp_model )
				{
					if ( mp_model->ReplaceTexture( partChecksumToReplace, pSrcTexture, pDstTexture ) )
					{
						success = true;
					}
				}
			}
		}
		break;
        		
		// @script | Obj_ReplaceSpriteTexture | Replaces a texture in the model's dictionary
		// @parm text | src | filename of the source texture
		// @parm name | dest | name of the destination texture
		// @parmopt name | in | all | name of geom in which to look for texture (defaults to global replacement)
		// Ex:  Obj_ReplaceSpriteTexture src="knee_l.png" dest=knee_scuff	in=skater_m_legs
		case 0x9a478afe: // Obj_ReplaceSpriteTexture
		{
			const char* pSrcTexture;
			uint32 dest_checksum = 0;

			pParams->GetText( Crc::ConstCRC("src"), &pSrcTexture, Script::ASSERT );
			pParams->GetChecksum( Crc::ConstCRC("dest"), &dest_checksum, Script::ASSERT );

			// by default, it searches globally in the model for the correct texture
			uint32 partChecksumToReplace = Nx::CModel::vREPLACE_GLOBALLY;
			pParams->GetChecksum( Crc::ConstCRC("in"), &partChecksumToReplace, Script::NO_ASSERT );
			if ( mp_model )
			{
				success = mp_model->ReplaceTexture( partChecksumToReplace, pSrcTexture, dest_checksum );
			}
			else
			{
				success = false;
			}
		}
		break;

		// @script | Obj_ClearGeoms | removes the model's geoms
		case 0xbd18e2e3: // Obj_ClearGeoms
			if ( mp_model )
			{
				mp_model->ClearGeoms();
			}
			break;
        
		// @script | Obj_HasModelLights | tests existence of model lights
		case 0xe11f85e8: // Obj_HasModelLights
			{
				Dbg_MsgAssert(mp_model, ("Obj_HasModelLights: CModel is nullptr"));
				
				return mp_model->GetModelLights() ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
			}
			break;

		// @script | Obj_UpdateBrightness | the normal lighting code assumes
		// that the collision code will be run once a frame to copy over
		// the m_ambient_base_color into the m_ambient_mod_color.  unfortunately,
		// the cutscene objects' ref objects don't go through this code, so I had to
		// add this function to explicitly copy over the data...  there's probably
		// a cleaner way to do it, but I didn't want to break the existing code.
		case 0x1c16332e: // Obj_UpdateBrightness
			Dbg_MsgAssert(mp_model, ("Obj_UpdateBrightness: CModel is nullptr"));
			Dbg_MsgAssert(mp_model->GetModelLights(), ("Obj_UpdateBrightness: MovingObject has no model lights"));
			mp_model->GetModelLights()->UpdateBrightness();
			break;

		// @script | Obj_EnableAmbientLight | enables the ambient model light
		case 0xa14d6372: // Obj_EnableAmbientLight
			Dbg_MsgAssert(mp_model, ("Obj_EnableAmbientLight: CModel is nullptr"));
			Dbg_MsgAssert(mp_model->GetModelLights(), ("Obj_EnableAmbientLight: MovingObject has no model lights"));
			mp_model->GetModelLights()->EnableAmbientLight(true);
			break;

		// @script | Obj_DisableAmbientLight | disables the ambient model light
		case 0x8a445e26: // Obj_DisableAmbientLight
			Dbg_MsgAssert(mp_model, ("Obj_DisableAmbientLight: CModel is nullptr"));
			Dbg_MsgAssert(mp_model->GetModelLights(), ("Obj_DisableAmbientLight: MovingObject has no model lights"));
			mp_model->GetModelLights()->EnableAmbientLight(false);
			break;

		// @script | Obj_EnableDiffuseLight | enables a diffuse model light
		// @parm int | index | Light number
		case 0xed5d1550: // Obj_EnableDiffuseLight
		{
			int index;

			if (!pParams->GetInteger(Crc::ConstCRC("index"), &index))
			{
				Dbg_MsgAssert(0, ("Obj_EnableDiffuseLight: Can't find 'index' of light"));
			}

			Dbg_MsgAssert(mp_model, ("Obj_EnableDiffuseLight: CModel is nullptr"));
			Dbg_MsgAssert(mp_model->GetModelLights(), ("Obj_EnableDiffuseLight: MovingObject has no model lights"));
			mp_model->GetModelLights()->EnableDiffuseLight(index, true);
			break;
		}

		// @script | Obj_DisableDiffuseLight | disables a diffuse model light
		// @parm int | index | Light number
		case 0xc6542804: // Obj_DisableDiffuseLight
		{
			int index;

			if (!pParams->GetInteger(Crc::ConstCRC("index"), &index))
			{
				Dbg_MsgAssert(0, ("Obj_DisableDiffuseLight: Can't find 'index' of light"));
			}

			Dbg_MsgAssert(mp_model, ("Obj_DisableDiffuseLight: CModel is nullptr"));
			Dbg_MsgAssert(mp_model->GetModelLights(), ("Obj_DisableDiffuseLight: MovingObject has no model lights"));
			mp_model->GetModelLights()->EnableDiffuseLight(index, false);
			break;
		}

		// @script | Obj_SetLightAmbientColor | Sets the model light ambient color
		// @parm int | r | Red
		// @parm int | g | Green
		// @parm int | b | Blue
		case 0x3cf63049: // Obj_SetLightAmbientColor
		{
			int r, g, b;
			if (!pParams->GetInteger(Crc::ConstCRC("r"), &r))
			{
				Dbg_MsgAssert(0, ("Obj_SetLightAmbientColor: Can't find 'r' color"));
			}
			if (!pParams->GetInteger(Crc::ConstCRC("g"), &g))
			{
				Dbg_MsgAssert(0, ("Obj_SetLightAmbientColor: Can't find 'g' color"));
			}
			if (!pParams->GetInteger(Crc::ConstCRC("b"), &b))
			{
				Dbg_MsgAssert(0, ("Obj_SetLightAmbientColor: Can't find 'b' color"));
			}

			Image::RGBA rgb((uint8)r, (uint8)g, (uint8)b, 0x80);

			Dbg_MsgAssert(mp_model, ("Obj_SetLightAmbientColor: CModel is nullptr"));
			Dbg_MsgAssert(mp_model->GetModelLights(), ("Obj_SetLightAmbientColor: MovingObject has no model lights"));
			mp_model->GetModelLights()->SetLightAmbientColor(rgb);
			mp_model->GetModelLights()->EnableAmbientLight(true);
			
			break;
		}

		// @script | Obj_SetLightDirection | Sets the unit direction vector of a model light
		// @parm int | index | Light number
		// @parm vector | direction | Unit direction vector (overrides heading and pitch)
		// @parm float | heading | Heading angle (in degrees)
		// @parm float | pitch | Pitch angle (in degrees)
		case 0x46a1f4a4: // Obj_SetLightDirection
		{
			int index;

			if (!pParams->GetInteger(Crc::ConstCRC("index"), &index))
			{
				Dbg_MsgAssert(0, ("Obj_SetLightDirection: Can't find 'index' of light"));
			}

			float heading, pitch;
			Mth::Vector direction(0, 0, 1, 0);
			if (pParams->GetVector(Crc::ConstCRC("direction"), &direction))
			{
				direction[W] = 0.0f;		// This is the only way to force this to be a vector (as opposed to a point)
				//Dbg_Message("************ direction (%f, %f, %f)", direction[X], direction[Y], direction[Z]);
			}
			else if (pParams->GetFloat(Crc::ConstCRC("heading"), &heading) && pParams->GetFloat(Crc::ConstCRC("pitch"), &pitch)) 
			{
				direction.RotateX(Mth::DegToRad(pitch));
				direction.RotateY(Mth::DegToRad(heading));
				//Dbg_Message("************ heading and pitch direction (%f, %f, %f)", direction[X], direction[Y], direction[Z]);
			}
			else
			{
				Dbg_MsgAssert(0, ("Obj_SetLightDirection: Can't find 'direction' or 'heading' and 'pitch' of light"));
			}

			Dbg_MsgAssert(mp_model, ("Obj_SetLightDirection: CModel is nullptr"));
			Dbg_MsgAssert(mp_model->GetModelLights(), ("Obj_SetLightDirection: MovingObject has no model lights"));
			mp_model->GetModelLights()->SetLightDirection(index, direction);

			break;
		}

		// @script | Obj_SetLightDiffuseColor | Sets a model light diffuse color
		// @parm int | index | Light number
		// @parm int | r | Red
		// @parm int | g | Green
		// @parm int | b | Blue
		case 0x70e6466b: // Obj_SetLightDiffuseColor
		{
			int index;

			if (!pParams->GetInteger(Crc::ConstCRC("index"), &index))
			{
				Dbg_MsgAssert(0, ("Obj_SetLightDiffuseLight: Can't find 'index' of light"));
			}

			int r, g, b;
			if (!pParams->GetInteger(Crc::ConstCRC("r"), &r))
			{
				Dbg_MsgAssert(0, ("Obj_SetLightDiffuseColor: Can't find 'r' color"));
			}
			if (!pParams->GetInteger(Crc::ConstCRC("g"), &g))
			{
				Dbg_MsgAssert(0, ("Obj_SetLightDiffuseColor: Can't find 'g' color"));
			}
			if (!pParams->GetInteger(Crc::ConstCRC("b"), &b))
			{
				Dbg_MsgAssert(0, ("Obj_SetLightDiffuseColor: Can't find 'b' color"));
			}

			Image::RGBA rgb((uint8)r, (uint8)g, (uint8)b, 0x80);

			Dbg_MsgAssert(mp_model, ("Obj_SetLightDiffuseColor: CModel is nullptr"));
			Dbg_MsgAssert(mp_model->GetModelLights(), ("Obj_SetLightDiffuseColor: MovingObject has no model lights"));
			mp_model->GetModelLights()->SetLightDiffuseColor(index, rgb);
			mp_model->GetModelLights()->EnableDiffuseLight(index, true);
			break;
		}

		// @script | Obj_SetUVOffset | Sets the UV offset of a material pass
		// @parm name | material | material name
		// @parm int | pass | material pass
		// @parm float | u | u offset
		// @parm float | v | v offset
		case 0x57eb306e: // Obj_SetUVOffset
		{
			uint32 mat_checksum;
			if (!pParams->GetChecksum(Crc::ConstCRC("material"), &mat_checksum))
			{
				Dbg_MsgAssert(0, ("Can't find parameter material"));
			}

			// Extract all the parameters
			int pass = 0;
			float u_offset;
			float v_offset;
			bool found_all;

			found_all  = pParams->GetFloat(Crc::ConstCRC("u"), &u_offset);
			found_all &= pParams->GetFloat(Crc::ConstCRC("v"), &v_offset);
			found_all &= pParams->GetInteger(Crc::ConstCRC("pass"), &pass);

			Dbg_MsgAssert(found_all, ("Missing one or more of the wibble offset parameters.  Must fill them all out."));

			Dbg_MsgAssert(mp_model, ("Obj_SetUVOffset: CModel is nullptr"));
			mp_model->SetUVOffset(mat_checksum, pass, u_offset, v_offset);

			break;
		}

		// @script | Obj_SetUVParams | Sets the UV parameters of a material pass
		// @parm name | material | material name
		// @parm int | pass | material pass
		// @parmopt float | uoff | 0.0 | u offset
		// @parmopt float | voff | 0.0 | v offset
		// @parmopt float | uscale | 1.0 | u scale
		// @parmopt float | vscale | 1.0 | v scale
		// @parmopt float | rot | 0.0 | rotation in degrees
		case 0x812ff44d: // Obj_SetUVParams
		{
			uint32 mat_checksum;
			int pass;
			if (!pParams->GetChecksum(Crc::ConstCRC("material"), &mat_checksum))
			{
				Dbg_MsgAssert(0, ("Can't find parameter material"));
			}
			if (!pParams->GetInteger(Crc::ConstCRC("pass"), &pass))
			{
				Dbg_MsgAssert(0, ("Can't find parameter pass"));
			}

			// Clear matrix
			Mth::Matrix mat;
			mat.Ident();

			// Scaling
			float uscale = 1.0f;
			float vscale = 1.0f;
			bool scale = pParams->GetFloat(Crc::ConstCRC("uscale"), &uscale);
			scale = pParams->GetFloat(Crc::ConstCRC("vscale"), &vscale) || scale;
			if (scale)
			{
				Dbg_MsgAssert((uscale >= 0.0f) && (vscale >= 0.0f), ("Obj_SetUVParams: Don't use negative scales."));

				mat[0][0] *= uscale;
				mat[1][1] *= vscale;
			}

			// Rotation
			float rot_deg;
			if (pParams->GetFloat(Crc::ConstCRC("rot"), &rot_deg))
			{
				mat.RotateZ(Mth::DegToRad(rot_deg));
			}

			// Offset
			float uoffset = 0.0f;
			float voffset = 0.0f;
			bool translate = pParams->GetFloat(Crc::ConstCRC("uoff"), &uoffset);
			translate = pParams->GetFloat(Crc::ConstCRC("voff"), &voffset) || translate;
			if (translate)
			{
				mat[3][0] = uoffset;
				mat[3][1] = voffset;
			}

			Dbg_MsgAssert(mp_model, ("Obj_SetUVParams: CModel is nullptr"));
			mp_model->SetUVMatrix(mat_checksum, pass, mat);

			break;
		}
        // @script | EnableDisplayFlip | 
		case 0x721184c7: // EnableDisplayFlip
			mFlipDisplayMatrix=true;
			break;

        // @script | DisableDisplayFlip | 
		case 0x4af3b1f7: // DisableDisplayFlip
			mFlipDisplayMatrix=false;
			break;

        // @script | Obj_InitModel | 
		case 0x4d8e11ab: // Obj_InitModel
			InitModel( pParams );
			break;
			
        // @script | SwitchOffAtomic | 
        // @uparm name | geom name
		case 0xe48fd084: // SwitchOffAtomic
		{
			uint32 atomicName;
			pParams->GetChecksum( NONAME, &atomicName, Script::ASSERT );
			HideGeom(atomicName, true, true);
		}
		break;

        // @script | SwitchOnAtomic | 
        // @uparm name | geom name
		case 0x07d0c128: // SwitchOnAtomic
		{
			uint32 atomicName;
			pParams->GetChecksum( NONAME, &atomicName, Script::ASSERT );
			HideGeom(atomicName, false, true);
		}
		break;

        // @script | AtomicIsHidden | 
        // @uparm name | geom name
        case 0xe7fa7dd0: // AtomicIsHidden
		{
			uint32 atomicName;
			pParams->GetChecksum( NONAME, &atomicName, Script::ASSERT );
            if (GeomHidden( atomicName ))
                pScript->GetParams()->AddInteger(Crc::ConstCRC("hidden"), 1);
            else
                pScript->GetParams()->AddInteger(Crc::ConstCRC("hidden"), 0);
		}
		break;
		
		// @script | Obj_InitModelFromProfile | used for loading up peds and re-initializing the preview model
		case 0x98ed5c8b: // Obj_InitModelFromProfile
		{
			if ( mp_model )
			{
				int texDictOffset = 0;
				pParams->GetInteger( Crc::ConstCRC("texDictOffset"), &texDictOffset, Script::NO_ASSERT );

				int useAssetManager = 0;
				pParams->GetInteger( Crc::ConstCRC("use_asset_manager"), &useAssetManager, Script::NO_ASSERT );

				Script::CStruct* pAppearanceParams;
				pParams->GetStructure( Crc::ConstCRC("struct"), &pAppearanceParams, Script::ASSERT );

				uint32 buildScript = 0;
				pParams->GetChecksum( Crc::ConstCRC("buildscript"), &buildScript, Script::NO_ASSERT );
				
				// load the skeleton (do i really need to do a sanity check here?)
//              Dbg_MsgAssert( GetSkeleton(), ( "Object has no skeleton" ) )

				Gfx::CModelAppearance theAppearance;
				theAppearance.Load( pAppearanceParams, true );
				InitModelFromProfile( &theAppearance, useAssetManager, texDictOffset, buildScript );
			}
		}
		break;
		
		// @script | Obj_SetBoundingSphere | sets a sphere with the specified radius (assumes position is 0,0,0)
		// @uparm float | radius of bounding sphere
		case 0x452fb315:  // Obj_SetBoundingSphere
		{	
			float radius;
			pParams->GetFloat( NONAME, &radius, Script::ASSERT );
			
			// take the existing position, and change the radius on it
			Mth::Vector newSphere( 0.0f, 0.0f, 0.0f, radius );
			
			SetBoundingSphere( newSphere );
		}
		break;

		// @script | Obj_RestoreBoundingSphere | resets the sphere to whatever it was after the model was initialized
		case 0x5b41da8f:  // Obj_RestoreBoundingSphere
		{
			SetBoundingSphere( m_original_bounding_sphere );
		}
		break;
		
        // @script | RotateDisplay | 
        // @parmopt float | Duration | 0.0 | Duration time (default is ms) The rotation will take this much time to complete.
        // @flag seconds | Units of seconds
        // @flag frames | Units of frames
        // @flag x | Rotate about the x-axis
        // @flag y | Rotate about the y-axis
        // @flag z | Rotate about the z-axis
        // @parmopt float | StartAngle | 0.0 | Start angle, in degrees. The skater will instantly pop to this angle
		// when the RotateDisplay command is issued.
        // @parmopt float | EndAngle | 360.0 | End angle, in degrees. The skater will rotate from
		// the start angle to the end angle over the time period specified by Duration.
        // @parmopt int | SinePower | 0 | If set to zero (the default) the angle will change at a constant speed over
		// the specified duration.
		// A SinePower of 1 makes the speed start instantly but slow down smoothly at the end.
		// A SinePower of greater than one will make the speed smoothly accelerate from zero to a maximum, then
		// smoothly decelerate to zero. Values of 2,3 or 4 seem to work best.
		// A SinePower of -1 will make the speed smoothly accelerate from zero to a constant value. It will not
		// decelerate at the end.
		// Note that the final constant speed will be 1.5707 times the constant speed that would be have been used
		// if the SinePower was 0. The speed has to be a bit higher to make up for the smooth acceleration at the start
		// whilst keeping within the same Duration value.
		// So, if you want to follow with another RotateDisplay that maintains that constant speed, you will need to
		// divide it's duration by 1.5707, for example:
		// RotateDisplay y Duration=3 seconds EndAngle=(360*4) SinePower=-1
		// Wait 3 seconds
		// RotateDisplay y Duration=(3/1.5707) seconds EndAngle=(360*4) SinePower=0
		// @parmopt vector | RotationOffset | (0,30,0) | The offset of the point about which to rotate the skater.
		// @flag HoldOnLastAngle | If specified then the rotation will not pop back to what it was at
		// the end of the duration, but will stick until a CancelRotateDisplay command is issued.
		case 0xa4c25c2f: // RotateDisplay
		{
			#ifdef __USER_DAN__
			printf("RotateDisplay\n");
			Script::PrintContents(pParams);
			#endif
			
			float duration = 0.0f;
			pParams->GetFloat(Crc::ConstCRC("Duration"), &duration);
			if (pParams->ContainsFlag(Crc::ConstCRC("Seconds")) || pParams->ContainsFlag(Crc::ConstCRC("Second")))
			{
				// Convert from seconds to milliseconds
				duration *= 1000.0f;
			}
			else if (pParams->ContainsFlag(Crc::ConstCRC( "Frames")) || pParams->ContainsFlag(Crc::ConstCRC("Frame")))
			{
				// Convert from frames to milliseconds
				duration = duration * 1000.0f / 60.0f;
			}
			else
			{
				// Milliseconds is what we want, so nothing to do.
			}
			
			float start_angle = 0.0f;
			pParams->GetFloat(Crc::ConstCRC("StartAngle"), &start_angle);
			
			float end_angle = 0.0f;
			pParams->GetFloat(Crc::ConstCRC("EndAngle"), &end_angle);

			int sine_power = 0;
			pParams->GetInteger(Crc::ConstCRC("SinePower"), &sine_power);
			
			m_display_rotation_offset.Set(0.0f, 30.0f, 0.0f);
			pParams->GetVector(Crc::ConstCRC("RotationOffset"), &m_display_rotation_offset);

			bool hold_on_last_angle = pParams->ContainsFlag(Crc::ConstCRC("HoldOnLastAngle"));
			
			Tmr::Time start_time = Tmr::ElapsedTime(0);
			
			char flags = 0;
			if (pParams->ContainsFlag(Crc::ConstCRC("X")))
			{
				flags |= 1;
				mpDisplayRotationInfo[0].SetUp(duration,
											   start_time,
											   start_angle,
											   end_angle - start_angle,
											   sine_power,
											   hold_on_last_angle);
			}	
			if (pParams->ContainsFlag(Crc::ConstCRC( "Y")))
			{
				flags |= 2;
				mpDisplayRotationInfo[1].SetUp(duration,
											   start_time,
											   start_angle,
											   end_angle - start_angle,
											   sine_power,
											   hold_on_last_angle);
			}	
			if (pParams->ContainsFlag(Crc::ConstCRC("Z")))
			{
				flags |= 4;
				mpDisplayRotationInfo[2].SetUp(duration,
											   start_time,
											   start_angle,
											   end_angle - start_angle,
											   sine_power,
											   hold_on_last_angle);
			}
				
			// if our object is associated with a local player, send a MsgRotateDisplay message
			GameNet::Manager* gamenet_man = GameNet::Manager::Instance();
			GameNet::PlayerInfo* player = gamenet_man->GetPlayerByObjectID(GetObj()->GetID());
			if (player && player->IsLocalPlayer())
			{
				Net::Client* client;
				GameNet::MsgRotateDisplay msg;
				Net::MsgDesc msg_desc;
				
				client = gamenet_man->GetClient( player->GetSkaterNumber() );
				Dbg_Assert( client );
	
				//msg.m_Time = client->m_Timestamp;
				msg.m_Duration = static_cast< int >( duration );
				msg.m_StartAngle = static_cast< short >( start_angle );
				msg.m_DeltaAngle = static_cast< short >( end_angle - start_angle );
				msg.m_SinePower = static_cast< int >( sine_power );
				msg.m_ObjId = (char)GetObj()->GetID();
				msg.m_HoldOnLastAngle = hold_on_last_angle;
				msg.m_Flags = flags;
	
				msg_desc.m_Data = &msg;
				msg_desc.m_Length = sizeof( GameNet::MsgRotateDisplay );
				msg_desc.m_Id = GameNet::MSG_ID_ROTATE_DISPLAY;
				client->EnqueueMessageToServer( &msg_desc );
			}
		}
		break;
		
        // @script | CancelRotateDisplay | Instantly cancels any rotation due to a RotateDisplay
		// command.
		case 0x4424c267: // CancelRotateDisplay
		{
			mpDisplayRotationInfo[0].Clear();
			mpDisplayRotationInfo[1].Clear();
			mpDisplayRotationInfo[2].Clear();
				
			// if our object is associated with a local player, send a MsgRotateDisplay message
			GameNet::Manager* gamenet_man = GameNet::Manager::Instance();
			GameNet::PlayerInfo* player = gamenet_man->GetPlayerByObjectID(GetObj()->GetID());
			if (player && player->IsLocalPlayer())
			{
				Net::Client* client;
				GameNet::MsgObjMessage msg;
				Net::MsgDesc msg_desc;
				
				client = gamenet_man->GetClient( player->GetSkaterNumber() );
				Dbg_Assert( client );
	
				//msg.m_Time = client->m_Timestamp;
				msg.m_ObjId = (char)GetObj()->GetID();
	
				msg_desc.m_Data = &msg;
				msg_desc.m_Length = sizeof( GameNet::MsgObjMessage );
				msg_desc.m_Id = GameNet::MSG_ID_CLEAR_ROTATE_DISPLAY;
				client->EnqueueMessageToServer( &msg_desc );
			}
		}
		break;

		default:
            return CBaseComponent::MF_NOT_EXECUTED;
    }

    return success ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CModelComponent::GetDebugInfo(Script::CStruct *p_info)
{
#ifdef	__DEBUG_CODE__
	Dbg_MsgAssert(p_info,("nullptr p_info sent to CModelComponent::GetDebugInfo"));
	// we call the base component's GetDebugInfo, so we can add info from the common base component										 
	CBaseComponent::GetDebugInfo(p_info);	  
	
	p_info->AddChecksum(Crc::ConstCRC("filename"),mp_model->GetFileName());
	
	Mth::Vector scale=mp_model->GetScale();
	p_info->AddVector(Crc::ConstCRC("scale"),scale.GetX(),scale.GetY(),scale.GetZ());
	
	uint32 mode=Crc::ConstCRC("Unknown");
	switch (mp_model->GetRenderMode())
	{
		case Nx::vTEXTURED:	 	mode=Crc::ConstCRC("vTEXTURED"); break;
		case Nx::vSKELETON:		mode=Crc::ConstCRC("vSKELETON"); break;
		case Nx::vGOURAUD:		mode=Crc::ConstCRC("vGOURAUD"); break;
		case Nx::vFLAT:			mode=Crc::ConstCRC("vFLAT"); break;
		case Nx::vWIREFRAME:	mode=Crc::ConstCRC("vWIREFRAME"); break;
		case Nx::vBBOX:			mode=Crc::ConstCRC("vBBOX"); break;
		case Nx::vNONE:			mode=Crc::ConstCRC("vNONE"); break;
		default:
			break;
	}	
	p_info->AddChecksum(Crc::ConstCRC("RenderMode"),mode);		
#endif				 
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// Mick:  This function actually gets called TWICE when a model is created
// Once from the call to Teleport which is called from the CCOmpositeObject::Teleport functions
// and then once from InitModelFromProfile(), whcih is called after the model is finalized.
// Only on the second call will the model have its geometry set up correctly.
// This does not seem to cause problems, but should probably be re-worked for future iterations of the
// engine.
void CModelComponent::FinalizeModelInitialization()
{
	// need to synchronize rendered model's position to initial world position
	Update();

	if ( mp_model && mp_model->GetModelLights() )
	{
		UpdateBrightness();
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CModelComponent::RefreshModel( Gfx::CModelAppearance* pAppearance, uint32 buildScript )
{
	if ( mp_model )
	{
		// it doesn't matter whether we use the asset manager
		// or which texture dict offset we use, because
		// the build script will only affect colors...
		bool dummyUseAssetManager = true;
		int dummyTexDictOffset = 0;

		InitModelFromProfile( pAppearance, dummyUseAssetManager, dummyTexDictOffset, buildScript );
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
void SDisplayRotationInfo::Clear()
{
	SDisplayRotation *p_rotation=mpRotations;
	for (int i=0; i<MAX_ROTATIONS; ++i)
	{
		p_rotation->Clear();
		++p_rotation;
	}	
	m_active = false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void SDisplayRotationInfo::SetUp(float duration, Tmr::Time start_time, float start_angle, float change_in_angle, int sine_power, bool holdOnLastAngle)
{
	SDisplayRotation *p_rotation=mpRotations;
	for (int i=0; i<MAX_ROTATIONS; ++i)
	{
		if (!p_rotation->mDispRotating)
		{
			p_rotation->SetUp(duration, start_time, start_angle, change_in_angle, sine_power, holdOnLastAngle);
			m_active = true;
			return;
		}	
		++p_rotation;
	}	
	
	//Dbg_MsgAssert(0,("Too many rotations overlaid at once, maximum is %d",SDisplayRotationInfo::MAX_ROTATIONS));
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

float SDisplayRotationInfo::CalculateNewAngle()
{
	float new_angle = 0.0f;
	if (m_active)
	{
		m_active = false;
		SDisplayRotation *p_rotation = mpRotations;
		for (int i = 0; i < MAX_ROTATIONS; ++i)
		{
			if (p_rotation->mDispRotating)
			{
				m_active = true;
				new_angle += p_rotation->CalculateNewAngle();
			}
			++p_rotation;
		}
	}	
	return new_angle;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void SDisplayRotation::Clear()
{
	mDispRotating=false;
	mHoldOnLastAngle=false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void SDisplayRotation::SetUp(float duration, Tmr::Time start_time, float start_angle, float change_in_angle, int sine_power, bool holdOnLastAngle)
{
	mDispRotating=true;
	mDispDuration=duration;
	mDispStartTime=start_time;
	mDispStartAngle=start_angle;
	mDispChangeInAngle=change_in_angle;
	mDispSinePower=sine_power;
	mHoldOnLastAngle=holdOnLastAngle;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

float SDisplayRotation::CalculateNewAngle()
{
	float new_angle=0.0f;
	
	if (mDispRotating)
	{
		float t = (float)(Tmr::ElapsedTime(0) - mDispStartTime);
		if (t > mDispDuration)
		{
			if (mHoldOnLastAngle)
			{
				// Stick forever on the end angle, until the mHoldOnLastAngle gets reset
				// by a CancelRotateDisplay script command.
				new_angle = mDispStartAngle+mDispChangeInAngle;
			}
			else
			{
				mDispRotating = false;
			}	
		}
		else
		{
			if (mDispSinePower)
			{
				float s;
				if (mDispSinePower < 0)
				{
					// If a negative sine power is specified, then use an upside-down and
					// back-to-front sine wave. This gives a rotation which smoothly accelerates
					// to a constant speed.
					s = 1.0f - sinf(1.570796327f - t * 1.570796327f / mDispDuration);
				}
				else
				{
					s = sinf(t * 1.570796327f / mDispDuration);
					for (int i=0; i < mDispSinePower - 1; ++i)
					{
						s = s * s;
					}
				}	
				new_angle = mDispStartAngle + s * mDispChangeInAngle;
			}
			else
			{
				new_angle = mDispStartAngle + t * mDispChangeInAngle / mDispDuration;
			}	
		}	
	}	
	
	return new_angle;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

uint32 CModelComponent::GetRefObjectName()
{
	Dbg_MsgAssert( m_hasRefObject, ( "Object %s doesn't have a ref object", Script::FindChecksumName(GetObj()->GetID()) ) );
				  
	return m_refObjectName;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CModelComponent::ApplyLightingFromCollision( CFeeler& feeler )
{
	if (!feeler.IsBrightnessAvailable()) return;
	
	if (Nx::CModelLights* p_model_lights = GetModel()->GetModelLights())
	{
		p_model_lights->SetBrightness(feeler.GetBrightness());
	}
	else
	{
		Nx::CLightManager::sSetBrightness(feeler.GetBrightness());
	}
}
									 
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CModelComponent::ApplySceneLighting( Image::RGBA color )
{
	// Mick: if the model is a level object, then apply the scene lighthing to it
	if (m_isLevelObject)
	{
		mp_model->GetGeomByIndex(0)->SetColor(color);
	}
}
									 
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
									 
}

#if 0
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// GJ TODO:  these cheat codes are kind of kludgy 
// and should be re-implemented later in a more 
// component-friendly format.

bool apply_cheat_scale( Gfx::CSkeleton* pSkeleton, Nx::CModel* pModel, uint32 cheatName, uint32 bodyShapeName, uint32 animScriptName )
{
	int flag = Script::GetInteger( cheatName, Script::ASSERT );
	
	if ( Mdl::Skate::Instance()->GetCareer()->GetGlobalFlag(flag) )
	{
		Dbg_Assert( pModel );

		if ( animScriptName == Crc::ConstCRC("animload_human") 
			 || animScriptName == Crc::ConstCRC("animload_ped_f") )
		{
			Dbg_MsgAssert( pSkeleton, ( "Skeleton has not been assigned to this model yet" ) );
			Script::CStruct* pBodyShapeStructure = Script::GetStructure( bodyShapeName, Script::ASSERT );
			
			Mth::Vector theScale( 1.0f, 1.0f, 1.0f );
			if ( Gfx::GetScaleFromParams( &theScale, pBodyShapeStructure ) )
			{
				Mth::Vector vec = pModel->GetScale();
				
				vec[X] *= theScale[X];
				vec[Y] *= theScale[Y];
				vec[Z] *= theScale[Z];

				// if the body shape has a scale
				pModel->SetScale( vec );
			}

			pSkeleton->ApplyBoneScale( pBodyShapeStructure );
		}
	
		return true;
	}

	return false;
}
#endif
