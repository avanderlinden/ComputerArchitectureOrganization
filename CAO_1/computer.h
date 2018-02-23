/*
 * computer.h
 *
 *  Created on: Feb 16, 2018
 *      Author: Alex van der Linden
 */

#ifndef COMPUTER_H_
#define COMPUTER_H_

#include "program.h"
#include <iostream>

class Computer
{
public:

  /*
   * Initializes the Computer object with given variables.
   *
   * @param clockRateGHz clock rate of the CPU in GHZ
   * @param cpiArith CPI of Arithmetic instructions
   * @param cpiStore CPI of Store instructions
   * @param cpiLoad CPI of Load instructions
   * @param cliBranch CPI of Branch instructions
   */
  Computer (double clockRateGHz, double cpiArith,
		  double cpiStore, double cpiLoad, double cpiBranch);

  /*
   * Prints all the statistics of the Computer object
   * to standard output (std::cout).
   */
  void printStats (void);

  /*
   * Calculates average cycles per instruction
   *
   * @return double average cycles per instruction
   */
  double calculateGlobalCPI (void);


  /*
   * Calculates the execution/CPU time of a given program.
   *
   * @param prog Program the Program object
   * @see Program
   *
   * @return the execution time in seconds [sec.]
   */
  double calculateExecutionTime(Program prog);

  /*
   * Calculates how many MIPS (Million Instructions Per Second) the
   * computer can process.
   *
   */
  double calculateMIPS(void);

  /*
   * Calculates how many MIPS (Million Instructions Per Second) the
   * computer can process on a given program.
   */
  double calculateMIPS(Program prog);


  double getClockRateGHz(void) const { return this->clockRateGHz;}
  double getCpiArith(void) const {return this->cpiArith;}
  double getCpiStore(void) const {return this->cpiStore;}
  double getCpiLoad(void) const {return this->cpiLoad;}
  double getCpiBranch(void) const {return this->cpiBranch;}

private:
  double clockRateGHz;  // Clock rate in GHz
  double cpiArith;  // CPI of instruction class Arith
  double cpiStore;  // CPI of instruction class Store
  double cpiLoad;  // CPI of instruction class Load
  double cpiBranch;  // CPI of instruction class Branch
};

/*
 * Overloads the << operator for the class computer.
 * when << is called the computer statistics are returned in a
 * ostream.
 *
 * @return ostream with the computer stats.
 */
std::ostream& operator<<(std::ostream& out, const Computer& pc);


#endif /* COMPUTER_H */
