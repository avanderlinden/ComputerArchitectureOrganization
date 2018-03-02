#ifndef _REGISTERS_H_
#define _REGISTERS_H_

#include <array>
#include <ostream>

class Registers
{
public:

    /*
     * Constructor
     */
    Registers();

	/*
	 * Sets register (0-31) to a integer value.
	 *
	 * @param regNum the register number between 0-31
	 * @param value the value to be assigned to the register
	 */
	void setRegister(int regNum, int value);

	/*
	 * gets the value inside a register (0-31)
	 *
	 * @param regNum the register number between (0-31)
	 *
	 * @return the integer value stored in the register
	 */
	int getRegister(int regNum);

	/*
	 * Sets the program counter to a value
	 *
	 * @param value the value to set the program counter to
	 */
	void setPC(int value);

	/*
	 * Gets the program counter
	 *
	 * @return the program counter on this moment.
	 */
	int getPC(void);

	/*
	 * Prints the content of the register and the progam counter
	 *
	 */
	void print(void);


private:
	int reg[32];
	int program_counter;

};


#endif	/* _REGISTERS_H_ */
