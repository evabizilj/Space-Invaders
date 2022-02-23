package require fileutil

# Gathering TCL Args
set DESIGN [lindex $argv 0]
set DEVICE [lindex $argv 1]
set XDC_FILE [lindex $argv 2]

set VHDL_DIR ../vhdl
set XCI_FILES [ glob $VHDL_DIR/*.xci ]

set_param general.maxThreads 16

create_project -in_memory -part ${DEVICE} -force ${DESIGN}

set_property ip_output_repo {$VHDL_DIR} [current_project]
set_property board_part_repo_paths {board} [current_project]
set_property board_part digilentinc.com:nexys4:part0:1.1 [current_project]
read_ip $XCI_FILES

generate_target all [ get_files $XCI_FILES ]
synth_ip [ get_files $XCI_FILES ]
get_files -all -of_objects [ get_files $XCI_FILES ]
foreach path [ glob -nocomplain $VHDL_DIR/*/*_sim_* ] { file delete --force -- $path }

#
# STEP#1: setup design sources and constraints
#
add_files [ glob $VHDL_DIR/*/*.v $VHDL_DIR/*/*/*.vhdl ]
read_xdc [ glob $VHDL_DIR/*.xdc $VHDL_DIR/*/*.xdc ]

#
# STEP#2: run synthesis
#
synth_design -name ${DESIGN} -top top -part ${DEVICE}

#
# STEP#3: run placement and logic optimzation, report utilization and timing estimates, write checkpoint design
#
#opt_design
place_design
#phys_opt_design

#
# STEP#4: run router, run drc
#
# Routes the design onto the target Xilinx device.
route_design


#
# STEP#5: generate a bitstream
#
write_bitstream -force ${DESIGN}.bit

#
# STEP#6: program the bitstream
#
load_features labtools

open_hw_manager
connect_hw_server -url TCP:localhost:3121

set targu [get_hw_targets *]
current_hw_target $targu
open_hw_target

set first_hw_device [lindex [get_hw_devices] 0]
current_hw_device $first_hw_device
set_property PROGRAM.FILE ${DESIGN}.bit $first_hw_device
program_hw_devices $first_hw_device

exit
