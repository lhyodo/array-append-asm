; ****************************************************************************************************************************
; Program name: "Append Float Array".                                                                                        *
; This program will allow a user to input two float arrays and append them into one large array.                             *
; Copyright (C) 2023 Leo Hyodo.                                                                                              *
;                                                                                                                            *
; This file is part of the software program "Append Float Array".                                                            *
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
; version 3 as published by the Free Software Foundation.                                                                    *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
; A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
; ****************************************************************************************************************************




; ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

; Author information
;  Author name: Leo Hyodo
;  Author email: lhyodo@csu.fullerton.edu

; Program information
;  Program name: Append Float Array
;  Programming languages: Assembly, C, bash
;  Date program began: 2023 Feb 6
;  Date of last update: 2023 Feb 21
;  Date of reorganization of comments: 2023 Feb 21
;  Files in this program: manager.asm, main.c, display_array.c, magnitude.asm, input_array.asm, append.asm, run.sh
;  Status: Finished.  The program was tested extensively with no errors in WSL 2.0.

; This file
;   File name: input_array.asm
;   Language: X86 with Intel syntax.
;   Max page width: 133 columns
;   Assemble: nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm
;   Link: gcc -m64 -no-pie -o addFloatArray.out manager.o input_array.o append.o main.o magnitude.o display_array.o -std=c11
;   Purpose: This is the central module that will direct calls to different functions including input_array, display_array,
;            magnitude, and append Using those functions, the magnitude of all the elements in a user created array will be 
;            calculated and be returned to the caller of this function (in main.c).
          
; ========================================================================================================
extern printf
extern scanf
extern isfloat

global input_array

segment .data
float_format db "%lf", 0


segment .bss  ;Reserved for uninitialized data


segment .text ;Reserved for executing instructions.

input_array:

;Prolog ===== Insurance for any caller of this assembly module ========================================================
;Any future program calling this module that the data in the caller's GPRs will not be modified.
push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

push qword 0                 ;Staying on the 8 byte boundary

;Copy the passed parameters into memory to use
mov r15, rdi                 ;r15 holds the first parameter (the array)
mov r14, rsi                 ;r14 holds the second parameter (the size of the array)


mov r13, 0                   ;Let r13 be the loop counter, starting at 0
beginLoop:
cmp r14, r13                 ;Compare the loop counter to the size of the array
je outOfLoop                 ;Exit loop when loop counter is equal to size of the array

mov rax, 0                   ;Zero floating point numbers involved in calling scanf
mov rdi, float_format        ;Pass in the format that we are scanning for
push qword 0                 ;Reserve 8 bytes of memory for scanf
mov rsi, rsp                 ;Pass in the pointer to the top of the stack, where the input will reside
call scanf                   ;Calls the scanf function, which places its input into rsp
pop r12                      ;Places the value from the top of the stack (rsp) into r12

cdqe                         ;Extends the lower half of rax to all 64 bits
cmp rax, -1                  ;Compares rax to -1 which is the value when user hits ctrl-d
je outOfLoop                 ;If rax is equal to -1, jump to outOfLoop
  

mov [r15 + 8*r13], r12       ;Place number from scanf into r15 address, and shift 8 bits each for each loop using loop counter
inc r13                      ;Increment loop counter by 1
jmp beginLoop

outOfLoop:
pop rax                      ;Counter the push at the beginning
mov rax, r13                 ;Return the size of the array (loop counter) to caller module

;===== Restore original values to integer registers ===================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
