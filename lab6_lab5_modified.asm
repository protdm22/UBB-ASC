bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 10, 11, 13, 27, 28, 40
    l equ $-a
    b times l db 0
    two db 2
    
segment code use32 class=code
    start:  ; Given array a of bytes compute array b containing only odd numbers.
            ; unsigned interpretation
        mov ESI, a
        mov EDI, b
        mov ECX, l
        jecxz end_loop
        myrepeat:
            lodsb ; load AL and inc ESI
            mov AH, 0       ; AX = element
            div byte [two]  ; AH = AX%2
            cmp AH, 0
            je skip
                mov AL, [ESI]
                ;mov [b+EDI], AL
                stosb ; byte [EDI], AL and inc ESI EDI
                ; inc EDI
            skip:
            ; inc ESI
        loop myrepeat
        end_loop:
            
            
        push    dword 0
        call    [exit]