; Given the words A and B, compute the doubleword C:
    ; the bits 0-4 of C have the value 1
    ; the bits 5-11 of C are the same as the bits 0-6 of A
    ; the bits 16-31 of C have the value 0000000001100101b
    ; the bits 12-15 of C are the same as the bits 8-11 of B

bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 1111111100110011b
    b dw 1111101100110011b
    c dd 0b
    
segment code use32 class=code
    start:
        or [c], dword 11111b
        and [a], word 1111111b
        mov AX, word [a]
        shl AX, 5
        or [c], AX
        mov EAX, dword 0000000001100101b
        shl EAX, 16
        or [c], EAX
        mov BX, word [b]
        and BX, 0x0F00
        shl BX, 4
        
        or [c], BX
        
  
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
