/*****************************************************************************
**																			**
**			              Neversoft Entertainment.			                **
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		PS2														**
**																			**
**	Module:			Core                   									**
**																			**
**	File name:		Core/crc.cpp           									**
**																			**
**	Created by:		03/05/01	-	spg										**
**																			**
**	Description:	Crc functionality      									**
**																			**
*****************************************************************************/

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <core/defines.h>

/*****************************************************************************
**								DBG Information								**
*****************************************************************************/



namespace Crc
{



/*****************************************************************************
**								  Externals									**
*****************************************************************************/

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

/*****************************************************************************
**								Private Types								**
*****************************************************************************/

/*****************************************************************************
**								 Private Data								**
*****************************************************************************/

/*****************************************************************************
**								 Public Data								**
*****************************************************************************/

/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/

/*****************************************************************************
**							   Private Functions							**
*****************************************************************************/

/*****************************************************************************
**							   Public Functions								**
*****************************************************************************/

////////////////////////////////////////////////////////////////////////////////
// Generates a checksum from raw data, given  pointer to that data, and the size
//
// input:
//        const char *stream  = pointer to data
//		  int size            = number of bytes to CRC
//
// output:
//		 returns uint32 = checksum of the data
//       if NULL pointer passed in, or zero size is given, then will return 0
//
uint32 GenerateCRCCaseSensitive( const char *stream, int size )
{
    
    
	// A checksum of zero is used to mean no name.
    if(( !stream ) || ( size <= 0 )) 
	{
		return 0;
	}	
    
    // Initializing the CRC to all one bits avoids failure of detection
	// should entire data stream get cyclically bit-shifted by one position.
	// The calculation of the probability of this happening is left as
	// an exercise for the reader.
	uint32 rc = 0xffffffff;
    for (int i=0; i<size; i++)
    {
        rc = CRCTable[(rc^stream[i]) & 0xff] ^ ((rc>>8) & 0x00ffffff);
    }

	return rc;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// For use when calculating a total checksum of a bunch of chunks of data.
// Currently used when saving out the replay buffer to mem card.
uint32 UpdateCRC( const char *p_stream, int size, uint32 rc )
{
	Dbg_MsgAssert(p_stream,("NULL p_stream"));	
    
    for (int i=0; i<size; i++)
    {
        rc = CRCTable[(rc^p_stream[i]) & 0xff] ^ ((rc>>8) & 0x00ffffff);
    }

	return rc;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// Generates a checksum from a name, case insensitive.
uint32 GenerateCRC( const char *stream, int size )
{
    
    
	// A checksum of zero is used to mean no name.
    if(( !stream ) || ( size <= 0 )) 
	{
		return 0;
	}	
    
    // Initializing the CRC to all one bits avoids failure of detection
	// should entire data stream get cyclically bit-shifted by one position.
	// The calculation of the probability of this happening is left as
	// an exercise for the reader.
	uint32 rc = 0xffffffff;
    for (int i=0; i<size; i++)
    {
        char ch=stream[i];
        // Convert to lower case.
        if (ch>='A' && ch<='Z') 
		{
			ch='a'+ch-'A';
		}	
		// Convert forward slashes to backslashes, otherwise two filenames which are
		// effectively the same but with different slashes will give different checksums.
		if (ch=='/')
		{
			ch='\\';
		}	
		
        rc = CRCTable[(rc^ch) & 0xff] ^ ((rc>>8) & 0x00ffffff);
    }

	return rc;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

uint32 GenerateCRCFromString( const char *pName )
{
	
    // A checksum of zero is used to mean no name.
    if (!pName) 
	{
		return 0;
	}	

    // Initializing the CRC to all one bits avoids failure of detection
	// should entire data stream get cyclically bit-shifted by one position.
	// The calculation of the probability of this happening is left as
	// an exercise for the reader.
	uint32 rc = 0xffffffff;
	const char *pCh=pName;
    while (true)
    {
        char ch=*pCh++;
		if (!ch)
		{
			break;
		}
			
        // Convert to lower case.
        if (ch>='A' && ch<='Z') 
		{
			ch='a'+ch-'A';
		}	
		// Convert forward slashes to backslashes, otherwise two filenames which are
		// effectively the same but with different slashes will give different checksums.
		if (ch=='/')
		{
			ch='\\';
		}	
		
        rc = CRCTable[(rc^ch) & 0xff] ^ ((rc>>8) & 0x00ffffff);
    }

	return rc;
}


// Same as above, but it's calculating the CRC of two strings added together
// but the first string is already CRCed
// essentially it's like jumping into GenerateGRCFromString halfway through
uint32 ExtendCRCWithString( uint32 rc, const char *pName )
{
	
    if (!pName) 
	{
		return rc;
	}	

	const char *pCh=pName;
    while (true)
    {
        char ch=*pCh++;
		if (!ch)
		{
			break;
		}
			
        // Convert to lower case.
        if (ch>='A' && ch<='Z') 
		{
			ch='a'+ch-'A';
		}	
		// Convert forward slashes to backslashes, otherwise two filenames which are
		// effectively the same but with different slashes will give different checksums.
		if (ch=='/')
		{
			ch='\\';
		}	
		
        rc = CRCTable[(rc^ch) & 0xff] ^ ((rc>>8) & 0x00ffffff);
    }

	return rc;
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

uint32 GetCRCTableEntry( int entry )
{
	

	Dbg_Assert(( entry < 256 ) && ( entry >= 0 ));

	return CRCTable[entry];
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // namespace Crc

