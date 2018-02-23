/*
 * main.cpp
 *
 *  Created on: Feb 16, 2018
 *      Author: Alex van der Linden
 */

#include <iostream>
#include "computer.h"
#include "program.h"

int main()
{
	// initialize computers
	Computer computer1 = Computer(1.0, 2, 2, 3, 4);
	Computer computer2 = Computer(1.2, 2, 3, 4, 3);
	Computer computer3 = Computer(2.0, 2, 2, 4, 6);

	// initialize programs
	Program programA = Program(2000, 100, 100, 50);
	Program programB = Program(2000, 0.1, 0.4, 0.25);
	Program programC = Program(500, 100, 2000, 200);

	// calculate and print stats for computer1 and programA, B and C.
	std::cout << "---- computer 1 ----\n"
		<< computer1 << "\n"
		<< "Global MIPS Rating\t: " << computer1.calculateMIPS() << "\n"
		<< "MIPS Program A\t\t: " << computer1.calculateMIPS(programA) << "\n"
		<< "MIPS Program B\t\t: " << computer1.calculateMIPS(programB) << "\n"
		<< "MIPS Program C\t\t: " << computer1.calculateMIPS(programC) << "\n"
		<< "\n\n";

	// calculate and print stats for computer2 and programA, B and C.
	std::cout << "---- computer 2 ----\n"
			<< computer2 << "\n"
			<< "Global MIPS Rating\t: " << computer2.calculateMIPS() << "\n"
			<< "MIPS Program A\t\t: " << computer2.calculateMIPS(programA) << "\n"
			<< "MIPS Program B\t\t: " << computer2.calculateMIPS(programB) << "\n"
			<< "MIPS Program C\t\t: " << computer2.calculateMIPS(programC) << "\n"
			<< "\n\n";

	// calculate and print stats for computer3 and programA, B and C.
	std::cout << "---- computer 3 ----\n"
			<< computer3 << "\n"
			<< "Global MIPS Rating\t: " << computer3.calculateMIPS() << "\n"
			<< "MIPS Program A\t\t: " << computer3.calculateMIPS(programA) << "\n"
			<< "MIPS Program B\t\t: " << computer3.calculateMIPS(programB) << "\n"
			<< "MIPS Program C\t\t: " << computer3.calculateMIPS(programC) << "\n"
			<< "\n\n";
}

