ifneq ($(KERNELRELEASE),)
	obj-m := vt_simple_pcie_drv.o
else
	KERNELDIR ?= ../../kernel	
	PWD := $(shell pwd)

default:
	export PATH=${PATH}:$(PWD)/../../tmp/sysroots/$(shell uname -m)-linux/usr/bin/ppce500mc-fsl-linux && \
		$(MAKE) -C $(KERNELDIR) M=$(PWD) ARCH=powerpc CROSS_COMPILE=powerpc-fsl-linux- modules

clean:
	export PATH=${PATH}:$(PWD)/../../tmp/sysroots/$(shell uname -m)-linux/usr/bin/ppce500mc-fsl-linux && \
		$(MAKE) -C $(KERNELDIR) M=$(PWD) ARCH=powerpc CROSS_COMPILE=powerpc-fsl-linux- clean
endif
