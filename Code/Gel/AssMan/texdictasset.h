#pragma once

#include <Core/Defines.h>

#include <Gel/AssMan/asset.h>

namespace Ass {

class CTexDictAsset : public CAsset
{
public:
	virtual int 		Load(const char *p_file, bool async_load, bool use_pip, void *pExtraData, Script::CStruct *pStruct);	// create or load the asset
	virtual int 		Load(uint32 *p_data, int data_size);	// create or load the asset
	virtual int 		Unload();                     // Unload the asset
	virtual int 		Reload(const char *p_file);
	virtual bool		LoadFinished();    // Check to make sure asset is actually there
	virtual const char *Name();            // printable name, for debugging
	virtual EAssetType 	GetType();         // type is hard wired into asset class 
private:
	char m_name[0x80];
};

}