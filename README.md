# Introduction

This repository is a result of my wanting to learn HDL languages and digital hardware design. This repo hosts hardware implementations deployed on the Lattice FPGAs -
1. hx1k based [iCEStick](https://www.latticesemi.com/icestick)
2. hx8k based [Alchitry-Cu](https://github.com/4rzael/spinal-alchitry-cu)

The choice of FPGAs is primarily based on the availability of the open-source toolchain. Examples include -

| Example | Path | FPGA |
| -------- | -------- | -------- |
| Blinky   | iCEStick-hx1k/blinky   | hx1k   |
| Logic Gates   | iCEStick-hx1k/gates   | hx1k   |
|Multiplexer|iCEStick-hx1k/mux|hx1k|
|Uart|iCEStick-hx1k/uart|hx1k|
|Blinky|alchitry-Cu-hx8k/blinky|hx8k|
|7 Segment Display| alchitry-Cu-hx8k/7seg|hx8k|

# Setup

I've tested the following command on Ubuntu and Mac. The toolchain used consists of -
1. **Yosys**: To convert the Verilog/System Verilog to Netlist.
1. **Arachne-pnr**: Convert the Netlist to the FPGA-specific place and route.
1. **Icestorm tools**: Converting between file formats and upload the binary to the FPGA.

Use the following commands to install the toolchain -

## Linux
```
sudo apt install build-essential clang bison flex libreadline-dev \
                     gawk tcl-dev libffi-dev git mercurial graphviz \
                     xdot pkg-config python3 libftdi-dev
```

## Mac

```
brew install bison flex gawk graphviz xdot pkg-config python3
```

## Linux/Mac

### Icestorm Tools
```
git clone https://github.com/cliffordwolf/icestorm.git icestorm
cd icestorm
make -j$(nproc)
sudo make install
```

### Arachne-pnr

```
git clone https://github.com/cseed/arachne-pnr.git arachne-pnr
cd arachne-pnr
make -j$(nproc)
sudo make install
```

### Yosys
```
git clone https://github.com/cliffordwolf/yosys.git yosys
cd yosys
make -j$(nproc)
sudo make install
```

# Building

For each of the examples, from the location of the example, you can execute the following commands to compile the Verilog and upload it to the board.

## Compiling
`cd` into the directory of the hardware that you want to build and simple execute `make`. This should then generate the `*.bin` file along with other helper files.
```
make
```

## Uploading
To flash the `*.bin` file to the board there is a `prog` target in the `Makefile` for each hardware/project.
```
sudo make prog
```

## Cleaning
To clean the repo and clear all generated files, from within the hardware/project directory execute.
```
make clean
```

# Referrences
I have been using the following resources to create these projects.
- [Project IceStorm](http://www.clifford.at/icestorm/)
    - Author: Claire Wolf and Mathias Lasser
    - Title: Project IceStorm
    - hopublished: http://bygone.clairexen.net/icestorm/
- [NandLand](https://www.nandland.com/)
- [spinal-alchitry-cu](https://github.com/4rzael/spinal-alchitry-cu/)
    - Alchitry-IO pin names
