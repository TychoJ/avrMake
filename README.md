# avrMake
A make script to compile source code for avr microcontrollers and program avr microcontrollers

# Table of contents
1. [Installation](#Installation)
	1. [Linux](#Linux)
		1. [AVR 8-Bit toolchain](#avr8bitToolchain)
		2. [avrdude](#linuxAvrdude)
		3. [make](#linuxMake)
	2. [MAC](#Mac)
	3. [Windows](#Windows)
2. [Usage](#Usage)
3. [Known issues](#knownIssues)
	1. [ATtiny](#knownIssuesATtiny)

<div id="Installation"/>

# Installation
To make use of these make files some dependencies must be installed first.

* AVR 8-Bit toolchain
* avrdude
* make

<div id="Linux"/>

## Installing the newest version of avrdude

To install the newest version of avrdude you can go to the following link: [Avrdude Build/Installation Guide](https://github.com/avrdudes/avrdude/wiki/Building-AVRDUDE-for-Linux)
This might be nessesary depending on your programmer, for MPLAB SNAP usage you'll have to visit the link and update your avrdude.
After installation you'll need to restart your WSL by using in your PowerShell:
```
wsl --shutdown
``` 
After running the command you can start WSL again. 

## Linux

<div id="avr8bitToolchain"/>

### AVR 8-Bit toolchain
The AVR 8-Bit toolchain for linux can be downloaded from [microchips website](https://www.microchip.com/en-us/tools-resources/develop/microchip-studio/gcc-compilers). 
The downloaded file is a tar.gz file containing the AVR 8-Bit toolchain. </br>
Extract the downloaded tar.gz file and place `avr8-gnu-toolchain-linux_x86_64/` in the  `/opt/` directory. </br>
Now add `/opt/avr8-gnu-toolchain-linux_x86_64/bin` to the system `$PATH` variable.

To check if the toolchain is installed correct run:
```console
foo@bar: ~ $ avr-gcc --version
```
This should output the following:
```console
avr-gcc (GCC) <VERSION>
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```
where `<VERSION>` is the version of avr-gcc.

<div id="linuxAvrdude"/>

### avrdude
Install avrdude with:
```console
foo@bar: ~ $ sudo apt install avrdude
```
To check if avrdude is installed correctly run:
```console
foo@bar: ~ $ avrdude -v
```
This should output the following
```console
avrdude: Version <VERSION>
         Copyright (c) 2000-2005 Brian Dean, http://www.bdmicro.com/
         Copyright (c) 2007-2014 Joerg Wunsch

         System wide configuration file is "/etc/avrdude.conf"
         User configuration file is "/home/tychoj/.avrduderc"
         User configuration file does not exist or is not a regular file, skipping


avrdude: no programmer has been specified on the command line or the config file
         Specify a programmer using the -c option and try again
```
where `<VERSION>` is the version of avrdude.

<div id="linuxMake"/>

### make
Install make with:
```console
foo@bar: ~ $ sudo apt install make
```
To check if make is installed correctly run:
```console
foo@bar: ~ $ make --version
```
This should output the following:
```console
GNU Make <VERSION>
Built for x86_64-pc-linux-gnu
Copyright (C) 1988-2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
```
Where `<VERSION> is the version of make.

<div id="Mac"/>

## Mac
Download the AVR 8-Bit toolchain for mac from [microchips website](https://www.microchip.com/en-us/tools-resources/develop/microchip-studio/gcc-compilers)

Extract the downloaded tar.gz file and add `yourPath/avr8-gnu-toolchain-darwin_x86_64/bin` to the system `$PATH`

Download avrdude [from gnu](http://download.savannah.gnu.org/releases/avrdude/), extract the tar.gz and add the bin directory to the `$path`.

<div id="Windows"/>

## Windows WSL (Windows Subsystem for Linux)

For WSL of this AVR Makefile you'll need to be running WSL version 2 and a Windows 11 build 22000 or later. Windows 10 works, but is not fully supported by Microsoft.
In this example we are using WSL2 with Ubuntu 22.04.02 LTS.

To check your WSL version use the following command in PowerShell:
```PowerShell
wsl -l -v
```
To check your Windows version run the following command in PowerShell:
```PowerShell
Get-ComputerInfo | select OsBuildNumber
```
This will only show version 22000+ if you are on Windows 11. 

### Adding USB support to WSL
First we'll have to Install the USBIPD-WIN project to add support of USB devices to WSL.

To do this you'll need to run Windows PowerShell (As Administrator), in Windows PowerShell you can run the following command:
```PowerShell
winget install --interactive --exact dorssel.usbipd-win
```
This will install USBIPD on your windows machine.
If you leave out --interactive, winget may immediately restart your computer if that is required to install the drivers. After installation you'll have to restart your device for USBIPD to work. 

Run the following commands to add USBIP tools and hardware database in WSL:
```bash
sudo apt install linux-tools-generic hwdata
```
```bash
sudo update-alternatives --install /usr/local/bin/usbip usbip /usr/lib/linux-tools/*-generic/usbip 20
```


You can use the following command in PowerShell (As Administrator) to see a list of connected devices:
```PowerShell
usbipd wsl list
```
This will show you all connected USB devices and their Bus ID's. You can use these ID's to attach a USB port to your WSL using this command:
```PowerShell
usbipd wsl attach --busid <busid>
```
Please note that WSL should be running for this command to work.
You'll have to use this command every time you restart WSL or replug your programmer.     
To confirm the the device is now attached in linux you can run the following command on Windows: 
```PowerShell 
usbipd wsl list
```
and/or the following command within WSL:
```
lsusb
```

More in depth USB WSL tutorial can be found on the official Microsoft website: [Connect USB devices WSL](https://learn.microsoft.com/en-us/windows/wsl/connect-usb)  

#### Programming with WSL problems

Sadly if you try and use the makefile after following the steps found in ``Adding USB support to WSL``, avrdude will give you an error. To fix this you'll have to do a few extra steps.   
Start with creating a new udev rule by running:
```bash
sudo nano /etc/udev/rules.d/10-local.rules
```
Paste the following line in the created file:
```bash
SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", IMPORT{builtin}="usb_id", IMPORT{builtin}="hwdb --subsystem=usb", MODE="0666"
```

This ensures that a normal (non-root) user can use the USB.

After creating the file you can restart the udev service with:
```bash
sudo service udev restart
```  
This should complete the WSL installation and you can configure and use the Makefile. 

<div id="Usage"/>

# Usage
To make use of this make file system the project should have the following structure:
```

├── make.avr.mk
├── Makefile
├── libs
│   ├── a
│   ├── b
│   └── c
└── src
    ├── blink.c
    └── subdir
```
The libs folder is not necessary but can be used to differentiate between libraries that are written to be used within multiple projects and libraries specifically written for the current application.

The main advantage is when using git submodules for libraries that are written to be used for multiple projects is that now all the git submodules can be placed at one location.

As the second step in setting up the project change `[your project name]` the your own project name (this can be anything but there should be no spaces in the project name) 
```makefile
# Project name
PROJECTNAME = [your project name]
```

Add the name of the AVR microcontroller at `[avr microcontroller]`. See the avr-libc [user manual](https://www.nongnu.org/avr-libc/user-manual/using_tools.html) if you don't know what the correct name is of your AVR microcontroller. The name can be found under the `-mmcu` flag and is the `MCU name` column. 
```makefile
# The AVR microcontroller 
MICROCONTROLLER = [avr microcontroller]
```

To build the project go to the project directory with the terminal in linux/mac and on windows go to the project directory with the minggw64 shell. The `make all` command will compile and link the source code.
```console
foo@bar: ~/pathToProject/ $ make all
```

The `make test` command will test the connection between the programmer and the microcontroller 
```console
foo@bar: ~/pathToProject/ $ make test
```

The `make flash` command will compile and link the source code and write the compiled hex-file to the flash memory of the microcontroller.
```console
foo@bar: ~/pathToProject/ $ make flash
```

The `make clean` command will delete all generated .hex, .elf, and .o files.
```console
foo@bar: ~/pathToProject/ $ make clean
```

The `make distclean` command will delete all generated .hex, .elf and .o files as wel as the `$(BINFOLDER)` and the `$(OBJFOLDER)` folders.
```console
foo@bar: ~/pathToProject/ $ make distclean
```

For more information run `make help`
```console
foo@bar: ~/pathToProject/ $ make help
```
<div id="knownIssues"/>
# Known issues

Some known problems are described here. Some of these problems are not a problem with this tool but with the dependencies of this tool.

<div id="knownIssuesATtiny"/>

## ATtiny
Some ATtiny chips are not (yet) known by libc and require the downloading of extra files. These files can be found at [Microchips website](http://packs.download.atmel.com/).
Download the `Atmel ATtiny Series Device Support` file is a zip file eventhough it has the file extension `.atpack`.

Make a temporary folder in which the `Atmel.ATtiny_DFP.2.0.368.atpack` zip archive can be extracted. and run the following commands 
(These are the commands on linux for when `avr8-gnu-toolchain-linux_x86_64/` is installed in the `/opt/` directory)
```console
foo@bar: ~/Downloads/tmp/ $ sudo cp include/avr/iotn?*1[2467].h /opt/avr8-gnu-toolchain-linux_x86_64/avr/include/avr/

foo@bar: ~/Downloads/tmp/ $ sudo cp gcc/dev/attiny?*1[2467]/avrxmega3/*.{o,a} /opt/avr8-gnu-toolchain-linux_x86_64/avr/lib/avrxmega3/

foo@bar: ~/Downloads/tmp/ $ sudo cp gcc/dev/attiny?*1[2467]/avrxmega3/short-calls/*.{o,a} /opt/avr8-gnu-toolchain-linux_x86_64/avr/lib/avrxmega3/short-calls/
```
At last `/opt/avr8-gnu-toolchain-linux_x86_64/avr/include/avr/io.h` add the following:
```c
#elif defined (__AVR_ATtiny212__)
#  include <avr/iotn212.h>
#elif defined (__AVR_ATtiny412__)
#  include <avr/iotn412.h>
#elif defined (__AVR_ATtiny214__)
#  include <avr/iotn214.h>
#elif defined (__AVR_ATtiny414__)
#  include <avr/iotn414.h>
#elif defined (__AVR_ATtiny814__)
#  include <avr/iotn814.h>
#elif defined (__AVR_ATtiny1614__)
#  include <avr/iotn1614.h>
#elif defined (__AVR_ATtiny3214__)
#  include <avr/iotn3214.h>
#elif defined (__AVR_ATtiny416__)
#  include <avr/iotn416.h>
#elif defined (__AVR_ATtiny816__)
#  include <avr/iotn816.h>
#elif defined (__AVR_ATtiny1616__)
#  include <avr/iotn1616.h>
#elif defined (__AVR_ATtiny3216__)
#  include <avr/iotn3216.h>
#elif defined (__AVR_ATtiny417__)
#  include <avr/iotn417.h>
#elif defined (__AVR_ATtiny817__)
#  include <avr/iotn817.h>
#elif defined (__AVR_ATtiny1617__)
#  include <avr/iotn1617.h>
#elif defined (__AVR_ATtiny3217__)
#  include <avr/iotn3217.h>
```

A big thank you goes to LeoNerd who wrote [this article](http://leonerds-code.blogspot.com/2019/06/building-for-new-attiny-1-series-chips.html) on how to add ATtiny support.
