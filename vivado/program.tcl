set bitfile [lindex $argv 0]

load_features labtools

open_hw_manager

connect_hw_server -url TCP:localhost:3121

set targu [get_hw_targets *]
current_hw_target $targu
open_hw_target

set first_hw_device [lindex [get_hw_devices] 0]

current_hw_device $first_hw_device

set_property PROGRAM.FILE $bitfile $first_hw_device

program_hw_devices $first_hw_device

exit
