# bf-machine
> A Verilog module used to run [BF](https://esolangs.org/wiki/brainfuck) code on an FPGA.

## Programming
0. Read about BF at the above link to familiarize yourself with the available commands. (We added an extra stop command `s` to be included at the end of every program.)
1. Write desired code into some input file. 
2. Compile the provided assembler (turns BF into binary based on table below) by calling `make`.
3. Run the assembler with your input code by calling `./assembler input_file output_file`. 
4. Change `line 11` of `pmemory.v` to match the desired output file. 
```verilog
$readmemb("output_file", rom);
```
5. Open Quartus Prime, make a new project with all of the Verilog files, and compile with `top` as the top-level module.
6. Save the `.sof` file that is generated (found under `output_files` in your Quartus project directory).

## Usage
1. In Quartus Prime, open up Programmer and load the `.sof` file that you want.
2. Click "Start". 
3. FPGA is now ready to run your program.
4. All programs start by pressing `KEY[3]` and can be reset with `KEY[0]`. When reaching an input command, turn switches `SW[7:0]` to desired value and press `KEY[1]`. When reaching an output command, output will be displayed on `HEX1` and `HEX0`. When done viewing output, press `KEY[2]` to move on to next instruction.

We have included a few example `.sof` files in the `bf_programs` folder.  
## Tables

Our BF to binary mappings. 
| op | code|
|:-:|:----:|
| < | 0000 |
| > | 0001 |
| + | 0010 |
| - | 0011 |
| [ | 0100 |
| ] | 0101 |
| . | 0110 |
| , | 0111 |
| s | 1111 |

The following keys are used to control our computer

| KEY| Action |
|:--:|:----------:|
| 0 | Reset |
| 1 | Input Done |
| 2 | Output Done |
| 3 | Go |

HEX outputs
| HEX | Purpose |
|:---:|:-------:|
|HEX5|Program Counter (Upper bits)|
|HEX4|Program Counter (Lower bits)|
|HEX3|Data Pointer (Upper bits)|
|HEX2|Data Pointer (Lower bits)|
|HEX1|Output Number (Upper bits)|
|HEX0|Ouput Number (Lower bits)|
