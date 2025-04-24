; 

bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 10101011b, 10101110b, 00110000b
    la equ $-a
    b times la db 0
    
segment code use32 class=code
    start:
        mov ESI, a+la-1 ; a+(la-1)*2 if word
        mov EDI, b
        mov ECX, la
        jecxz end_loop
        string_repeat:
            std ; DF = 1
            lodsb ; AL = elem a, ESI-=1
            cld ; DF = 0
            mov BL, 0
            push ECX
            mov ECX, 8
            
            reverse_bits_loop:
                shl AL, 1
                rcr BL, 1
               loop reverse_bits_loop
            
            mov AL, BL
            stosb ; put AL in b & EDI +=1
            pop ECX
        loop string_repeat
        end_loop:
  
        push    dword 0
        call    [exit]
