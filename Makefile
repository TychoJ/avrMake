# makefile.xmega.mk
# ^^^^^^^^^^^^^^^^^
# Author : TychoJ 
# Versie : 0.1
# 
# Inspired by : Edwin Boer
#
# File		: make.avr.mk
# Contains	: The configurations for make.avr.mk

# Source code folder
SRCFOLDER = src/
# Object folder
OBJFOLDER = obj/
# Binary folder
BINFOLDER = bin/
# Path to the folder containing the bin/ folder of the AVR toolchain (Keep empty if avr-gcc is added to the $PATH)
AVRFOLDER =
# # Path to the folder containing avrdude (Keep empty if avrdude is added to the $PATH)
DUDEFOLDER = 

# Project name
PROJECTNAME = 
# The AVR microcontroller 
MICROCONTROLLER = 
# The AVR programmer (o.a. avrisp2 and )
# avrisp2	      Atmel AVR ISP mkII
# atmelice	      Atmel-ICE (ARM/AVR) in JTAG mode
# atmelice_dw	  Atmel-ICE (ARM/AVR) in debugWIRE mode
# atmelice_isp	  Atmel-ICE (ARM/AVR) in ISP mode
# atmelice_pdi	  Atmel-ICE (ARM/AVR) in PDI mode
# atmelice_updi   Atmel-ICE (ARM/AVR) in UPDI mode
PROGRAMMER = 
# The (optional) port of the avr programmer (usb, /dev/tty.#)
# PORT = usb
# The fuse values: low, high and extended
# See http://www.engbedded.com/fusecalc/ for fuse values of other microcontrollers
FUSELOW  = 
FUSEHIGH = 
FUSEEXT  = 
# External source code library folders
EXTFOLDER = 
# Compiler flags
CFLAGS = -Wall

# Execute the configurations
include make.avr.mk