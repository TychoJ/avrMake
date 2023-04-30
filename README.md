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
