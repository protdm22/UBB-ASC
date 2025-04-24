; 

bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    c dq 34567
    a dw 15
    b dw 32
    ; x dw 0x12345678AB
    
segment code use32 class=code
    start:
        mov AL, byte [a]
        mov BX, word [b]
        mov AH, 0
        add AX, BX
        
        ; a*b+c unsigned
        mov AX, word [a]
        mov BX, word [b]
        mul BX ; DX:AX = a*b
        push DX
        push AX
        pop EAX
        mov EDX, 0 ; EDX:EAX = a*b
        add EAX, dword [c]
        adc EDX, dword [c+4]
        
        ;signed
        mov AX, word [a]
        mov BX, word [b]
        imul BX ; DX:AX = a*b
        push DX
        push AX
        pop EAX
        cdq ; EDX:EAX = a*b
        add EAX, dword [c]
        adc EDX, dword [c+4]
        
  
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
