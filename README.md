# avrMake
A make script to compile source code for avr microcontrollers and program avr microcontrollers


# Installation
To make use of these make files some dependencies must be installed first.

* AVR 8-Bit toolchain
* avrdude

## Installing the newest version of avrdude

To install the newest version of avrdude you can go to the following link: [Avrdude Build/Installation Guide](https://github.com/avrdudes/avrdude/wiki/Building-AVRDUDE-for-Linux)
This might be nessesary depending on your programmer, for MPLAB SNAP usage you'll have to visit the link and update your avrdude.
After installation you'll need to restart your WSL by using in your PowerShell:
```
wsl --shutdown
``` 
After running the command you can start WSL again. 

## Linux
Download the AVR 8-Bit toolchain for linux from [microchips website](https://www.microchip.com/en-us/tools-resources/develop/microchip-studio/gcc-compilers)

Extract the downloaded tar.gz file and add `avr8-gnu-toolchain-linux_x86_64/bin` to the system `$PATH` variable.

Download avrdude
```console
foo@bar: sudo apt install avrdude
```


## Mac
Download the AVR 8-Bit toolchain for mac from [microchips website](https://www.microchip.com/en-us/tools-resources/develop/microchip-studio/gcc-compilers)

Extract the downloaded tar.gz file and add `yourPath/avr8-gnu-toolchain-darwin_x86_64/bin` to the system `$PATH`

Download avrdude [from gnu](http://download.savannah.gnu.org/releases/avrdude/), extract the tar.gz and add the bin directory to the `$path`.

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

### Adding USB support to WSL
First we'll have to Install the USBIPD-WIN project to add support of USB devices to WSL.

To do this you'll need to run Windows PowerShell (As Administrator), in Windows PowerShell you can run the following command:
```PowerShell
winget install --interactive --exact dorssel.usbipd-win
```
This will intall USBIPD on your windows machine.
If you leave out --interactive, winget may immediately restart your computer if that is required to install the drivers. After installation you'll have to restart your device for USBIPD to work. 

After the restart you can use the following command in PowerShell (As Administrator):
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

Sadly if you try and use the makefile after folling the steps found in ``Adding USB support to WSL``, avrdude will give you an error. To fix this you'll have to do a few extra steps. 
Start with creating a new udev rule by running:
```bash
nano /etc/udev/rules.d/10-local.rules
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


## Windows without WSL
For windows there is another dependency: msys2.

To install msys go to the [msys2 websit](https://www.msys2.org/) and download the installer and use the installer to install msys2.

Start the msys2 shell and run the following commands:
```console
user@pcName MINGW64 ~
$ pacman -Syu

user@pcName MINGW64 ~
$ pacman -S --needed base-devel mingw-w64-x86_64-toolchain
```

Install the AVR 8-Bit toolchain in the msys2 shell
```console
user@pcName MINGW64 ~
$ pacman -S mingw-w64-x86_64-avr-toolchain
```

Install avrdude in the msys2 shell
```console
user@pcName MINGW64 ~
$ pacman -S mingw-w64-x86_64-avrdude
```


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
