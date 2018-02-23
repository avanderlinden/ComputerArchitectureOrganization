/*
 * main.cpp
 *
 *  Created on: Feb 16, 2018
 *      Author: Alex van der Linden
 */

#include <iostream>
#include <list>
#include <iterator>

#include "computer.h"
#include "program.h"

int main()
{
	// create two lists that hold Computer and Program objects
	std::list<Computer> ComputerList;
	std::list<Program> ProgramList;

	// first computer will be added to first location in the list
	ComputerList.push_back(Computer(1.0, 2, 2, 3, 4));
	ComputerList.push_back(Computer(1.2, 2, 3, 4, 3));
	ComputerList.push_back(Computer(2.0, 2, 2, 4, 6));

	// first program will be added to first location in the list
	ProgramList.push_back(Program(2000, 100, 100, 50));
	ProgramList.push_back(Program(2000, 0.1, 0.4, 0.25));
	ProgramList.push_back(Program(500, 100, 2000, 200));

	// create iterators for iterating the computer and program lists
	std::list<Computer>::iterator pc_it;
	std::list<Program>::iterator prog_it;

	// iterate over the Computer objects in the list
	for (pc_it = ComputerList.begin(); pc_it != ComputerList.end(); ++pc_it)
	{
		// calculate and print stats for computer1 and programA, B and C.
		std::cout << "---- computer "
			<< std::distance(ComputerList.begin(), pc_it)+1 << " ----\n"
			<< *pc_it << "\n"
			<< "Global MIPS Rating\t: " << pc_it->calculateMIPS() << "\n";

		// iterate over Program objects in the list
		for (prog_it = ProgramList.begin(); prog_it != ProgramList.end(); ++prog_it)
		{
			std::cout << "MIPS Program "
					<< (char) (0x41 + std::distance(ProgramList.begin(), prog_it)) << "\t\t: "
					<< pc_it->calculateMIPS(*prog_it) << "\n";
		}
		std::cout << "\n\n";
	}
	return 0;
}

