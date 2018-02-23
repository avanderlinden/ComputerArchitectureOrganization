/*
 * computer.cpp
 *
 *      Author: Alex van der Linden
 */
#include "computer.h"


Computer::Computer(double clockRateGHz, double cpiArith, double cpiStore,
		double cpiLoad, double cpiBranch)
{
	this->clockRateGHz = clockRateGHz;
	this->cpiArith = cpiArith;
	this->cpiStore = cpiStore;
	this->cpiLoad = cpiLoad;
	this->cpiBranch = cpiBranch;

}

std::ostream& operator<<(std::ostream& out, const Computer& pc)
{
	out<<"Clock rate\t: " << pc.getClockRateGHz() << " [GHz]\n";
	out<<"CPI Arith\t: " << pc.getCpiArith() << " [cpi]\n";
	out<<"CPI Store\t: " << pc.getCpiStore() << " [cpi]\n";
	out<<"CPI Load\t: " << pc.getCpiLoad() << " [cpi]\n";
	out<<"CPI Branch\t: " << pc.getCpiBranch() << " [cpi]\n";

    return out;
}

void Computer::printStats(void)
{
	std::cout << this;
}

double Computer::calculateGlobalCPI(void)
{
	double average_cpi = (this->cpiArith + this->cpiStore +
			+ this->cpiLoad + this->cpiBranch)/4.0;

	return average_cpi;
}

double Computer::calculateExecutionTime(Program prog)
{
	double cpu_cycles = this->cpiArith * prog.getNumArith()
						+ this->cpiStore * prog.getNumStore()
						+ this->cpiLoad * prog.getNumLoad()
						+ this->cpiBranch * prog.getNumBranch();

	double cpu_time = cpu_cycles / (this->clockRateGHz * 1000000000);

	return cpu_time;
}

double Computer::calculateMIPS(void)
{
	// clock rate * 1000 because Million and Giga differ by factor 1000
	double mips = (this->clockRateGHz * 1000) / this->calculateGlobalCPI();
	return mips;
}

double Computer::calculateMIPS(Program prog)
{
	double ips = (prog.getNumTotal() / this->calculateExecutionTime(prog));
	return ips / 1000000; // convert IPS to MIPS
}


