/*****************************************************************************
**																			**
**			              Neversoft Entertainment.			                **
**																		   	**
**				   Copyright (C) 2000 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:																**
**																			**
**	Module:			String			 										**
**																			**
**	File name:		stringutils.h											**
**																			**
**	Created by:		05/31/01	-	Mick									**
**																			**
**	Description:	useful string (char *) utilities						**
**																			**
*****************************************************************************/

#pragma once

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <Core/Defines.h>
#include <cstring>

/*****************************************************************************
**								   Defines									**
*****************************************************************************/


namespace Str
{

						


/*****************************************************************************
**							Class Definitions								**
*****************************************************************************/

/*****************************************************************************
**							 Private Declarations							**
*****************************************************************************/

/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/

/*****************************************************************************
**							  Public Declarations							**
*****************************************************************************/

/*****************************************************************************
**							   Public Prototypes							**
*****************************************************************************/

const char*	StrStr(const char* pHay, const char* pNeedle);
void		LowerCase(char* p);
void		UpperCase(char* p);
int			WhiteSpace(char* p);
char *		PrintThousands(int n, char c = ',');
uint 		DehexifyDigit(const char *pLetter);
int 		Compare(const char *p_a, const char *p_b);

/*****************************************************************************
**								Inline Functions							**
*****************************************************************************/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // namespace Str
