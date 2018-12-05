vlib work

vlog -timescale 1ns/1ns pmemory2.v
vsim -L altera_mf_ver pmemory2

# Log all signals and add some signals to waveform window.
log {/*}

# add wave {/*} would add all items in top level simulation module.
add wave {/*}


force {clock} 1 0 , 0 20 ns -repeat 40 -cancel 1500


force {addr[7:0]} 00000000
run 40ns

force {addr[7:0]} 00000001
run 40ns

force {addr[7:0]} 00000010
run 40ns

force {addr[7:0]} 00000011
run 40ns

force {addr[7:0]} 00000100
run 40ns

force {addr[7:0]} 00000101
run 40ns

force {addr[7:0]} 00000110
run 40ns
