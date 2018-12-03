vlib work

vlog -timescale 1ns/1ns *.v *.sv

vsim main

log {/*}

force {clock} 1 0, 0 ns -repeat 40 -cancel 3000

force {reset} 1 0 ns

force {reset} 0 40ns

force {PMInputDone} 0 0ns

force {DataInputSwitches[7:0]} 0 0ns

force {go} 0 0ns

force {go} 1 500ns

run 3000ns
