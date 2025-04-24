; 13. Given 4 bytes, compute in AX the sum of the integers represented by the bits 4-6 of the 4 bytes.

bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 250 ; 1111 1010
    b db 170 ; 1010 1010
    c db 200 ; 1100 1000
    d db 255 ; 1111 1111
    ; AX = 111(7) + 010(2) + 100(4) + 111(7) = 20
    
segment code use32 class=code
    start:
        ; a
        mov BL, byte [a]    ; BL = 1111 1010
        and BL, 01110000b   ; BL = 0111 0000
        shr BL, 4           ; BL = 0000 0111 = 7
        mov BH, 0
        mov AX, BX          ; AX = 7
        
        ; b
        mov BL, byte [b]    ; BL = 1010 1010
        and BL, 01110000b   ; BL = 0010 0000
        shr BL, 4           ; BL = 0000 0010 = 2
        mov BH, 0
        add AX, BX          ; AX = 7+2 = 9
        
        ; c
        mov BL, byte [c]    ; BL = 1100 1000
        and BL, 01110000b   ; BL = 0001 0000
        shr BL, 4           ; BL = 0000 0100 = 4
        mov BH, 0
        add AX, BX          ; AX = 9+4 = 13
        
        ; d
        mov BL, byte [d]    ; BL = 1111 1111
        and BL, 01110000b   ; BL = 0111 0000
        shr BL, 4           ; BL = 0000 0111 = 7
        mov BH, 0
        add AX, BX          ; AX = 13 + 7 = 20
        
        ; final result in AX = 20
        
  
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
