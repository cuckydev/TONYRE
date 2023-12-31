///////////////////////////////////////////////////////////////////////////////////////
//
// array.cpp		KSH 22 Oct 2001
//
// CArray class member functions.
//
///////////////////////////////////////////////////////////////////////////////////////

#include <Gel/Scripting/array.h>

DefinePoolableClass(Script::CArray);

namespace Script
{

CArray::CArray()
{
	// Initialise everything. CArray is not derived from CClass so we don't get
	// the auro-zeroing.
	m_type=ESYMBOLTYPE_NONE;
	mp_array_data=nullptr;
	m_size=0;
}

CArray::~CArray()
{
	Clear();
}

bool CArray::operator==( const CArray& v ) const
{
	// TODO ...
	(void)v;
	#ifdef __NOPT_ASSERT__
	printf("CArray comparisons are not supported yet ... implement when needed\n");
	#endif
	return false;
}

bool CArray::operator!=( const CArray& v ) const
{
	return !(*this==v);
}

// Deletes the array buffer if it exists, asserting if it contains any non-nullptr pointers.
// Sets type to NONE and size to 0.
void CArray::Clear()
{
	if (m_size==1)
	{
		// Memory optimization:
		// Special case for size 1. In this case, no memory block has been allocated.
		
		if (m_union)
		{
			// The element is not zero ...
			
			#ifdef __NOPT_ASSERT__
			// Check that no references to things remain in the array.
			switch (m_type)
			{
				case ESYMBOLTYPE_INTEGER:
				case ESYMBOLTYPE_FLOAT:
				case ESYMBOLTYPE_NAME:
					// No need for the user to have zeroed these.
					break;
					
				case ESYMBOLTYPE_STRING:
				case ESYMBOLTYPE_LOCALSTRING:
				case ESYMBOLTYPE_PAIR:
				case ESYMBOLTYPE_VECTOR:
				case ESYMBOLTYPE_STRUCTURE:
				case ESYMBOLTYPE_ARRAY:
				{
					// The array contains a pointer to something.
					// The CArray cannot delete it itself because this would cause cyclic dependencies.
					Dbg_MsgAssert(0,("Tried to delete a CArray that still contains non-nullptr data: size=%d type='%s'",m_size,GetTypeName((uint8)m_type)));
					break;
				}	
				
				default:
					Dbg_MsgAssert(0,("Bad CArray::m_type of '%s'",GetTypeName((uint8)m_type)));
					break;
			}		
			#endif
		
			m_union=0;
		}	
	}
	else
	{
		if (mp_array_data)
		{
			#ifdef __NOPT_ASSERT__
			// Check that no references to things remain in the array.
			switch (m_type)
			{
				case ESYMBOLTYPE_INTEGER:
				case ESYMBOLTYPE_FLOAT:
				case ESYMBOLTYPE_NAME:
					// No need for the user to have zeroed these.
					break;
					
				case ESYMBOLTYPE_STRING:
				case ESYMBOLTYPE_LOCALSTRING:
				case ESYMBOLTYPE_PAIR:
				case ESYMBOLTYPE_VECTOR:
				case ESYMBOLTYPE_STRUCTURE:
				case ESYMBOLTYPE_ARRAY:
				{
					// The array is of pointers, so make sure that the user of CArray has deleted and zeroed these before deleting the array.
					// The CArray cannot delete them itself because this would cause cyclic dependencies.
					for (uint32 i=0; i<m_size; ++i)
					{
						Dbg_MsgAssert(mp_array_data[i] == 0, ("Tried to delete a CArray that still contains non-nullptr data: size=%d type='%s'",m_size,GetTypeName((uint8)m_type)));
					}
					break;
				}	
				
				default:
					Dbg_MsgAssert(0,("Bad CArray::m_type of '%s'",GetTypeName((uint8)m_type)));
					break;
			}		
			#endif
			
			delete[] mp_array_data;
			mp_array_data=nullptr;
		}	
	}
		
	m_type=ESYMBOLTYPE_NONE;
	m_size=0;
}

// Calls Clear, sets the size and type, allocates the buffer if necessary and initialises it to all zeroes.
void CArray::SetSizeAndType(size_t size, ESymbolType type)
{
	if (type == ESYMBOLTYPE_NONE)
		Dbg_Assert(size == 0);
	size_t elem_size = GetElementSize(type);

	Clear();
	m_type=type;
	m_size=size;

	if (size)
	{
		if (size==1)
		{
			Dbg_MsgAssert(m_union==0,("m_union not zero ?"));
			// Nothing to do. No memory block is allocated for arrays of 1 element, to save memory.
		}
		else
		{
			Dbg_MsgAssert(mp_array_data==nullptr,("mp_array_data not nullptr ?"));

			mp_array_data = new char[m_size * elem_size] {};
		}	
	}
	else
	{
		// Make all zero size arrays have type none.
		// Seems a reasonable thing to do, and in particular this fixed an assert in WriteToBuffer
		// after CSkaterCareer::WriteIntoStructure had added an empty array of structures. (The Gaps array)
		m_type=ESYMBOLTYPE_NONE;
	}	
}

void CArray::Resize(size_t newSize)
{
	size_t elem_size = GetElementSize(m_type);

	if (newSize==m_size)
	{
		// Nothing to do
		return;
	}

	Dbg_MsgAssert(newSize>m_size,("Tried to resize CArray to a smaller size, not supported yet ..."));
	// TODO: Make it able to make the CArray smaller, if a need arises. To do, factor out some of the
	// code from CleanUpArray so that the leftover bit can be cleaned up.
	Dbg_MsgAssert(newSize>1,("Resizing arrays to size 1 not supported yet ..."));
	// TODO: Support the above if need be. Need to not allocate a new buffer in that case.
	
	// Allocate the new buffer.
	size_t sizeBytes = m_size * elem_size;
	size_t newSizeBytes = newSize * elem_size;

	char *p_new_buffer = new char[newSizeBytes];
	memcpy(p_new_buffer, mp_array_data, sizeBytes);
	memset(p_new_buffer + sizeBytes, 0, newSizeBytes - sizeBytes);
	
	// Only free mp_array_data if the old size was bigger than 1. 
	// mp_array_data is not allocated for sizes of 1 as a memory optimization.
	if (m_size > 1)
	{
		delete[] mp_array_data;
	}	
	mp_array_data=p_new_buffer;
	
	m_size=newSize;
	Dbg_MsgAssert(m_size>1,("Expected array size to be > 1 ??")); // Just to be sure
}

void *CArray::GetArrayPointer() const
{
	if (m_size==1)
	{
		return (void*)&m_union;
	}
	return (void*)mp_array_data;
}

void CArray::SetString(size_t index, char *p_string)
{
	Dbg_MsgAssert(m_type==ESYMBOLTYPE_STRING,("Called CArray::SetString when m_type was '%s'",GetTypeName((uint8)m_type)));
	Dbg_MsgAssert(index<m_size,("Bad index of %d sent to CArray::SetString, m_size=%d",index,m_size));
	if (m_size==1)
	{
		Dbg_MsgAssert(mp_string==nullptr,("mp_string expected to be nullptr"));
		mp_string=p_string;
	}
	else
	{
		Dbg_MsgAssert(mp_array_data,("nullptr mp_array_data ?"));
		Dbg_MsgAssert(mpp_strings[index]==nullptr,("Non-nullptr pointer in mpp_strings[index]"));
		mpp_strings[index]=p_string;
	}	
}

void CArray::SetLocalString(size_t index, char *p_string)
{
	Dbg_MsgAssert(m_type==ESYMBOLTYPE_LOCALSTRING,("Called CArray::SetLocalString when m_type was '%s'",GetTypeName((uint8)m_type)));
	Dbg_MsgAssert(index<m_size,("Bad index of %d sent to CArray::SetLocalString, m_size=%d",index,m_size));
	if (m_size==1)
	{
		Dbg_MsgAssert(mp_local_string==nullptr,("mp_local_string expected to be nullptr"));
		mp_local_string=p_string;
	}
	else
	{
		Dbg_MsgAssert(mp_array_data,("nullptr mp_array_data ?"));
		Dbg_MsgAssert(mpp_local_strings[index]==nullptr,("Non-nullptr pointer in mpp_local_strings[index]"));
		mpp_local_strings[index]=p_string;
	}	
}

void CArray::SetInteger(size_t index, int int_val)
{
	Dbg_MsgAssert(m_type==ESYMBOLTYPE_INTEGER,("Called CArray::SetInteger when m_type was '%s'",GetTypeName((uint8)m_type)));
	Dbg_MsgAssert(index<m_size,("Bad index of %d sent to CArray::SetInteger, m_size=%d",index,m_size));
	if (m_size==1)
	{
		m_integer=int_val;
	}
	else
	{
		Dbg_MsgAssert(mp_array_data,("nullptr mp_array_data ?"));
		mp_integers[index]=int_val;
	}	
}

void CArray::SetFloat(size_t index, float float_val)
{
	Dbg_MsgAssert(m_type==ESYMBOLTYPE_FLOAT,("Called CArray::SetFloat when m_type was '%s'",GetTypeName((uint8)m_type)));
	Dbg_MsgAssert(index<m_size,("Bad index of %d sent to CArray::SetFloat, m_size=%d",index,m_size));
	if (m_size==1)
	{
		m_float=float_val;
	}
	else
	{
		Dbg_MsgAssert(mp_array_data,("nullptr mp_array_data ?"));
		mp_floats[index]=float_val;
	}	
}

void CArray::SetChecksum(size_t index, uint32 checksum)
{
	Dbg_MsgAssert(m_type==ESYMBOLTYPE_NAME,("Called CArray::SetChecksum when m_type was '%s'",GetTypeName((uint8)m_type)));
	Dbg_MsgAssert(index<m_size,("Bad index of %d sent to CArray::SetChecksum, m_size=%d",index,m_size));
	if (m_size==1)
	{
		m_checksum=checksum;
	}
	else
	{
		Dbg_MsgAssert(mp_array_data,("nullptr mp_array_data ?"));
		mp_checksums[index]=checksum;
	}	
}

void CArray::SetVector(size_t index, CVector *p_vector)
{
	Dbg_MsgAssert(m_type==ESYMBOLTYPE_VECTOR,("Called CArray::SetVector when m_type was '%s'",GetTypeName((uint8)m_type)));
	Dbg_MsgAssert(index<m_size,("Bad index of %d sent to CArray::SetVector, m_size=%d",index,m_size));
	if (m_size==1)
	{
		Dbg_MsgAssert(mp_vector==nullptr,("mp_vector expected to be nullptr"));
		mp_vector=p_vector;
	}
	else
	{
		Dbg_MsgAssert(mp_array_data,("nullptr mp_array_data ?"));
		Dbg_MsgAssert(mpp_vectors[index]==nullptr,("Non-nullptr pointer in mpp_vectors[index]"));
		mpp_vectors[index]=p_vector;
	}	
}

void CArray::SetPair(size_t index, CPair *p_pair)
{
	Dbg_MsgAssert(m_type==ESYMBOLTYPE_PAIR,("Called CArray::SetPair when m_type was '%s'",GetTypeName((uint8)m_type)));
	Dbg_MsgAssert(index<m_size,("Bad index of %d sent to CArray::SetPair, m_size=%d",index,m_size));
	if (m_size==1)
	{
		Dbg_MsgAssert(mp_pair==nullptr,("mp_pair expected to be nullptr"));
		mp_pair=p_pair;
	}
	else
	{
		Dbg_MsgAssert(mp_array_data,("nullptr mp_array_data ?"));
		Dbg_MsgAssert(mpp_pairs[index]==nullptr,("Non-nullptr pointer in mpp_pairs[index]"));
		mpp_pairs[index]=p_pair;
	}	
}

void CArray::SetStructure(size_t index, CStruct *p_struct)
{
	Dbg_MsgAssert(m_type==ESYMBOLTYPE_STRUCTURE,("Called CArray::SetStructure when m_type was '%s'",GetTypeName((uint8)m_type)));
	Dbg_MsgAssert(index<m_size,("Bad index of %d sent to CArray::SetStructure, m_size=%d",index,m_size));
	if (m_size==1)
	{
		Dbg_MsgAssert(mp_structure==nullptr,("mp_structure expected to be nullptr"));
		mp_structure=p_struct;
	}
	else
	{
		Dbg_MsgAssert(mp_array_data,("nullptr mp_array_data ?"));
		Dbg_MsgAssert(mpp_structures[index]==nullptr,("Non-nullptr pointer in mpp_structures[index]"));
		mpp_structures[index]=p_struct;
	}	
}

void CArray::SetArray(size_t index, CArray *p_array)
{
	Dbg_MsgAssert(m_type==ESYMBOLTYPE_ARRAY,("Called CArray::SetArray when m_type was '%s'",GetTypeName((uint8)m_type)));
	Dbg_MsgAssert(index<m_size,("Bad index of %d sent to CArray::SetArray, m_size=%d",index,m_size));
	if (m_size==1)
	{
		Dbg_MsgAssert(mp_array==nullptr,("mp_array expected to be nullptr"));
		mp_array=p_array;
	}
	else
	{
		Dbg_MsgAssert(mp_array_data,("nullptr mp_array_data ?"));
		Dbg_MsgAssert(mpp_arrays[index]==nullptr,("Non-nullptr pointer in mpp_arrays[index]"));
		mpp_arrays[index]=p_array;
	}	
}

char *CArray::GetString(size_t index) const
{
	// The game code views local strings & strings as the same type.
	if (m_type==ESYMBOLTYPE_LOCALSTRING)
	{
		return GetLocalString(index);
	}	
	Dbg_MsgAssert(m_type==ESYMBOLTYPE_STRING,("Called CArray::GetString when m_type was '%s'",GetTypeName((uint8)m_type)));
	Dbg_MsgAssert(index<m_size,("Bad index of %d sent to CArray::GetString, m_size=%d",index,m_size));
	if (m_size==1)
	{
		return mp_string;
	}
	else
	{
		Dbg_MsgAssert(mp_array_data,("nullptr mp_array_data ?"));
		return mpp_strings[index];
	}	
}

char *CArray::GetLocalString(size_t index) const
{
	if (m_type==ESYMBOLTYPE_STRING)
	{
		return GetString(index);
	}	
	Dbg_MsgAssert(m_type==ESYMBOLTYPE_LOCALSTRING,("Called CArray::GetLocalString when m_type was '%s'",GetTypeName((uint8)m_type)));
	Dbg_MsgAssert(index<m_size,("Bad index of %d sent to CArray::GetLocalString, m_size=%d",index,m_size));
	if (m_size==1)
	{
		return mp_local_string;
	}
	else
	{
		Dbg_MsgAssert(mp_array_data,("nullptr mp_array_data ?"));
		return mpp_local_strings[index];
	}	
}

int CArray::GetInteger(size_t index) const
{
	Dbg_MsgAssert(m_type==ESYMBOLTYPE_INTEGER,("Called CArray::GetInteger when m_type was '%s'",GetTypeName((uint8)m_type)));
	Dbg_MsgAssert(index<m_size,("Bad index of %d sent to CArray::GetInteger, m_size=%d",index,m_size));
	if (m_size==1)
	{
		return m_integer;
	}
	else
	{
		Dbg_MsgAssert(mp_array_data,("nullptr mp_array_data ?"));
		return mp_integers[index];
	}	
}

float CArray::GetFloat(size_t index) const
{
	Dbg_MsgAssert(m_type==ESYMBOLTYPE_FLOAT || m_type==ESYMBOLTYPE_INTEGER,("Called CArray::GetFloat when m_type was '%s'",GetTypeName((uint8)m_type)));
	Dbg_MsgAssert(index<m_size,("Bad index of %d sent to CArray::GetFloat, m_size=%d",index,m_size));
	
	if (m_size==1)
	{
		if (m_type==ESYMBOLTYPE_FLOAT)
		{
			return m_float;
		}
		else
		{
			return (float)m_integer;
		}	
	}
	else
	{
		Dbg_MsgAssert(mp_array_data,("nullptr mp_array_data ?"));
		
		if (m_type==ESYMBOLTYPE_FLOAT)
		{
			return mp_floats[index];
		}	
		else
		{
			return (float)mp_integers[index];	
		}	
	}	
}

uint32 CArray::GetChecksum(size_t index) const
{
	Dbg_MsgAssert(m_type==ESYMBOLTYPE_NAME,("Called CArray::GetChecksum when m_type was '%s'",GetTypeName((uint8)m_type)));
	Dbg_MsgAssert(index<m_size,("Bad index of %d sent to CArray::GetChecksum, m_size=%d",index,m_size));
	if (m_size==1)
	{
		return m_checksum;
	}
	else
	{
		Dbg_MsgAssert(mp_array_data,("nullptr mp_array_data ?"));
		return mp_checksums[index];
	}	
}

CVector	*CArray::GetVector(size_t index) const
{
	Dbg_MsgAssert(m_type==ESYMBOLTYPE_VECTOR,("Called CArray::GetVector when m_type was '%s'",GetTypeName((uint8)m_type)));
	Dbg_MsgAssert(index<m_size,("Bad index of %d sent to CArray::GetVector, m_size=%d",index,m_size));
	if (m_size==1)
	{
		return mp_vector;
	}
	else
	{
		Dbg_MsgAssert(mp_array_data,("nullptr mp_array_data ?"));
		return mpp_vectors[index];
	}	
}

CPair *CArray::GetPair(size_t index) const
{
	Dbg_MsgAssert(m_type==ESYMBOLTYPE_PAIR,("Called CArray::GetPair when m_type was '%s'",GetTypeName((uint8)m_type)));
	Dbg_MsgAssert(index<m_size,("Bad index of %d sent to CArray::GetPair, m_size=%d",index,m_size));
	if (m_size==1)
	{
		return mp_pair;
	}
	else
	{
		Dbg_MsgAssert(mp_array_data,("nullptr mp_array_data ?"));
		return mpp_pairs[index];
	}	
}

CStruct *CArray::GetStructure(size_t index) const
{
	Dbg_MsgAssert(m_type==ESYMBOLTYPE_STRUCTURE,("Called CArray::GetStructure when m_type was '%s'",GetTypeName((uint8)m_type)));
	Dbg_MsgAssert(index<m_size,("Bad index of %d sent to CArray::GetStructure, m_size=%d",index,m_size));
	if (m_size==1)
	{
		return mp_structure;
	}
	else
	{
		Dbg_MsgAssert(mp_array_data,("nullptr mp_array_data ?"));
		return mpp_structures[index];
	}	
}

CArray *CArray::GetArray(size_t index) const
{
	Dbg_MsgAssert(m_type==ESYMBOLTYPE_ARRAY,("Called CArray::GetArray when m_type was '%s'",GetTypeName((uint8)m_type)));
	Dbg_MsgAssert(index<m_size,("Bad index of %d sent to CArray::GetArray, m_size=%d",index,m_size));
	if (m_size==1)
	{
		return mp_array;
	}
	else
	{
		Dbg_MsgAssert(mp_array_data,("nullptr mp_array_data ?"));
		return mpp_arrays[index];
	}	
}

} // namespace Script

