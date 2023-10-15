#include "texdictasset.h"

#include <Gfx/NxTexMan.h>

namespace Ass {

	int CTexDictAsset::Load(const char *p_file, bool async_load, bool use_pip, void *pExtraData, Script::CStruct *pStruct)
	{
		// Load texdict
		Nx::CTexDict *dict = Nx::CTexDictManager::sLoadTextureDictionary(p_file, false, 0, false, false);
		Dbg_MsgAssert(dict != nullptr, ("Failed to load texture dictionary"));
		SetData((void*)dict);


		return 0;
	}

	int CTexDictAsset::Load(uint32 *p_data, int data_size)
	{
		return 1;
	}

	int CTexDictAsset::Unload()
	{
		return 1;
	}

	int CTexDictAsset::Reload(const char *p_file)
	{
		return 1;
	}

	bool CTexDictAsset::LoadFinished()
	{
		return true;
	}

	const char *CTexDictAsset::Name()
	{
		return "TexDict";
	}

	EAssetType CTexDictAsset::GetType()
	{
		return ASSET_TEXTURES;
	}

}