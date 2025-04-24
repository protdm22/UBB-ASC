; 

bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    c dd 15
    a dd 10
    b dd 20
    
segment code use32 class=code
    start:
        ; unsigned
        mov EAX, [a]
        mov EBX, [b]
        mul EBX ; EDX:EAX = a*b
        add EAX, [c]
        adc EDX, 0 ; EDX:EAX = a*b+c
        
        ;signed
        mov EAX, [a]
        mov EBX, [b]
        imul EBX ; EDX:EAX = a*b
        mov EBX, EAX
        mov ECX, EDX ; ECX:EBX = a*b
        mov EAX, [c]
        cdq ; EDX:EAX = c
        add EAX, EBX
        adc EDX, ECX ; EDX:EAX = a*b+c
        
  
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
