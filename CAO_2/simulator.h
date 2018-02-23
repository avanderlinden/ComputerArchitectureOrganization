#ifndef _SIMULATOR_H_
#define _SIMULATOR_H_

#include "registers.h"
#include "program.h"

class Simulator
{
	Registers	*registers;
	Program		*program;

	public:
		Simulator (Registers*, Program*);
		~Simulator ();
		void help ();
		void ui ();
};

#endif /* _SIMULATOR_H_ */
