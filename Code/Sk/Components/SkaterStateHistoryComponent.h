//****************************************************************************
//* MODULE:         Sk/Components
//* FILENAME:       SkaterStateHistoryComponent.cpp
//* OWNER:          Dan
//* CREATION DATE:  3/13/3
//****************************************************************************

#ifndef __COMPONENTS_SKATERSTATEHISTORYCOMPONENT_H__
#define __COMPONENTS_SKATERSTATEHISTORYCOMPONENT_H__

#include <core/defines.h>
#include <core/support.h>

#include <gel/object/basecomponent.h>

#include <sk/objects/skater.h>
#include <sk/objects/rail.h>
#include <gfx/nxflags.h>

#define		CRC_SKATERSTATEHISTORY Crc::ConstCRC("SkaterStateHistory")

#define		GetSkaterStateHistoryComponent() ((Obj::CSkaterStateHistoryComponent*)GetComponent(CRC_SKATERSTATEHISTORY))
#define		GetSkaterStateHistoryComponentFromObject(pObj) ((Obj::CSkaterStateHistoryComponent*)(pObj)->GetComponent(CRC_SKATERSTATEHISTORY))

namespace Script
{
    class CScript;
    class CStruct;
}

namespace Net
{
	class MsgHandlerContext;
}
              
namespace Obj
{

struct SPosEvent
{
	SPosEvent() = default;
	SPosEvent(const SPosEvent &rhs) = default;
	SPosEvent& operator=(const SPosEvent &rhs) = default;

	uint32			GetTime( void );
	void			SetTime( uint32 time );

	short			ShortPos[3] = {};
	Mth::Matrix		Matrix;
	Mth::Vector		Position;
	Mth::Vector		Eulers;
	Flags< int >	SkaterFlags;
	Flags< int >	EndRunFlags;
	int				State = 0;
	char			DoingTrick = 0;
	char			Walking = 0;
	char			Driving = 0;
	uint16			LoTime = 0;
	uint16			HiTime = 0;
	ETerrainType	Terrain = vTERRAIN_DEFAULT;
	size_t			RailNode = Obj::vNULL_RAIL;
};

struct SAnimEvent
{
	SAnimEvent() = default;
	SAnimEvent(const SAnimEvent &rhs) = default;
	SAnimEvent& operator=(const SAnimEvent &rhs) = default;

	uint32			GetTime( void );
	void			SetTime( uint32 time );

	char			m_MsgId = 0;
	char			m_ObjId = 0;
	char			m_LoopingType = 0;
	char			m_Flags = 0;
	uint16			m_LoTime = 0;
	uint16			m_HiTime = 0;
	bool			m_Flipped = 0;
	bool			m_Rotate = 0;
	bool			m_Hide = 0;
	float			m_Alpha = 0.0f;
	float			m_StartTime = 0.0f;
	float			m_EndTime = 0.0f;
	float			m_BlendPeriod = 0.0f;
	float 			m_Speed = 0.0f;
	uint32			m_Asset = 0;
	uint32			m_Bone = 0;
	float			m_WobbleAmpA = 0.0f;
	float			m_WobbleAmpB = 0.0f;
	float			m_WobbleK1 = 0.0f;
	float			m_WobbleK2 = 0.0f;
	float			m_SpazFactor = 0.0f;
	int 			m_Duration = 0;
	int 			m_SinePower = 0;
	int				m_Index = 0;
	float 			m_StartAngle = 0.0f;
	float 			m_DeltaAngle = 0.0f;
	bool			m_HoldOnLastAngle = 0;
};

class CSkaterStateHistoryComponent : public CBaseComponent
{
public:
	enum
	{
		vNUM_POS_HISTORY_ELEMENTS = 20,
		vNUM_ANIM_HISTORY_ELEMENTS = 20
	};
	
public:
    CSkaterStateHistoryComponent();
    virtual ~CSkaterStateHistoryComponent();

public:
    virtual void            		Update();
    virtual void            		InitFromStructure( Script::CStruct* pParams );
    virtual void            		RefreshFromStructure( Script::CStruct* pParams );
    
    virtual EMemberFunctionResult   CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript );
	virtual void 					GetDebugInfo( Script::CStruct* p_info );

	static CBaseComponent*			s_create();
	
	CSkater*						GetSkater() { return static_cast< CSkater* >(GetObj()); }
	
	static int						sHandleCollision ( Net::MsgHandlerContext* context );
	static int						sHandleProjectileHit ( Net::MsgHandlerContext* context );
	
	SPosEvent*						GetPosHistory (   ) { return mp_pos_history; }
	SPosEvent*						GetLatestPosEvent (   ) { return &mp_pos_history[m_num_pos_updates % vNUM_POS_HISTORY_ELEMENTS]; }
	SPosEvent*						GetLastPosEvent (   ) { return &mp_pos_history[(m_num_pos_updates + ( vNUM_POS_HISTORY_ELEMENTS - 1 )) % vNUM_POS_HISTORY_ELEMENTS]; }
	void							IncrementNumPosUpdates (   ) { m_num_pos_updates++; }
	void							ResetPosHistory (   ) { m_num_pos_updates = 0; }
	int								GetNumPosUpdates (   ) { return m_num_pos_updates; }
	
	uint32							GetLatestAnimTimestamp( void );
	void							SetLatestAnimTimestamp( uint32 timestamp );
	SAnimEvent*						GetAnimHistory (   ) { return mp_anim_history; }
	SAnimEvent*						GetLatestAnimEvent (   ) { return &mp_anim_history[m_num_anim_updates % vNUM_ANIM_HISTORY_ELEMENTS]; }
	SAnimEvent*						GetLastAnimEvent (   ) { return &mp_anim_history[(m_num_anim_updates + ( vNUM_ANIM_HISTORY_ELEMENTS - 1 )) % vNUM_ANIM_HISTORY_ELEMENTS]; }
	void							IncrementNumAnimUpdates (   ) { m_num_anim_updates++; }
	void							ResetAnimHistory (   ) { m_num_anim_updates = 0; }
	int								GetNumAnimUpdates (   ) { return m_num_anim_updates; }
	
	bool							CheckForCrownCollision (   );
	void							CollideWithOtherSkaters ( int start_index );
	bool							GetCollidingPlayerAndTeam ( Script::CStruct* pParams, Script::CScript* pScript );
	
	void							SetCurrentVehicleControlType ( uint32 control_type ) { m_current_vehicle_control_type = control_type; }
	uint32							GetCurrentVehicleControlType (   ) { return m_current_vehicle_control_type; }
	
private:
	Mth::Vector						get_latest_position (   );
	Mth::Vector						get_last_position (   );
	Mth::Vector						get_vel (   );
	int								get_time_between_last_update (   );
	
	float							get_collision_cylinder_coeff ( bool driving );
	float							get_collision_cylinder_radius ( bool first_driving, bool second_driving );
	
private:
	int								m_num_pos_updates;
	SPosEvent						mp_pos_history [ vNUM_POS_HISTORY_ELEMENTS ];
	
	int								m_num_anim_updates;
	SAnimEvent						mp_anim_history [ vNUM_ANIM_HISTORY_ELEMENTS ];

        uint32							m_last_anm_time;
	// if the non-local client is driving, this control type's model will be used; set via a network message
	uint32							m_current_vehicle_control_type;
};

}

#endif
