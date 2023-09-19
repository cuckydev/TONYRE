#ifndef	__SCRIPTING_ARRAY_H
#define	__SCRIPTING_ARRAY_H

#ifndef __CORE_DEFINES_H
#include <Core/Defines.h>
#endif

#ifndef __SYS_MEM_POOLABLE_H
#include <Sys/Mem/Poolable.h>
#endif

#ifndef	__SCRIPTING_SYMBOLTYPE_H
#include <Gel/Scripting/symboltype.h> // For ESymbolType
#endif

namespace Script
{

class CVector;
class CPair;
class CStruct;

// Script array class
class CArray : public Mem::CPoolable<CArray>
{
	// Pointer to the array data.
	union
	{
		// Generic pointer.
		// Used when calling Mem::Free.
		char *mp_array_data;
		
		int *mp_integers;
		float *mp_floats;
		uint32 *mp_checksums;
		
		char **mpp_strings;
		char **mpp_local_strings;
		CPair **mpp_pairs;
		CVector **mpp_vectors;
		CStruct **mpp_structures;
		CArray **mpp_arrays;
		
		// In the case of the array containing only 1 element, the element itself is
		// stored here, rather than allocating a block of memory for it.
		// This is a memory optimization.
		// Each memory block uses 16 bytes for the header, and the data is padded to
		// occupy 16 bytes. So in the case of an array of 1 element this saves 32 bytes.
		// There are lots of arrays of 1 element, eg the links arrays in each node of 
		// the NodeArray often only contain 1 link.
		int m_integer;
		float m_float;
		uint32 m_checksum;
		char *mp_string;
		char *mp_local_string;
		CPair *mp_pair;
		CVector *mp_vector;
		CStruct *mp_structure;
		CArray *mp_array;
		// Used to zero the single element.
		uintptr_t m_union;
	};

	// The type of the things in the array.
	ESymbolType m_type;
	
	// The number of items in the array.
	size_t m_size;

public:
	CArray();
	~CArray();

	// These cannot be defined because it would cause a cyclic dependency, because
	// a CArray member function can't create things. So declare them but leave them undefined
	// so that it will not link if they are attempted to be used.
	CArray( const CArray& rhs );
	CArray& operator=( const CArray& rhs );
	
	// This is used when interpreting switch statements.
	bool operator==( const CArray& v ) const;
	bool operator!=( const CArray& v ) const;
	
	void Clear();
	void SetSizeAndType(size_t size, ESymbolType type);
	void Resize(size_t newSize);
	
	// TODO: Remove later. Only included for back compatibility.
	void SetArrayType(int size, ESymbolType type) {SetSizeAndType(size,type);}
	
	void 	  SetString(size_t index, char *p_string);
	void SetLocalString(size_t index, char *p_string);
	void 	 SetInteger(size_t index, int int_val);
	void 	   SetFloat(size_t index, float float_val);
	void 	SetChecksum(size_t index, uint32 checksum);
	void 	  SetVector(size_t index, CVector *p_vector);
	void 		SetPair(size_t index, CPair *p_pair);
	void   SetStructure(size_t index, CStruct *p_struct);
	void 	   SetArray(size_t index, CArray *p_array);

	char 			*GetString(size_t index) const;
	char 	   *GetLocalString(size_t index) const;
	int 			GetInteger(size_t index) const;
	float 			  GetFloat(size_t index) const;
	uint32 		   GetChecksum(size_t index) const;
	CVector			*GetVector(size_t index) const;
	CPair 			  *GetPair(size_t index) const;
	CStruct 	 *GetStructure(size_t index) const;
	CArray			 *GetArray(size_t index) const;

	////////////////////////////////////////////////////////////////////////////////////
	// TODO: Remove these later, only needed for back compatibility.
	uint32	   GetNameChecksum(size_t index) const {return GetChecksum(index);}
	int 				GetInt(size_t index) const {return GetInteger(index);}
	////////////////////////////////////////////////////////////////////////////////////
	
	size_t 		GetSize() const {return m_size;};
	ESymbolType GetType() const {return m_type;};
	
	// Needed by CleanUpArray and CopyArray in struct.cpp so that they can
	// quickly scan through the array data without having to use the access functions
	// to get each element.
	void *GetArrayPointer() const;

	// Get element size
	static size_t GetElementSize(ESymbolType type)
	{
		switch (type)
		{
			case ESYMBOLTYPE_INTEGER:
				return sizeof(int);
			case ESYMBOLTYPE_FLOAT:
				return sizeof(float);
			case ESYMBOLTYPE_NAME:
				return sizeof(uint32);
			case ESYMBOLTYPE_STRING:
			case ESYMBOLTYPE_LOCALSTRING:
			case ESYMBOLTYPE_PAIR:
			case ESYMBOLTYPE_VECTOR:
			case ESYMBOLTYPE_STRUCTURE:
			case ESYMBOLTYPE_ARRAY:
				return sizeof(void*);

			case ESYMBOLTYPE_NONE:
				return 0;

			default:
				Dbg_MsgAssert(0, ("Bad type of '%s' sent to GetElementSize", GetTypeName((uint8)type)));
				return 0;
		}
	}
};

} // namespace Script

#endif // #ifndef	__SCRIPTING_ARRAY_H
