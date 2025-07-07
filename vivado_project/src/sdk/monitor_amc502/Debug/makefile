################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include src/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
ELFSIZE += \
monitor_amc502_xaui.elf.size \
monitor_amc502_xaui_fei4.elf.size \
monitor_amc502_fmc164.elf.size \
monitor_amc502_fmc228.elf.size \
monitor_fmc228_pcie.elf.size

# All Target
all: monitor_amc502_fmc228.elf monitor_amc502_fmc164.elf monitor_amc502_xaui.elf monitor_amc502_xaui_fei4.elf monitor_fmc228_pcie.elf secondary-outputs

# Tool invocations
monitor_amc502_xaui.elf: ./src/monitor_amc502_xaui.o $(OBJS) ../src/lscript.ld $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: MicroBlaze gcc linker'
	mb-gcc -Wl,-T -Wl,../src/lscript.ld -L../../standalone_bsp_0/microblaze_I/lib -mlittle-endian -mcpu=v9.6 -mxl-soft-mul -Wl,--no-relax -o "monitor_amc502_xaui.elf" ./src/monitor_amc502_xaui.o $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

monitor_amc502_xaui_fei4.elf: ./src/monitor_fei4.o $(OBJS) ../src/lscript.ld $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: MicroBlaze gcc linker'
	mb-gcc -Wl,-T -Wl,../src/lscript.ld -L../../standalone_bsp_0/microblaze_I/lib -mlittle-endian -mcpu=v9.6 -mxl-soft-mul -Wl,--no-relax -o "monitor_amc502_xaui_fei4.elf" ./src/monitor_fei4.o $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

monitor_amc502_fmc164.elf: ./src/monitor_amc502_fmc164.o $(OBJS) ../src/lscript.ld $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: MicroBlaze gcc linker'
	mb-gcc -Wl,-T -Wl,../src/lscript.ld -L../../standalone_bsp_0/microblaze_I/lib -mlittle-endian -mcpu=v9.6 -mxl-soft-mul -Wl,--no-relax -o "monitor_amc502_fmc164.elf" ./src/monitor_amc502_fmc164.o $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

monitor_fmc228_pcie.elf: ./src/monitor_fmc228_pcie.o $(OBJS) ../src/lscript.ld $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: MicroBlaze gcc linker'
	mb-gcc -Wl,-T -Wl,../src/lscript.ld -L../../standalone_bsp_0/microblaze_I/lib -mlittle-endian -mcpu=v9.6 -mxl-soft-mul -Wl,--no-relax -o "monitor_fmc228_pcie.elf" ./src/monitor_fmc228_pcie.o $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

monitor_amc502_fmc228.elf: ./src/monitor_amc502_fmc228.o $(OBJS) ../src/lscript.ld $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: MicroBlaze gcc linker'
	mb-gcc -Wl,-T -Wl,../src/lscript.ld -L../../standalone_bsp_0/microblaze_I/lib -mlittle-endian -mcpu=v9.6 -mxl-soft-mul -Wl,--no-relax -o "monitor_amc502_fmc228.elf" ./src/monitor_amc502_fmc228.o $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

monitor_amc502_xaui.elf.size: monitor_amc502_xaui.elf
	@echo 'Invoking: MicroBlaze Print Size'
	mb-size monitor_amc502_xaui.elf  |tee "monitor_amc502_xaui.elf.size"
	@echo 'Finished building: $@'
	@echo ' '

monitor_amc502_fmc164.elf.size: monitor_amc502_fmc164.elf
	@echo 'Invoking: MicroBlaze Print Size'
	mb-size monitor_amc502_fmc164.elf  |tee "monitor_amc502_fmc164.elf.size"
	@echo 'Finished building: $@'
	@echo ' '

monitor_amc502_fmc228.elf.size: monitor_amc502_fmc228.elf
	@echo 'Invoking: MicroBlaze Print Size'
	mb-size monitor_amc502_fmc228.elf  |tee "monitor_amc502_fmc228.elf.size"
	@echo 'Finished building: $@'
	@echo ' '

monitor_fmc228_pcie.elf.size: monitor_fmc228_pcie.elf
	@echo 'Invoking: MicroBlaze Print Size'
	mb-size monitor_fmc228_pcie.elf  |tee "monitor_fmc228_pcie.elf.size"
	@echo 'Finished building: $@'
	@echo ' '

monitor_amc502_xaui_fei4.elf.size: monitor_amc502_xaui_fei4.elf
	@echo 'Invoking: MicroBlaze Print Size'
	mb-size monitor_amc502_xaui_fei4.elf  |tee "monitor_amc502_xaui_fei4.elf.size"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(EXECUTABLES)$(OBJS)$(S_UPPER_DEPS)$(C_DEPS)$(ELFSIZE) monitor_amc502_xaui.elf
	-@echo ' '

secondary-outputs: $(ELFSIZE)

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
