/*
 * program.cpp
 *
 *  Created on: Feb 16, 2018
 *      Author: Alex van der Linden
 */

#include "program.h"
#include <iostream>

Program::Program (int numArith, int numStore, int numLoad, int numBranch)
{
	this->numArith = numArith;
	this->numStore = numStore;
	this->numLoad = numLoad;
	this->numBranch = numBranch;

	this->numTotal = numArith + numStore + numLoad + numBranch;
}

Program::Program(int numTotal, double fracArith, double fracStore,
		double fracLoad)
{
	double fracBranch = 1.0 - fracArith - fracStore - fracLoad;

	if ( fracBranch < 0.0 )
	{
		throw std::invalid_argument("Sum of all fractions is not 1 (100%)");
	}

	this->numArith = (int) ((double) numTotal*fracArith + 0.5);
	this->numLoad = (int) ((double) numTotal*fracLoad + 0.5);
	this->numStore = (int) ((double) numTotal*fracStore + 0.5);
	this->numBranch = (int) ((double) numTotal*fracBranch + 0.5);
	this->numTotal = numTotal;

}

void Program::printStats()
{
	std::cout<<"Arithmetic Instructions\t: " << this->numArith << " [Nr.]\n";
	std::cout<<"Store Instruction\t: " << this->numStore << " [Nr.]\n";
	std::cout<<"Load Instruction\t: " << this->numLoad << " [Nr.]\n";
	std::cout<<"Branch Instruction\t: " << this->numBranch << " [Nr.]\n";
	std::cout<<"\nTotal Instructions\t: " << this->numTotal << " [Nr.]\n";
}

