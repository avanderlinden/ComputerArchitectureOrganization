#ifndef _PROGRAM_H_
#define _PROGRAM_H_

#include <vector>
#include "instruction.h"
#include "registers.h"

class Program
{
		std::vector<Instruction*>	*instructions;
	public:
		Program ();
		~Program ();

		void	appendInstruction (Instruction*);
		void	disassemble ();
		void	singleStep (Registers*);
		void	execute (Registers*);
};

#endif /* _PROGRAM_H_ */
