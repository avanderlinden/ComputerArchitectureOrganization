#include <vector>
#include "program.h"
#include "instruction.h"

Program::Program ()
{
	instructions = new std::vector<Instruction*>;
}


Program::~Program ()
{
	std::vector<Instruction*>::iterator it;

	for (it = instructions->begin (); it < instructions->end(); it++)
	{
		delete *it;
	}
	delete instructions;
}


void Program::appendInstruction (Instruction *instruction)
{
	instructions->push_back (instruction);
}


void Program::disassemble ()
{
	std::vector<Instruction*>::iterator it;

	for (it = instructions->begin (); it < instructions->end (); it++)
	{
		(*it)->disassemble ();
	}
}


void Program::singleStep (Registers *registers)
{
	std::vector<Instruction*>::iterator it = instructions->begin () + registers->getPC ();

	if (it >= instructions->begin () && it < instructions->end ())
	{
		registers->setPC ((*it)->execute (registers));
	}
}


void Program::execute (Registers *registers)
{
	std::vector<Instruction*>::iterator it = instructions->begin () + registers->getPC ();

	while (it >= instructions->begin () && it < instructions->end ())
	{
		singleStep (registers);
		it = instructions->begin () + registers->getPC ();
	}
}
