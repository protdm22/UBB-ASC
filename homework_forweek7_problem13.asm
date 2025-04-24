; A byte string S is given. Obtain the string D1 which contains the elements found on the even positions of S and the string D2 which contains the elements found on the odd positions of S.
; Example:
;   S: 1, 5, 3, 8, 2, 9
;   D1: 1, 3, 2
;   D2: 5, 8, 9

bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    S db 1, 5, 3, 8, 2, 9
    lenS equ $-S
    D1 times lenS db 0
    D2 times lenS db 0

segment code use32 class=code
    start:
        mov ECX, lenS
        mov ESI, 0
        mov EDI, 0
        jecxz end_loop
        myrepeat:
            test ESI, 1 ; ZF = 1 if ESI is even, ZF = 0 otherwise
            je end_index_odd ; if ESI is odd
                mov AL, [S+ESI] ; AL = S[ESI] if ESI is odd
                mov [D2+EDI], AL ; D1[EDI] = AL
                inc EDI ; EDI = EDI + 1 when ESI is odd
            end_index_odd:
            test ESI, 1 ; ZF = 1 if ESI is even, ZF = 0 otherwise
            jne end_index_even ; if ESI is even
                mov AL, [S+ESI] ; AL = S[ESI] if ESI is even
                mov [D1+EDI], AL ; D1[EDI] = AL
            end_index_even:
            inc ESI ; ESI = ESI + 1
        loop myrepeat
        end_loop:
        
        
        push    dword 0
        call    [exit]