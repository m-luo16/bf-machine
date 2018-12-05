vlib work

vlog -timescale 1ns/1ns data.v
vsim -L altera_mf_ver data2

# Log all signals and add some signals to waveform window.
log {/*}

# add wave {/*} would add all items in top level simulation module.
add wave {/*}


# module descriptor
# module data2(address, clock, data, wren, wipe, wipeCounterReset, q);


# first, write some value into random addresses
force {wren} 1
force {wipe} 0
force {wipeCounterReset} 0
run 20ps



force {clock} 1 0 , 0 20 ps -repeat 40 -cancel 1500
force {address[15:0]} 0000000000000000
force {data[7:0]} 01010101

run 50ps


force {address[15:0]} 0000000000000001
force {data[7:0]} 11111111
run 50ps

force {address[15:0]} 0000000000000100
force {data[7:0]} 11110000
run 50ps

force {wipeCounterReset} 1
run 50ps
force {wipeCounterReset} 0
force {wipe} 1
run 400ps


force {wipe} 0
force {wren} 0
force {address[15:0]} 0000000000000000
run 40ps
force {address[15:0]} 0000000000000100
run 60ps





