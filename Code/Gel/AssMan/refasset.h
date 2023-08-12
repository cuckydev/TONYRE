///////////////////////////////////////////////////////////
// asset.h - base class for managed assets

#pragma once

#include <Core/Defines.h>

#include <Gel/AssMan/asset.h>
#include <Gel/AssMan/assettypes.h>

namespace Ass
{



class 	CRefAsset : public CAsset
{
		friend class CAssMan;
protected:
						CRefAsset(CAsset *p_asset);
						~CRefAsset();
		
		// int 			Load(const char *p_file, bool async_load, bool use_pip, void* pExtraData);	// create or load the asset
		int 			Unload();                  	// Unload the asset
		int 			Reload(const char *p_file);
		bool			LoadFinished();				// Check to make sure asset is actually there
		int  			RamUsage();
		int  			VramUsage();
		int  			SramUsage();
		const char* 	Name();          			// printable name, for debugging
		void      		SetGroup(uint32 group);     // Unique group ID
		uint32    		GetGroup();
		EAssetType	  	GetType();         			// type is hard wired into asset class 
		void     		SetData(void *p_data);      // return a pointer to the asset�.
		void *    		GetData();             		// return a pointer to the asset�.
		void			SetPermanent(bool perm);

private:
		CAsset	*				mp_asset;			// pointer to the actual asset 
		CRefAsset	*			mp_sibling;			// pointer to other CRefAsset that references mp_asset 	
};

//////////////////////////////////////////////////////////////////////////
// Inline member functions																	 
																	 


} // end namespace Ass
