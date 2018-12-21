vlib work
vlog -timescale 1ns/1ns *.vv
log {/*}
add wave {/*}

force {clk} 1 0, 0, 20 ns -repeat 40 -cancel 3000
force {inputDone} 0
force {reset} 1

force {Dout[7:0]} 0
force {out[3:0]} 0
run 100ns
force {reset} 0
run 200ns

force {out[3:0]} 0111
run 200ns
force {out[3:0]} 0110
run 200ns
force {out[3:0]} 0000
run 200ns
force {out[3:0]} 0001
run 200ns
force {out[3:0]} 0010
run 200ns
force {out[3:0]} 0011
run 200ns
force {inputDone} 1
run 200ns
force {inputDone} 0
run 50ns
force {reset} 1
run 100ns
