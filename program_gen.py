#!/usr/bin/python3

def main():
    commands = {
        ">": "force {out[3:0]} 0001\n",
        "<": "force {out[3:0]} 0000\n",
        "+": "force {out[3:0]} 0010\n",
        "-": "force {out[3:0]} 0011\n",
        ".": "force {out[3:0]} 0110\n",
        ",": "force {out[3:0]} 0111\n"}

    
    i = open("input.txt", "r");
    o = open("wave.do", "w");

    o.write("vlib work\n")
    o.write("vlog -timescale 1ns/1ns control.v\n")

    o.write("log {/*}\n")
    o.write("add wave {/*}\n\n")

    o.write("force {clk} 1 0, 0, 20 ns -repeat 40 -cancel 3000\n")
    o.write("force {inputDone} 0\n")
    o.write("force {reset} 1\n\n")

    o.write("force {Dout[7:0]} 0\n")
    o.write("force {out[3:0]} 0\n")

    o.write("run 100ns\n")
    o.write("force {reset} 0\n")
    o.write("run 200ns\n\n")

    for line in i:
        o.write(commands[line.strip()])
        o.write("run 200ns\n")

    o.write("force {inputDone} 1\n")
    o.write("run 200ns\n")
    o.write("force {inputDone} 0\n")
    o.write("run 50ns\n")
    o.write("force {reset} 1\n")
    o.write("run 100ns\n")

    
if __name__ == "__main__":
    main()
