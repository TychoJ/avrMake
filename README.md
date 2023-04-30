# avrMake
A make script to compile source code for avr microcontrollers and program avr microcontrollers


# Installation
To make use of these make files some dependencies must be installed first.

* AVR 8-Bit toolchain
* avrdude

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



## Windows
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
