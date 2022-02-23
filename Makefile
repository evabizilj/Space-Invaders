export PATH := /opt/Xilinx/Vivado/2020.2/bin:${PATH}

PROJECT_DIR := $(abspath $(lastword $(MAKEFILE_LIST)))
DIST_DIR := $(shell stack path --dist-dir)
BUILD_DIR := ${DIST_DIR}/build

DESIGN := project
DEVICE := xc7a100tcsg324-1
BOARD_DIR := 
XDC_FILE := Nexys-4-Master.xdc

STACK_FLAGS := --ghc-options -j$(shell nproc)

all: program

build:
	stack build ${STACK_FLAGS}

repl:
	stack exec -- clashi

vhdl: build
	stack exec -- clash --vhdl -odir ${BUILD_DIR} -hidir ${BUILD_DIR} src/Example/Project.hs

program: vhdl
	cd vivado ; vivado -mode batch -nolog -nojournal -source full_fast.tcl -tclargs ${DESIGN} ${DEVICE} ${XDC_FILE}

clean:
	rm -rf vhdl

.PHONY: all build repl vhdl program clean
