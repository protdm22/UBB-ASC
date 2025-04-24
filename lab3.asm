; Lab 15 oct 

bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dq 123456781122ABCDh
    b dq 2034FFEDAA11h
    c dd 10
    d dd 50
    ; a and b in memory - CD AB 22 11 78 56 34 12 11 AA ED FF 34 20 00 00 
    
segment code use32 class=code
    start:
        ; a+b
        ; a in EDX:EAX
        mov EAX, dword [a] ; EAX = 11 22 AB CD
        mov EDX, dword [a+4] ; EDX = 12 34 56 78
        mov ECX, dword [b] ; ECX = 00 00 20 34
        mov EBX, dword [b+4] ; EBX = FF ED AA 11
        ; a+b ; add lower parts of the numbers ; keep result in EDX:EAX
        add EAX, ECX ; EAX := EAX+ECX and the result sets CF to 0 or 1
        adc EDX, EBX ; EDX := EDX+EBX+CF
        
        ; c-d
        ; c in DX:AX
        mov AX, word [c]
        mov DX, word [c+2]
        ; d in BX:CX
        mov CX, word [d]
        mov BX, word [d+2]
        ; c-d
        sub AX, CX ; AX = AX-CX and set CF to 0 or 1
        sbb DX, BX ; DX = DX-BX-CF
        
  
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
