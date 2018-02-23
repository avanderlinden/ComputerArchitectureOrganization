#include <iostream>
#include <string>
#include "simulator.h"
#include "program.h"
#include "registers.h"

using namespace std;

Simulator::Simulator (Registers *theRegisters, Program *theProgram)
{
	registers	= theRegisters;
	program		= theProgram;
}


Simulator::~Simulator ()
{
	delete registers;
	delete program;
}

void Simulator::help ()
{
	cout << "Available commands:" << endl;
	cout << "d\tdisassemble program" << endl;
	cout << "e\texecute program" << endl;
	cout << "h\thelp" << endl;
	cout << "q\tquit" << endl;
	cout << "r\tprint registers" << endl;
	cout << "s\tsingle step program" << endl;
}


void Simulator::ui ()
{
	bool	doQuit = false;

	while (!doQuit)
	{
		// Very simple user interface with single char commands
		cout << "Command (h for help):" << endl;

		char command;
		cin >> command;

		switch (command)
		{
			case 'd':
				program->disassemble ();
				break;
			case 's':
				program->singleStep (registers);
				break;
			case 'h':
				help ();
				break;
			case 'r':
				registers->print ();
				break;
			case 'e':
				program->execute (registers);
				break;
			case 'q':
				cout << "Bye" << endl;
				doQuit = true;
				break;
			default:
				cout << "Unknown command <" << command << ">" << endl;
				break;
		}
	}
}
