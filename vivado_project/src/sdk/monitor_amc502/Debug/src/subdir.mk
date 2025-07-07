################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/monitor_fmc228_pcie.c \
../src/monitor_amc502_fmc228.c \
../src/monitor_amc502_xaui.c \
../src/monitor_fei4.c \
../src/kernel.c \
../src/platform.c 

OBJS += \
./src/kernel.o \
./src/platform.o 

C_DEPS += \
./src/monitor_fmc228_pcie.d \
./src/monitor_amc502_fmc228.d \
./src/monitor_amc502_xaui.d \
./src/monitor_fei4.d \
./src/kernel.d \
./src/platform.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MicroBlaze gcc compiler'
	mb-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -I../../standalone_bsp_0/microblaze_I/include -mno-xl-reorder -mlittle-endian -mcpu=v9.6 -mxl-soft-mul -Wl,--no-relax -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


