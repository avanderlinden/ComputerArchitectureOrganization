#ifndef _INSTRUCTION_H_
#define _INSTRUCTION_H_

#include <iostream>
#include "registers.h"

using namespace std;

class Instruction
{
protected:
    int regA, regB, regC;

public:
    Instruction();
    Instruction(int numA, int numB, int numC);

    virtual void disassemble(void) {};
    virtual int execute(Registers *reg) {return 0;};
    virtual ~Instruction(){};
};

class AddInstruction : public Instruction {
public:
    AddInstruction(int regNumA, int regNumB, int regNumC)
    : Instruction(regNumA, regNumB, regNumC) {}
    virtual ~AddInstruction(void) {}

    void disassemble(void){/* TBD */}
    int execute(Registers *reg);
};

class SubInstruction : public Instruction {
public:
    SubInstruction(int regNumA, int regNumB, int regNumC)
    : Instruction(regNumA, regNumB, regNumC) {}
    ~SubInstruction(void) {}

    void disassemble(void){/* TBD */}
    int execute(Registers *reg);
};
class OriInstruction : public Instruction {
public:
    OriInstruction(int regNumA, int regNumB, int regNumC)
    : Instruction(regNumA, regNumB, regNumC){}
    ~OriInstruction(void) {}

    void disassemble(void){/* TBD */}
    int execute(Registers *reg);
};
class BrneInstruction : public Instruction {
public:
    BrneInstruction(int regNumA, int regNumB, int regNumC)
    : Instruction(regNumA, regNumB, regNumC){}
    ~BrneInstruction(void) {}

    void disassemble(void){/* TBD */}
    int execute(Registers *reg);
};


#endif /* _INSTRUCTION_H_ */
