/*
 * instruction.cpp
 *
 *  Created on: Mar 1, 2018
 *      Author: Alex van der Linden
 *
 */

#include "instruction.h"

using namespace std;

Instruction::Instruction(){
    regA = 0;
    regB = 0;
    regC = 0;
}

Instruction::Instruction(int numA, int numB, int numC){
    regA = numA;
    regB = numB;
    regC = numC;
}

int AddInstruction::execute(Registers * reg) {
    reg->setRegister(regA, reg->getRegister(regB) + reg->getRegister(regC));
    reg->setPC(reg->getPC()+1);
    return reg->getPC();
}

int SubInstruction::execute(Registers * reg) {
    reg->setRegister(regA, reg->getRegister(regB) - reg->getRegister(regC));
    reg->setPC(reg->getPC()+1);
    return reg->getPC();
}

int OriInstruction::execute(Registers * reg) {
    reg->setRegister(regA, reg->getRegister(regB) | reg->getRegister(regC));
    reg->setPC(reg->getPC()+1);
    return reg->getPC();
}

int BrneInstruction::execute(Registers * reg) {
    if (!((reg->getRegister(regA)) == (reg->getRegister(regB))) ) {
        reg->setPC(reg->getPC()+1+regC);
    }
    else {
        reg->setPC(reg->getPC()+1);
    }
    return reg->getPC();
}



