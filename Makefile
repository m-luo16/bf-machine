CFLAGS = -Wall -g

assembler: assembler.o
	gcc $(CFLAGS) -o assembler assembler.o

assembler.o: assembler.c
	gcc $(CFLAGS) -c assembler.c

clean:
	rm assembler assembler.o
