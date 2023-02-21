
#!/bin/bash

#Program: Append Array
#Author: Leo Hyodo

#Purpose: script file to run the program files together.
#Clear any previously compiled outputs
rm *.o
rm *.out
rm *.lis

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assemble magnitude.asm"
nasm -f elf64 -l magnitude.lis -o magnitude.o magnitude.asm

echo "Assemble append.asm"
nasm -f elf64 -l append.lis -o append.o append.asm

echo "compile display_array.c using the gcc compiler standard 2011"
gcc -c -Wall -no-pie -m64 -std=c11 -o display_array.o display_array.c

echo "compile main.c using gcc compiler standard 2011"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11

echo "Link object files using the gcc Linker standard 2011"
gcc -m64 -no-pie -o addFloatArray.out manager.o input_array.o append.o main.o magnitude.o display_array.o -std=c11

echo "Run the Append Array Program:"
./addFloatArray.out

echo "Script file has terminated."

#Clean up after program is run
rm *.o
rm *.out
rm *.lis
