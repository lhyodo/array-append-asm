extern printf
extern scanf
global manager

segment .data
brief db "This program will sum your array of 64-bit floats.",10,0
prompt db "Enter a sequence of 64-bit floats separated by white space.", 10, 0
prompt2 db "After the last input press enter followed by Control+D:",10,0
side_one db "%lf", 0
side_two db "%lf", 0

one_float_format db "%lf",0
three_float_format db "%lf %lf %lf", 0

four dq 4.0

segment .bss

segment .text

manager: ; RENAME THIS TO THE NAME OF YOUR MODULE/FUNCTION THAT YOU ARE WRITING

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


mov rax, 0
mov rdi, brief
call printf

mov rax, 0
mov rdi, prompt
call printf

mov rax, 0
mov rdi, prompt2
call printf

push qword 0
push qword 0
mov qword rax, 0
mov rdi, side_one
mov rsi, rsp
call scanf
pop r15
pop rax

push qword 0
push qword 0
mov qword rax, 0
mov rdi, side_two
mov rsi, rsp
call scanf
pop r15
pop rax



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