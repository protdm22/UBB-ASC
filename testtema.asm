; Given an array S of doublewords, build the array of bytes D formed from lower bytes of lower words, bytes multiple of 7.
 ; Example:
    ; s DD 12345607h, 1A2B3C15h, 13A33412h, 12345623h
    ; d DB 07h, 15h, 23h
    
bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    s dd 12345607h, 1A2B3C15h, 13A33412h, 12345623h
    ls equ ($-s)/4
    seven db 7
    d times ls db 0
    

segment code use32 class=code
    start:
        mov ECX, ls
        mov ESI, s
        mov EDI, d
        jecxz end_loop
        myrepeat:
            lodsb ; AL = lower byte (of the lower word)
            mov BL, AL ; BL = AL to keep the value
            mov AH, 0
            div byte [seven] ; AH = AX%7    AL = AX/7
            cmp AH, 0 ; ZF=1 if AH = 0, ZF=0 otherwise
            jne dont_add
                mov AL, BL
                stosb
            dont_add:
            add ESI, 3 ; ESI += 3 to skip the rest of the doubleword
        loop myrepeat
        end_loop:
        
        
        push    dword 0
        call    [exit]