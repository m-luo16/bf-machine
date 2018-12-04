vlib work

vlog -timescale 1ns/1ns *.v *.sv

vsim main

log -r /*

add wave -r /*

force {clock} 1 0 ns, 0 20 ns -repeat 40 ns -cancel 3000 ns

force {outReady} 0

force {reset} 1 0 ns

force {reset} 0 100ns

force {PMInputDone} 0 0ns

force {DataInputSwitches[7:0]} 00000000 0ns

force {go} 0 0ns

force {go} 1 500ns

run 2000ns

force {outReady} 1

run 200ns 
