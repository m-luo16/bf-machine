vlib work

vlog -timescale 1ns/1ns control.v

# Load simulation using mux as the top level simulation module.
vsim control
# Log all signals and add some signals to waveform window.
log {/*}

# add wave {/*} would add all items in top level simulation module.
add wave {/*}




force {clk} 1 0 , 0 20 ns -repeat 40 -cancel 3000

force {inputDone} 0
force {reset} 1

force {Dout[0]} 0
force {Dout[1]} 0
force {Dout[2]} 0
force {Dout[3]} 0
force {Dout[4]} 0
force {Dout[5]} 0
force {Dout[6]} 0
force {Dout[7]} 0


force {BCount[0]} 0
force {BCount[1]} 0
force {BCount[2]} 0
force {BCount[3]} 0
force {BCount[4]} 0
force {BCount[5]} 0
force {BCount[6]} 0
force {BCount[7]} 0




# test lesser
force {out[3]} 0
force {out[2]} 0
force {out[1]} 0
force {out[0]} 0



run 100ns

force {reset} 0

run 200ns

#test greater
force {out[3]} 0
force {out[2]} 0
force {out[1]} 0
force {out[0]} 1

run 280ns

#test plus
force {out[3]} 0
force {out[2]} 0
force {out[1]} 1
force {out[0]} 0

run 280ns

#test minus
force {out[3]} 0
force {out[2]} 0
force {out[1]} 1
force {out[0]} 1
run 280ns

#test dot
force {out[3]} 0
force {out[2]} 1
force {out[1]} 1
force {out[0]} 0
run 400ns

#test comma
force {out[3]} 0
force {out[2]} 1
force {out[1]} 1
force {out[0]} 1
run 400ns


force {inputDone} 1
run 200ns
force {inputDone} 0

run 50ns


force {reset} 1

run 100ns




