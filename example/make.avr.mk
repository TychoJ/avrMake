# makefile.xmega.mk
# ^^^^^^^^^^^^^^^^^
# Author : TychoJ
# Versie : 0.1
# 
# Inspired by : Edwin Boer
#
# File		: make.avr.mk
# Contains  : The make process for building/flashing/debuging of AVR microcontrollers
#			  The settings for this make file can be found in: Makefile

# Generate a list of folders to be included
INCLUDELIST := $(foreach dir, $(EXTFOLDER), -I$(dir))
# Generate a list of source code files relative of the source folder
CLIST       := $(foreach file, $(SOURCE), $(SRCFOLDER)$(file))
# Generate a list of library files
EXTLIST     := $(foreach dir, $(EXTFOLDER), $(wildcard $(SRCFOLDER)$(dir)/*.c))
# Generate a list of object files
OBJLIST     := $(patsubst %.c, %.o, $(CLIST)) $(patsubst %.c, %.o, $(EXTLIST))
# Generate a list of object files in the object(sub)folder
OBJLIST2    := $(foreach file, $(OBJLIST), $(OBJFOLDER)$(file))

# Define all tools with standard settings
TOOLC     = $(AVRFOLDER)avr-gcc $(CFLAGS) -Os -mmcu=$(MICROCONTROLLER)
TOOLCOPY  = $(AVRFOLDER)avr-objcopy
TOOLSIZE  = $(AVRFOLDER)avr-size --format=avr --mcu=$(MICROCONTROLLER)
TOOLDUMP  = $(AVRFOLDER)avr-objdump
ifdef PORT
 TOOLDUDE = $(DUDEFOLDER)avrdude -c $(PROGRAMMER) -p $(MICROCONTROLLER) -P $(PORT)
else
 TOOLDUDE = $(DUDEFOLDER)avrdude -c $(PROGRAMMER) -p $(MICROCONTROLLER)
endif

# Public goals

# Goal: make help
help: _start _help1 _end

_start:
	@echo
	@echo "#################################"
	@echo "  > Start: make.avr.mk"

_help1: 
	@echo "_________________________________"
	@echo "  > Possible options:"
	@echo "    make        := Show this help message."
	@echo "    make help   := Show this help message."
	@echo "    make all    := Compile and link the source code."
	@echo "    make flash  := Compile and link the source code and write the compiled hex-file to"
	@echo "                   the flash memory of the microcontroller"
	@echo "    make test   := Test the connection between the programmer and the microcontroller."
	@echo "    make fuse   := Write the fuse bytes to the mircrocontroller."
	@echo "    make disasm := Disassemble the code for debugging."
	@echo "    make clean  := Delete all generated .hex, .elf, and .o files."
	
_end:
	@echo
	@echo "#################################"
	@echo "  > Finished :-)"
	@echo

# Goal: make all
all: _start _all1 $(BINFOLDER)$(PROJECTNAME).hex _end

_all1: 
	@echo "  > Goal: Compile and link the source code."
	@echo "  > Object folder: $(OBJFOLDER)"
	@echo "  > Binary folder: $(BINFOLDER)"
	@mkdir -p $(OBJFOLDER)
	@mkdir -p $(BINFOLDER)

# Goal: make flash
flash: _start _flash1 $(BINFOLDER)$(PROJECTNAME).hex _flash2 _end

_flash1: 
	@echo "  > Goal: Compile and link the source code and write the compiled hex-file to the flash memory of the microcontroller."
	@echo "  > binaray folder: $(BINFOLDER)"
	@mkdir -p $(BINFOLDER)

_flash2: 
	@echo "_________________________________"
	@echo " > Start flash"
	$(TOOLDUDE) -e -U flash:w:$(BINFOLDER)$(PROJECTNAME).hex

# Goal: make test
test: _start _test1 _end

_test1:
	@echo "  > Goal: Test the connection between the programmer and the microcontroller."
	$(TOOLDUDE) -v

# Goal: make fuse
fuse: _start _fuse1 _end

_fuse1:
	@echo "  > Goal: Write the fuse bytes to the mircrocontroller."
	$(TOOLDUDE) -U lfuse:w:$(FUSELOW):m -U hfuse:w:$(FUSEHIGH):m -U efuse:w:$(FUSEEXT):m

# Goal: make disasm
disasm: _start _disasm1 $(BINFOLDER)/$(PROJECTNAME).elf _disasm2 _end

_disasm1: 
	@echo	"  > Goal: Disassemble the code for debugging."

_disasm2: $(BINFOLDER)/$(PROJECTNAME).elf
	$(TOOLDUMP) -d $(BINFOLDER)$(PROJECTNAME).elf

# Goal: make clean
clean: _start _clean _end

_clean:
	@echo "  > Goal: Delete all generated .hex, .elf, and .o files."
	rm -f    $(BINFOLDER)$(PROJECTNAME).hex 
	rm -f    $(BINFOLDER)$(PROJECTNAME).elf
	rm -f -r $(OBJFOLDER)$(SRCFOLDER)

# Create specific file formats
$(BINFOLDER)$(PROJECTNAME).hex: $(BINFOLDER)$(PROJECTNAME).elf
	@echo "_________________________________"
	@echo "  > Generate hex-file"
	rm -f $(BINFOLDER)$(PROJECTNAME).hex
	$(TOOLCOPY) -j .text -j .data -O ihex $(BINFOLDER)$(PROJECTNAME).elf $(BINFOLDER)$(PROJECTNAME).hex
	@echo "_________________________________"
	@echo "  > Memory usage"
	$(TOOLSIZE) $(BINFOLDER)$(PROJECTNAME).elf

$(BINFOLDER)$(PROJECTNAME).elf: _compiler $(OBJLIST)
	@echo "_________________________________"
	@echo "  > Start linker"
	$(TOOLC) -o $(BINFOLDER)$(PROJECTNAME).elf $(OBJLIST2)

_compiler:
	@echo "OBJLIST: $(OBJLIST)"
	@echo "OBJLIST2: $(OBJLIST2)"
	@echo "_________________________________"
	@echo "  > Start compiler"

%.o: %.c
	@mkdir -p $(OBJFOLDER)$(dir $@)
	@echo "test"
	$(TOOLC) $(INCLUDELIST) -c -o $(OBJFOLDER)$@ $< 
