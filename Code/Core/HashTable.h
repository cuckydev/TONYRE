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
**	Module:			HashTable      			 							**
**																			**
**	File name:		Core\HashTable.h										**
**																			**
**	Created by:		9/22/2000 - rjm							                **
**																			**
**	Description:	A handy Hashtable class				                **
**																			**
*****************************************************************************/

#ifndef __CORE_LIST_HASHTABLE_H
#define __CORE_LIST_HASHTABLE_H

#ifndef __CORE_DEFINES_H
#include <Core/Defines.h>
#endif

#include <Sys/Mem/PoolManager.h>

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

namespace Lst
{

/*****************************************************************************
**							Class Definitions								**
*****************************************************************************/


	template< class _V > class HashTable;


	template< class _V > class HashItem
	{
		friend class HashTable<_V>;

		private:
			HashItem();
			void Init();

			size_t m_key = 0;
			_V *mp_value = nullptr;
			HashItem<_V> *mp_next = nullptr;
	};


	template <class _V> class HashTable
	{
		typedef void (*HashCallback)(_V *, void *);

		public:
			HashTable(size_t numBits);
			~HashTable();

			// if any item exists with the same key, replace it
			bool PutItem(const size_t &key, _V *item);

			// delete the item, and remove it from the table
			void FlushItem(const size_t &key);

			// print all instances of an item (debugging)
			void PrintItem(const size_t &key);

			// gets a pointer to requested item, returns nullptr if item not in table
			_V *GetItem(const size_t &key, bool assert_if_clash = true);
			_V *GetNextItemWithSameKey(const size_t &key, _V *p_item);

			void FlushAllItems(void);

			void HandleCallback(HashCallback, void *pData);

			size_t GetSize() { return m_size; }

			void IterateStart();
			_V *IterateNext(size_t *pRetKey = nullptr);

			#ifdef __NOPT_ASSERT__
			void PrintContents();
			#endif

			void AllowDuplicateKeys(bool allowed)
			{
				m_allowDuplicateKeys = allowed;
			}

		protected:
			size_t m_numBits = 0; // resolution of hash table
			HashItem<_V> *mp_hash_table = nullptr;
			size_t m_size = 0;	// number of entries in the table

			ptrdiff_t m_iterator_index = 0;
			HashItem<_V> *mp_iterator_item = nullptr;
			bool m_allowDuplicateKeys = false;
	};


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

	/*****************************************************************************
	**								Inline Functions							**
	*****************************************************************************/

	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/

	template<class _V> //inline
	HashTable<_V>::HashTable(size_t numBits)
	{
		//Ryan("Creating HashTable");

		m_numBits = numBits;
		mp_hash_table = new HashItem<_V>[1ULL << m_numBits];
		m_size = 0;
		m_allowDuplicateKeys = false;
	}



	template<class _V> //inline
	HashTable<_V>::~HashTable()
	{

		//Ryan("Destroying HashTable");

		Dbg_AssertPtr(mp_hash_table);
		if (!mp_hash_table)
			return;

		FlushAllItems();

		// Remove the table.
	//	Mem::Free(mp_hash_table);
		delete[] mp_hash_table;
		mp_hash_table = nullptr;
	}

	template<class _V> //inline
	bool HashTable<_V>::PutItem(const size_t &key, _V *item)
	{
		Dbg_AssertPtr(item);
		//Ryan("putting item in Hash table\n");

		Dbg_AssertPtr(mp_hash_table);

		// sometimes, we want to allow checksum conflicts
		// (for instance, ConvertAssets' file database)
		if (!m_allowDuplicateKeys)
		{
			Dbg_MsgAssert(!GetItem(key), ("item 0x%x already in hash table", key));
		}

		// can't add an item of 0,nullptr, as that is used to indicate an empty head slot
		Dbg_MsgAssert(key || item, ("Both key and item are 0 (nullptr) in hash table"));
		// can have a value of nullptr either, as the the test below uses  pEntry->mp_value == nullptr 
		// to indicate an an empty head slot
		// We could just change it to ( pEntry->mp_value || pEntry->m_key ) if nullptr values are desirable
		Dbg_MsgAssert(item, ("nullptr item added to hash table"));

		HashItem<_V> *pEntry = &mp_hash_table[key & ((1ULL << m_numBits) - 1)];
		if (pEntry->mp_value)
		{
			// The main table entry is already occupied, so create a new HashEntry and
			// link it in between the first and the rest.
			HashItem<_V> *pNew = new (Mem::PoolManager::SCreateItem(Mem::PoolManager::vHASH_ITEM_POOL)) HashItem<_V>();
			pNew->m_key = key;
			pNew->mp_value = item;
			pNew->mp_next = pEntry->mp_next;
			pEntry->mp_next = pNew;
		}
		else
		{
			// Main table entry is not occupied, so wack it in there.
			pEntry->m_key = key;
			pEntry->mp_value = item;
			// leave pEntry->mp_next untouched
		}

		m_size++;
		return true;
	}


	template<class _V> //inline
	_V *HashTable<_V>::GetNextItemWithSameKey(const size_t &key, _V *p_item)
	{
		Dbg_AssertPtr(mp_hash_table);

		// Jump to the linked list of all entries with similar checksums.	
		HashItem<_V> *pEntry = &mp_hash_table[key & ((1ULL << m_numBits) - 1)];

		// Look for p_item
		while (pEntry)
		{
			if (pEntry->m_key == key && pEntry->mp_value == p_item)
			{
				break;
			}
			pEntry = pEntry->mp_next;
		}
		if (!pEntry)
		{
			// p_item was not found.
			return nullptr;
		}

		// Found p_item, so search the rest of the list for the next element with the same key.
		pEntry = pEntry->mp_next;
		while (pEntry)
		{
			if (pEntry->m_key == key && pEntry->mp_value)
			{
				return pEntry->mp_value;
			}
			pEntry = pEntry->mp_next;
		}

		return nullptr;
	}

	template<class _V> //inline
	_V *HashTable<_V>::GetItem(const size_t &key, bool assert_if_clash)
	{
		(void)assert_if_clash;

		Dbg_AssertPtr(mp_hash_table);

		// Jump to the linked list of all entries with similar checksums.	
		HashItem<_V> *pEntry = &mp_hash_table[key & ((1ULL << m_numBits) - 1)];
		// Scan through the small list until the matching entry is found.

		// Note: the main table entry might be empty, so we still want to scan
		// the linked ones

		while (pEntry)
		{
			if (pEntry->m_key == key && pEntry->mp_value)
			{
				return (_V *)pEntry->mp_value;
			}
			pEntry = pEntry->mp_next;
		}

		return nullptr;
	}


	template<class _V> //inline
	void HashTable<_V>::PrintItem(const size_t &key)
	{
		Dbg_AssertPtr(mp_hash_table);

		// Jump to the linked list of all entries with similar checksums.	
		HashItem<_V> *pEntry = &mp_hash_table[key & ((1ULL << m_numBits) - 1)];
		// Scan through the small list until the matching entry is found.

		int n = 0;

		// Note: the main table entry might be empty, so we still want to scan
		// the linked ones

		while (pEntry)
		{
			if (pEntry->m_key == key && pEntry->mp_value)
			{
				printf("%d: Entry for 0x%x at %p\n", n, key, (_V *)pEntry->mp_value);
				n++;
			}
			pEntry = pEntry->mp_next;
		}

	}




	template<class _V> //inline
	void HashTable<_V>::FlushItem(const size_t &key)
	{

		Dbg_AssertPtr(mp_hash_table);
		if (!mp_hash_table)
			return;

		// Jump to the linked list of all entries with similar checksums.	
		HashItem<_V> *pEntry = &mp_hash_table[key & ((1ULL << m_numBits) - 1)];
		HashItem<_V> *pLast = nullptr;

		// Scan through the small list until the matching entry is found.
		while (pEntry)
		{
			HashItem<_V> *p_next_entry = pEntry->mp_next;
			if (pEntry->m_key == key && pEntry->mp_value)		// to allow keys of value 0, we have to skip head nodes that are 0,nullptr
			{
				if (pLast)
				{
					// this is not a main table entry; this is a linked entry
					pLast->mp_next = pEntry->mp_next;
					Mem::PoolManager::SFreeItem(Mem::PoolManager::vHASH_ITEM_POOL, pEntry);
				}
				else
				{
					// this is a main table entry, it still might be linked to something
					// clear the entry to 0,nullptr (see comment above about keys of value 0)
					pEntry->m_key = 0;
					pEntry->mp_value = nullptr;
				}
				m_size--;
				return;
			}
			pLast = pEntry;
			pEntry = p_next_entry;
		}
		return;
	}




	template<class _V> //inline
	void HashTable<_V>::FlushAllItems()
	{


		Dbg_AssertPtr(mp_hash_table);
		if (!mp_hash_table)
			return;

		// Run through the table and delete any of the extra
		// HashItem<_V>s.
		HashItem<_V> *pMainEntry = mp_hash_table;
		size_t hashTableSize = (1ULL << m_numBits);
		for (uint32 i = 0; i < hashTableSize; ++i)
		{
			HashItem<_V> *pLinkedEntry = pMainEntry->mp_next;
			while (pLinkedEntry)
			{
				HashItem<_V> *pNext = pLinkedEntry->mp_next;
				Mem::PoolManager::SFreeItem(Mem::PoolManager::vHASH_ITEM_POOL, pLinkedEntry);
				pLinkedEntry = pNext;
			}
			pMainEntry->Init();
			++pMainEntry;
		}
		m_size = 0;
	}




	template<class _V> //inline
	void HashTable<_V>::HandleCallback(HashCallback hashCallback, void *pData)
	{
		HashItem<_V> *pMainEntry = mp_hash_table;
		size_t hashTableSize = (1ULL << m_numBits);
		for (uint32 i = 0; i < hashTableSize; ++i)
		{
			HashItem<_V> *pLinkedEntry = pMainEntry->mp_next;
			while (pLinkedEntry)
			{
				HashItem<_V> *pNext = pLinkedEntry->mp_next;
	//			Mem::Free(pLinkedEntry);
				if (pLinkedEntry->mp_value)
					(hashCallback)((_V *)pLinkedEntry->mp_value, pData);
				pLinkedEntry = pNext;
			}
			if (pMainEntry->mp_value)
				(hashCallback)((_V *)pMainEntry->mp_value, pData);
			++pMainEntry;
		}

	}




	template<class _V> //inline
	void HashTable<_V>::IterateStart()
	{
		m_iterator_index = -1;
		mp_iterator_item = nullptr;
	}




	template<class _V> //inline
	_V *HashTable<_V>::IterateNext(size_t *pRetKey)
	{
		size_t hashTableSize = (1ULL << m_numBits);

		// time to go to the next entry, or the first if we're just starting

		if (mp_iterator_item)
			// next entry in list
			mp_iterator_item = mp_iterator_item->mp_next;
		else if (m_iterator_index >= 0)
			// we've exhausted all the lists
			return nullptr;

		if (!mp_iterator_item)
		{
			// no entry in list, move on to next list
			do
			{
				m_iterator_index++;
				if (m_iterator_index >= (int)hashTableSize)
					return nullptr;
				mp_iterator_item = mp_hash_table + m_iterator_index;
			} 	// main entry has to contain something, or be part of a list
			while (!mp_iterator_item->mp_value && !mp_iterator_item->mp_next);
			if (!mp_iterator_item->mp_value)
				// this must be an empty main entry, skip ahead
				mp_iterator_item = mp_iterator_item->mp_next;
		}

		// Ken: Added this because it was hanging here once when loading the junkyard
		// off CD. It was trying to dereference mp_iterator_item. Added the printf
		// so we can at least see when it happens without having to go into the debugger.
		if (!mp_iterator_item)
		{
			#ifdef __NOPT_ASSERT__
			printf("Error!! nullptr mp_iterator_item in IterateNext()\n");
			#endif
			return nullptr;
		}
		if (pRetKey)
			*pRetKey = mp_iterator_item->m_key;
		return mp_iterator_item->mp_value;
	}




	#ifdef __NOPT_ASSERT__
	template<class _V> //inline
	void HashTable<_V>::PrintContents()
	{
		printf("Items in Hash Table:\n");
		size_t hashTableSize = (1ULL << m_numBits);
		for (uint32 i = 0; i < hashTableSize; ++i)
		{
			HashItem<_V> *pEntry = mp_hash_table + i;
			while (pEntry)
			{
				if (pEntry->mp_value)
					printf("    0x%zu [%d]\n", pEntry->m_key, i);
				pEntry = pEntry->mp_next;
			}
		}
	}
	#endif




	template<class _V> //inline
	HashItem<_V>::HashItem()
	{
		Init();
	}




	template<class _V> //inline
	void HashItem<_V>::Init()
	{
		m_key = 0;
		mp_value = nullptr;
		mp_next = nullptr;
	}

} // namespace Lst

#endif	// __CORE_LIST_HASHTABLE_H


