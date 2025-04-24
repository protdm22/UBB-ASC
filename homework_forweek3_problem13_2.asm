; Write a program in the assembly language that computes the following arithmetic expression, considering the given data types for the variables.
; (g+5)-a*d
; a,b,c,d-byte, e,f,g,h-word

bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 4
    d db 5
    g dw 45
    
segment code use32 class=code
    start: ; (g+5)-a*d - problem 13
        mov BX, word [g]    ; BX = g = 45
        add BX, 5           ; BX = BX+5 = 45+5 = 50
        mov AL, byte [a]    ; AL = a = 4
        mul byte [d]        ; AX = AL*d = 4*5 = 20
        sub BX, AX          ; BX = BX-AX = 50-20 = 30
        ; BX = (g+5)-a*d = 30
        ; final result is in BX
        
  
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
