/*****************************************************************************
**																			**
**			              Neversoft Entertainment.			                **
**																		   	**
**				   Copyright (C) 2000 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		Core library											**
**																			**
**	Module:			String      			 								**
**																			**
**	File name:		Core\String\CString.cpp									**
**																			**
**	Created by:		9/20/2000 - rjm							                **
**																			**
**	Description:	A handy, safe class to represent a string				**
**																			**
*****************************************************************************/

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <Core/Defines.h>
#include <Core/String/CString.h>
#include <Sys/Mem/memman.h>

/*****************************************************************************
**								DBG Information								**
*****************************************************************************/

namespace Str
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

const int String::s_max_size = 256;

/*****************************************************************************
**								 Public Data								**
*****************************************************************************/

int String::sDumbCount = 0;

/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/

/*****************************************************************************
**							  Private Functions								**
*****************************************************************************/

/*****************************************************************************
**							  Public Functions								**
*****************************************************************************/

/******************************************************************************
 *
 * Function:	
 *
 * Description: Default constructor			
 *
 * Parameters:	
 * 
 *****************************************************************************/


String::String( void )
: mp_string( nullptr )
{
//    
    
    
    m_dumbNum = sDumbCount;
	sDumbCount++;    
}



/******************************************************************************
 *
 * Description: First copy constructor	
 *              (called by: String x = "blah";) 		
 * 
 *****************************************************************************/

String::String( const char* string )
: mp_string ( nullptr )
{
//    
    
    
    
    m_dumbNum = sDumbCount;
	sDumbCount++;
    
	// call operator= function
    *this = string;

	//Ryan("copy successful\n");
}



/******************************************************************************
 *
 * Description: Second copy constructor			
 * 
 *****************************************************************************/

String::String( const String& string )
: mp_string ( nullptr )
{
//    
    
    
    // call operator= function
    *this = string;

    m_dumbNum = sDumbCount;
	sDumbCount++;
}



/******************************************************************************
 *
 * Description: destructor			
 * 
 *****************************************************************************/

String::~String( void )
{
//    
    
    
	//Ryan("Am deleting string");
	
	if (mp_string)
	{
		delete [] mp_string;
		mp_string = nullptr;
	}

	//Ryan("\n");
	sDumbCount--;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

String & String::operator= (const char * string)
{
//    
    
    
    size_t last_char = 0;
	if ( string )
	{
		last_char = strlen(string);
		if (last_char > 0)
			last_char--;
	}
	copy(string, 0, last_char);

    //Ryan("Copying %s to String\n", mp_string);
    
    return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

String & String::operator= (const String & string)
{
//    
    
    
    Dbg_MsgAssert(this != &string,( "can't assign a String to itself"));
	
	// call other operator= function
    *this = string.mp_string;
    return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool String::operator== (const char * string)
{
//    
    
    
    //Ryan("comparing String to string: %s to %s\n", mp_string, string);
    if (mp_string && string)
	{
		return (strcmp(mp_string, string) == 0); 
	}

	return (!mp_string && !string);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool String::operator== (const String & string)
{
//    
    
    
    //Ryan("comparing String to String: %s to %s\n", mp_string, string.mp_string);
    return (*this == string.mp_string);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool String::operator!()
{
	return (mp_string == nullptr);
}

/******************************************************************************
 *
 * Description: Returns pointer to internal char * array. Maybe should be const.			
 * 
 *****************************************************************************/

const char * String::getString() const
{
//    
    
    
    return mp_string;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void String::copy(const char *pChar, size_t first_char, size_t last_char)
{
	if ( pChar && last_char >= first_char)
	{
// GJ: The following handles 1-byte long strings incorrectly:
//		if ( first_char == last_char )
			
		if ( pChar[first_char] == 0 )
		{
			if (mp_string)
			{
				delete [] mp_string;		
			}
			mp_string = new char[1];
			mp_string[0] = 0;
			m_length = 2;				// MICK-GJ:  Set length to 2, so it matches what we have below
		}
		else
		{
			size_t length = last_char - first_char + 2;
			if (length < 4) length = 4;
			Dbg_MsgAssert (length <= s_max_size,( "string too long for String object"));

			// if current string exists and is smaller than new string, delete it
			if ( mp_string && ( length > m_length ))
			{
				delete [] mp_string;
				mp_string = nullptr;
			}

			// if current string doesn't exist, or has been deleted, make a new one
			if ( !mp_string )
			{
				m_length = length;
				mp_string = new char[m_length];
			}

			// perform string copy
			size_t i = 0;
			for (size_t j = first_char; j <= last_char; j++)
				mp_string[i++] = pChar[j];
			mp_string[i] = '\0';
		}
	}
	else
	{
		if ( mp_string )
		{
			delete [] mp_string;
			mp_string = nullptr;
		}
	}
	
	//Ryan("copied string %s\n", pChar);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // namespace String




