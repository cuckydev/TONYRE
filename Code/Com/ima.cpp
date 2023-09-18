#include "ima.h"

namespace IMA
{
	// IMA functions
	void IMA::SetPointer(const unsigned char *data, size_t size)
	{
		// Set data pointer
		ima_data = data;
		ima_size = size;

		// Setup IMA stream
		ima_pointer = ima_data;
		ima_i = 0;

		ima_index = 0;
		ima_step = 0;
	}

	void IMA::Rewind()
	{
		// Setup IMA stream
		ima_pointer = ima_data;
		ima_i = 0;

		ima_index = 0;
		ima_step = 0;
	}

	bool IMA::AtEnd()
	{
		return ima_pointer >= ima_data + ima_size;
	}

	signed short IMA::Fetch()
	{
		// If we're at the end of the buffer, return 0
		if (IMA::AtEnd())
			return 0;

		// Get current nibble
		unsigned char nibble;
		if (ima_i & 1)
		{
			nibble = *ima_pointer >> 4;
			ima_pointer++;
		}
		else
		{
			nibble = *ima_pointer & 0xF;
		}
		ima_i ^= 1;

		// Update index
		unsigned char ima_magn = nibble & 7;
		unsigned char ima_sign = nibble >> 3;
		ima_index += ima_index_table[ima_magn];

		if (ima_index < 0)
			ima_index = 0;
		else if (ima_index > 88)
			ima_index = 88;

		// Update step
		signed long ima_delta = (ima_step_table[ima_index] >> 3) + ((ima_magn * ima_step_table[ima_index]) >> 2);
		if (ima_sign)
			ima_delta = -ima_delta;

		ima_step += ima_delta;
		if (ima_step < -0x7FFF)
			ima_step = -0x7FFF;
		else if (ima_step > 0x7FFF)
			ima_step = 0x7FFF;

		return (signed short)ima_step;
	}
}
