; [(d/2)*(c+b)-a*a]/b

bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 1
    b db 2
    c db 3
    d dw 4
    
segment code use32 class=code
    start:
        mov AX, word [d]
        mov BL, byte 2
        div BL
        mov BL, byte [c]
        add BL, byte [b]
        mul BL
        mov BX, AX
        mov AL, byte [a]
        mul AL
        sub BX, AX
        mov AX, BX
        mov BL, byte [b]
        div BL
        
  
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
