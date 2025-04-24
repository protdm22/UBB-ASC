; Write a program in the assembly language that computes the following arithmetic expression, considering the given data types for the variables.
; [(a*b)-d]/(b+c)
; a,b,c - byte, d - word

bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 9
    b db 3
    c db 4
    d dw 10
    
segment code use32 class=code
    start: ; [(a*b)-d]/(b+c) - problem 13
        mov AL, byte [a]    ; AL = a = 9
        mul byte [b]        ; AX = AL*b = a*b = 9*3 = 27
        sub AX, word [d]    ; AX = AX - d = (a*b)-d = (9*3)-10 = 17
        mov BL, byte [b]    ; BL = b = 3
        add BL, byte [c]    ; BL = BL + c = b+c = 7
        div BL              ; AH = AX%BL = 3
                            ; AL = AX/BL = 2
        ; final result in AH:AL
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
