# Introduction
This repository hosts hardware implementations for Lattice ice40 FPGA. This is a result of my efforts to learn hardware development. While the hardwares written here may not be of direct use to you, if you were looking for a template infrastructure to start your own development with then the `blinky` project is something you can take a look at.

# Setup
Compilation and flashing has been tested on ubuntu 20.10 and found to be working well. You may need to install `yosys` and `arachne-pnr`packages. This can be done by running the following command:

```
sudo apt install yosys arachne-pnr
```

# Building

## Compiling
`cd` into the directory of the hardware that you want to build and simple execute `make`. This should then generate the `*.bin` file along with other helper files.
```
make
```

## Flashing
To flash the `*.bin` file to the board there is a `prog` target in the `Makefile` for each hardware/project. 
```
sudo make prog
```

## Cleaning
To clean the repo and clear all generated files, from withint the hardware/project directory execute.
```
make clean
```

# Source referred
I have been using the following resources to create these projects.
- [Project IceStorm](http://www.clifford.at/icestorm/)
    - Author: Claire Wolf and Mathias Lasser
    - Title: Project IceStorm
    - hopublished: http://bygone.clairexen.net/icestorm/
- [NandLand](https://www.nandland.com/)