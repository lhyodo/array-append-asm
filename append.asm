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
;  Date of last update: 2023 Feb 20
;  Date of reorganization of comments: 2023 Feb 20
;  Files in this program: manager.asm, main.c, display_array.c, magnitude.asm, input_array.asm, append.asm, run.sh
;  Status: Finished.  The program was tested extensively with no errors in WSL 2.0.

; This file
;   File name: append.asm
;   Language: X86 with Intel syntax.
;   Max page width: 133 columns
;   Assemble: nasm -f elf64 -l append.lis -o append.o append.asm
;   Link: gcc -m64 -no-pie -o addFloatArray.out manager.o input_array.o append.o main.o magnitude.o display_array.o -std=c11
;   Purpose: This is the central module that will direct calls to different functions including input_array, display_array,
;            magnitude, and append Using those functions, the magnitude of all the elements in a user created array will be 
;            calculated and be returned to the caller of this function (in main.c).
          
; ========================================================================================================
extern printf
extern scanf
global append

segment .data

segment .bss

segment .text

append: ; RENAME THIS TO THE NAME OF YOUR MODULE/FUNCTION THAT YOU ARE WRITING

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

; WRITE YOUR CODE HERE!!!!!
push qword 0 ;Staying on the boundary

mov r15, rdi ;Take arr1 from the parameters
mov r14, rsi ;arr2
mov r13, rdx ;result_arr
mov r12, rcx ;arr1_size
mov r11, r8  ;arr2_size



;Let user enter numbers until cntrl + d is entered
;This for loop will go to 6, the chosen array size, or end once cntrl d is pressed.
mov r10, 0 ;Loop counter for first and second array
mov r9, 0 ; Loop counter for second array
beginLoop:
  cmp r12, r10 ;We want to exit loop when we hit the size of array (first array)
  je outOfLoop

  movsd xmm15, [r15 + 8*r10]
  movsd [r13 + 8*r10], xmm15
  inc r10  ;Increment loop counter
  jmp beginLoop


outOfLoop:
  cmp r11, r9 ;We want to exit loop when we hit the size of array (second array)
  je endFunction

  movsd xmm15, [r14 + 8*r9]
  movsd [r13 + 8*r10], xmm15
  inc r9   ;Increment loop counter for second array
  inc r10  ;Increment loop counter for both arrays
  jmp outOfLoop


endFunction:
pop rax ;Counter the push at the beginning
mov rax, r10  ;Store the number of elements in the result array (loop counter for both arrays)



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
