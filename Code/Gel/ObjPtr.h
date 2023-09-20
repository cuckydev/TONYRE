#ifndef __GEL_OBJPTR_H
#define __GEL_OBJPTR_H

namespace Obj
{



class CRefCounted;



/*
	-Self assignment
	-http://web.ftech.net/~honeyg/articles/smartp.htm
*/

template<class T>
class CSmtPtr
{
	friend class CRefCounted;

public:
	CSmtPtr();
	CSmtPtr(T* pT);
	CSmtPtr(const CSmtPtr<T> &ref);
	~CSmtPtr();

	CSmtPtr<T> &			operator=(T* pT);
	CSmtPtr<T> &			operator=(const CSmtPtr<T> &ref);
	T *						operator->() const;
	T &						operator*() const;
	T **					operator&() const;

	bool					operator!() const {return (mp_object == nullptr);}
	
							operator T*() const {return mp_object;}

	friend bool 			operator==(const CSmtPtr<T> &lhs, T* pRhs) { return lhs.mp_object == pRhs; }
	friend bool 			operator==(const CSmtPtr<T> &lhs, const CSmtPtr<T> &rhs) { return lhs.mp_object == rhs.mp_object; }
	friend bool 			operator!=(const CSmtPtr<T> &lhs, T* pRhs) { return lhs.mp_object != pRhs; }
	friend bool 			operator!=(const CSmtPtr<T> &lhs, const CSmtPtr<T> &rhs) { return lhs.mp_object != rhs.mp_object; }

	T *						Convert() const {return mp_object;}
	void					Kill() const;

private:

	void					add_ref();
	void					remove_ref();
	
	T *						mp_object;
	
	CSmtPtr<CRefCounted> *	mp_prev_ptr;
	CSmtPtr<CRefCounted> *	mp_next_ptr;
};




template<class T>
inline CSmtPtr<T>::CSmtPtr()
{
	mp_prev_ptr = nullptr;
	mp_next_ptr = nullptr;
	
	mp_object = nullptr;
}




template<class T>
inline CSmtPtr<T>::CSmtPtr(T *pT)
{
	mp_prev_ptr = nullptr;
	mp_next_ptr = nullptr;
	
	mp_object = pT;
	add_ref();
	//printf("WWW in copy constructor for 0x%x\n", mp_object);
}




template<class T>
inline CSmtPtr<T>::CSmtPtr(const CSmtPtr<T> &ref)
{
	mp_prev_ptr = nullptr;
	mp_next_ptr = nullptr;
	
	mp_object = ref.mp_object;
	add_ref();
	//printf("WWW in copy constructor 2 for pointer at 0x%x, object 0x%x\n", this, mp_object);
}




template<class T>
inline CSmtPtr<T>::~CSmtPtr()
{
	//printf("WWW in destructor for 0x%x\n", mp_object);
	remove_ref();
}




template<class T>
inline CSmtPtr<T> & CSmtPtr<T>::operator=(T *pT)
{
	//printf("WWW in CSmtPtr<T>::operator=(T *pT) for pointer at 0x%x, object 0x%x (old) and 0x%x (new)\n", this, mp_object, pT);
	remove_ref();
	mp_object = pT;
	add_ref();
	return *this;
}




template<class T>
inline CSmtPtr<T> & CSmtPtr<T>::operator=(const CSmtPtr<T> &ref)
{
	//printf("WWW in CSmtPtr<T>::operator=(const CSmtPtr<T> &ref) for pointer at 0x%x, object 0x%x (old) and 0x%x (new)\n", this, mp_object, ref.mp_object);
	remove_ref();
	mp_object = ref.mp_object;
	add_ref();
	return *this;
}




template<class T>
inline T * CSmtPtr<T>::operator->() const
{
	Dbg_MsgAssert(mp_object, ("nullptr smart pointer!"));
	return (T *) mp_object;
}




template<class T>
inline T & CSmtPtr<T>::operator*()	const
{
	Dbg_MsgAssert(mp_object, ("nullptr smart pointer!"));
	return *((T *) mp_object);
}




template<class T>
inline T ** CSmtPtr<T>::operator&()	const
{
	Dbg_MsgAssert(0, ("operator& not supported, comrade!"));
}




template<class T>
inline void CSmtPtr<T>::Kill() const 
{
	Dbg_MsgAssert(mp_object, ("attempting delete with nullptr smart pointer!"));
	// this will lead to remove_ref() being called on this
	delete mp_object;
}




template<class T>
inline void CSmtPtr<T>::add_ref()
{
	if (mp_object)
	{
		//printf("WWW adding ref to 0x%x\n", mp_object);
		mp_object->AddSmartPointer((CSmtPtr<CRefCounted> *) this);
	}
}




template<class T>
inline void CSmtPtr<T>::remove_ref()
{
	if (mp_object)
	{
		//printf("WWW removing ref from 0x%x\n", mp_object);
		mp_object->RemoveSmartPointer((CSmtPtr<CRefCounted> *) this);
		mp_object = nullptr;
	}
}




}

#endif
