#!/bin/bash

nasm -f elf32 -o $1.o $1.nasm

ld -m elf_i386 $1.o -o $1

echo 'Done'
