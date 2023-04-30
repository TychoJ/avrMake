# makefile.xmega.mk
# ^^^^^^^^^^^^^^^^^
# Author  : TychoJ 
# Version : 0.1
# 
# Inspired by : Edwin Boer
#
# File		: make.avr.mk
# Contains	: The configurations for make.avr.mk

# MIT License
# 
# Copyright (c) 20223 TychoJ
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

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
PROJECTNAME = blink
# The AVR microcontroller 
MICROCONTROLLER = atxmega256a3u
# The AVR programmer (o.a. avrisp2 and )
# avrisp2	      Atmel AVR ISP mkII
# atmelice	      Atmel-ICE (ARM/AVR) in JTAG mode
# atmelice_dw	  Atmel-ICE (ARM/AVR) in debugWIRE mode
# atmelice_isp	  Atmel-ICE (ARM/AVR) in ISP mode
# atmelice_pdi	  Atmel-ICE (ARM/AVR) in PDI mode
# atmelice_updi   Atmel-ICE (ARM/AVR) in UPDI mode
PROGRAMMER = atmelice_isp
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