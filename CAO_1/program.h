/*
 * program.h
 *
 *  Created on: Feb 16, 2018
 *      Author: Alex van der Linden
 */
#ifndef PROGRAM_H_
#define PROGRAM_H_

class Program
{
public:

	/*
	 * Constructor using only integers. Initializes all values and calculates
	 * total number of Instructions.
	 *
	 * @param int numArith: Number of Arithmetic instructions.
	 * @param int numStore: Number of Store instructions.
	 * @param int numLoad: Number of Load instructions.
	 * @param int numBranch: Number of Branch instructions.
	 */
	Program (int numArith, int numStore, int numLoad, int numBranch);

	/*
	 * Constructor using percentage. Calculates variables by total instructions
	 * and the fraction of Arithmetic, Store and Load instructions. Number of
	 * Branch instructions is calculated based on the other variables.
	 *
	 * @param int numTotal: The total number of instructions.
	 * @param double fracArith: The fraction of Arithmetic instructions.
	 * @param double fracStore: The fraction of Store instructions.
	 * @param double fracLoad: The fraction of Load instructions.
	 */
	Program(int numTotal, double fracArith, double fracStore,
			double fracLoad);


	/*
	 * Prints all variables from Program objects.
	 */
	void printStats (void);


	int getNumTotal(void) const { return this->numTotal;}
	int getNumStore(void) const {return this->numStore;}
	int getNumLoad(void) const {return this->numLoad;}
	int getNumBranch(void) const {return this->numBranch;}
	int getNumArith(void) const {return this->numArith;}


private:
	int numArith;  // Arithmetic and logic calculations
	int numStore;  // Store data into memory
	int numLoad;   // Load data from memory
	int numBranch; // Conditional and unconditional jumps
	int numTotal;  // Total number of instructions
};



#endif /* PROGRAM_H_ */
