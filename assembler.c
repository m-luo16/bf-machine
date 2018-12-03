#include <stdio.h>
#include <stdlib.h>

#define WIDTH 4
// Turns Brainfuck code to object code for the bf-machine.
// Also checks if the brackets are correctly ordered.

// takes in two command line arguments, the first being the name of the file
// to read from, the second to put

/* | op      | code          | */
/* |--------|:----------:| */
/* | smaller | 0000 | */
/* | greater | 0001 | */
/* | plus | 0010 | */
/* | minus | 0011 | */
/* | openBracket | 0100 | */
/* | closeBracket | 0101 | */
/* | dot | 0110 | */
/* | comma | 0111 | */
/* | stop_c | 1111 | */



// does not allow comments

int main(int argc, char **argv) {
    if(argc != 3) {
        fprintf(stderr, "Pleases include assembly file, then name of output file.\n");
        exit(-1);
    }

    FILE *in_file  = fopen(argv[1], "r"); 
    FILE *out_file = fopen(argv[2], "w");
    char in_char;
    int current_w;
    
    // test for files not existing. 
    if (in_file == NULL || out_file == NULL) 
    {   
        fprintf(stderr, "Error! Could not open file\n"); 
        exit(-1); // must include stdlib.h 
    } 

    current_w = 0;

    while(fscanf(in_file, "%c", &in_char) != EOF) {
        switch(in_char) {
        case '<' : fprintf(out_file, "0000 "); current_w++; break;
        case '>' : fprintf(out_file, "0001 ");  current_w++;break;
        case '+' : fprintf(out_file, "0010 ");  current_w++;break;
        case '-' : fprintf(out_file, "0011 ");  current_w++;break;
        case '[' : fprintf(out_file, "0100 ");  current_w++;break;
        case ']' : fprintf(out_file, "0101 ");  current_w++;break;
        case '.' : fprintf(out_file, "0110 ");  current_w++;break;
        case ',' : fprintf(out_file, "0111 "); current_w++; break;
        case 's' : fprintf(out_file, "1111 "); current_w++; break;
        default : ;
        }
        
        if(current_w > WIDTH-1) {
            fprintf(out_file, "\n");
            current_w = 0;
        }
        
    }

    printf("Done.\n");
}
