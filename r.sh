#!/bin/bash

#Program: Rectangle
#Author: Johnson Tong

#Clear any previously compiled outputs
rm *.lis
rm *.o
rm *.out

echo "Assemble perimeter.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "compile rectangle.c using gcc compiler standard 2011"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11

echo "Link object files using the gcc Linker standard 2011"
gcc -m64 -no-pie -o final-perimeter.out manager.o main.o -std=c11

echo "Run the Rectange Program:"
./final-perimeter.out

# For cleaner working directory, you can:
rm *.lis
rm *.o
rm *.out

echo "Script file terminated."