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
;   File name: magnitude.asm
;   Language: X86 with Intel syntax.
;   Max page width: 133 columns
;   Assemble: nasm -f elf64 -l magnitude.lis -o magnitude.o magnitude.asm
;   Link: gcc -m64 -no-pie -o addFloatArray.out manager.o input_array.o append.o main.o magnitude.o display_array.o -std=c11
;   Purpose: This is the central module that will direct calls to different functions including input_array, display_array,
;            magnitude, and append Using those functions, the magnitude of all the elements in a user created array will be 
;            calculated and be returned to the caller of this function (in main.c).
          
; ========================================================================================================

global magnitude

segment .data

segment .bss  ;Reserved for uninitialized data

segment .text ;Reserved for executing instructions.

magnitude:

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

push qword 0                 ;Remain on the 8 byte boundary
;Taking information from parameters
mov r15, rdi                 ;This holds the first parameter (the array)
mov r14, rsi                 ;This holds the second parameter (the size of the array)

;Formula: magnitude = sqrt(a^2 + b^2 + c^2 + d^2 + ...)

;xmm15 will be used to store the sum of (each element squared) in beginLoop
mov rdx, 0                   ;Places a 0 into rdx
cvtsi2sd xmm15, rdx          ;Convert the 0 in rdx to something xmm can read

;r13 will be used as a loop counter in beginLoop
mov r13, 0                   ;The loop counter will start at 0

;Each loop will iterate through each element of the array and add its square to xmm15
beginLoop:
cmp r13, r14               ;Comparing the loop counter with the size of array that was passed in the parameters
je outOfLoop               ;If loop counter is equal to the size of the array, jump to outOfLoop
movsd xmm14, [r15 + 8*r13] ;Copies the current element into xmm14
mulsd xmm14, xmm14         ;Squares xmm14
addsd xmm15, xmm14;        ;Adds the square into xmm15
inc r13                    ;Increment loop counter
jmp beginLoop              ;Jump back to the beginning of the loop


outOfLoop:
sqrtsd xmm15, xmm15          ;Square root the sum of all squares
;xmm15 is now equal to the magnitude of the array
pop rax                      ;Counter the push qword at the beginning
movsd xmm0, xmm15            ;Returning the magnitude to caller

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
