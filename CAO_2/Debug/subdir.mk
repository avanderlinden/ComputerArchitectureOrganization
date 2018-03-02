################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../instruction.cpp \
../main.cpp \
../program.cpp \
../registers.cpp \
../simulator.cpp 

OBJS += \
./instruction.o \
./main.o \
./program.o \
./registers.o \
./simulator.o 

CPP_DEPS += \
./instruction.d \
./main.d \
./program.d \
./registers.d \
./simulator.d 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -O0 -g3 -Wall -c -fmessage-length=0 -std=c++11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


