################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/kernel.c \
../src/monitor_amc502_fmc164.c \
../src/monitor_amc502_fmc228.c \
../src/monitor_amc502_fmc228_Nov24.c \
../src/monitor_amc502_fmc228_new.c \
../src/monitor_amc502_fmc228_original.c \
../src/monitor_amc502_fmc228_original_Nov11_2019.c \
../src/monitor_amc502_xaui.c \
../src/monitor_fei4.c \
../src/monitor_fmc228_pcie.c \
../src/monitor_fmc228_pcie_orginal.c \
../src/platform.c 

OBJS += \
./src/kernel.o \
./src/monitor_amc502_fmc164.o \
./src/monitor_amc502_fmc228.o \
./src/monitor_amc502_fmc228_Nov24.o \
./src/monitor_amc502_fmc228_new.o \
./src/monitor_amc502_fmc228_original.o \
./src/monitor_amc502_fmc228_original_Nov11_2019.o \
./src/monitor_amc502_xaui.o \
./src/monitor_fei4.o \
./src/monitor_fmc228_pcie.o \
./src/monitor_fmc228_pcie_orginal.o \
./src/platform.o 

C_DEPS += \
./src/kernel.d \
./src/monitor_amc502_fmc164.d \
./src/monitor_amc502_fmc228.d \
./src/monitor_amc502_fmc228_Nov24.d \
./src/monitor_amc502_fmc228_new.d \
./src/monitor_amc502_fmc228_original.d \
./src/monitor_amc502_fmc228_original_Nov11_2019.d \
./src/monitor_amc502_xaui.d \
./src/monitor_fei4.d \
./src/monitor_fmc228_pcie.d \
./src/monitor_fmc228_pcie_orginal.d \
./src/platform.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MicroBlaze gcc compiler'
	mb-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -I../../standalone_bsp_0/microblaze_I/include -mno-xl-reorder -mlittle-endian -mcpu=v9.6 -mxl-soft-mul -Wl,--no-relax -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


