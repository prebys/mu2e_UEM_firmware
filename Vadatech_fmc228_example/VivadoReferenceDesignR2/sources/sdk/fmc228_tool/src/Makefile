BOARD=fmc228

CROSS_COMPILE=powerpc-fsl-linux-
CC=../tmp/sysroots/$(shell uname -m)-linux/usr/bin/ppce500mc-fsl-linux/powerpc-fsl-linux-gcc --sysroot=../tmp/sysroots/p2041rdb/
NATIVE_CC=gcc
TOOL_LB=$(BOARD)_tool_lb
TOOL_DRV=$(BOARD)_tool_drv
TOOL_MMAP=$(BOARD)_tool_mmap

C_FILES := $(wildcard *.c)
OBJ_LB_FILES := $(subst .c,.olb, $(C_FILES))
OBJ_DRV_FILES := $(subst .c,.odrv, $(C_FILES))
OBJ_MMAP_FILES := $(subst .c,.ommap, $(C_FILES))

# check if the cross compiler exists
ifeq ("$(wildcard $(CC))","")
  $(warning "The cross complier is not found. skipping build $(TOOL_LB) and $(TOOL_DRV).")
  all: $(TOOL_MMAP)
else	
  all: $(TOOL_LB) $(TOOL_DRV) $(TOOL_MMAP)
  
  $(TOOL_LB): $(OBJ_LB_FILES)
	$(CC) -o $@ $^

  $(TOOL_DRV): $(OBJ_DRV_FILES)
	$(CC) -o $@ $^
	
  %.olb: %.c
	$(CC) -DACCESS_INTERFACE=P2040_LB -c -o $@ $<	
	
  %.odrv: %.c
	$(CC) -DACCESS_INTERFACE=PCIE_DEV_DRV -c -o $@ $<	
endif

$(TOOL_MMAP): $(OBJ_MMAP_FILES)
	$(NATIVE_CC) -o $@ -lpci $^

%.ommap: %.c
	$(NATIVE_CC) -DACCESS_INTERFACE=PCIE_MMAP -c -o $@ $<
	
# generating prerequisites
-include $(subst .c,.d, $(wildcard *.c))

%.d: %.c
	@set -e; rm -f $@; \
	$(NATIVE_CC) -MM $(CPPFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.olb \1.odrv \1.ommap $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$

	
.PHONY: clean 
clean:
	rm -f *.d *.o *.olb *.odrv *.ommap $(TOOL_LB) $(TOOL_DRV) $(TOOL_MMAP)

