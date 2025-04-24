;Problem. A string of quadwords is given. Compute the number of multiples of 8 from
;the string of the low bytes of the high word of the high doubleword from the elements of the quadword string 
;and find the sum of the digits (in base 10) of this number.

bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    sir dq  00103110110abcb0h, 1116adcb5a051ad2h, 4120ca11d730cbb0h
	len equ ($-sir)/8 ; b0 bc 0a 11 10 31 12 00     little endian repr
	opt db 8 ; variabile used for testing divisibility to 8
	ten dd 10 ; variabile used for determining the digits in base 10 of a number by successive divisions to 10
	; suma dd 0 ; variabile used for holding the sum of the digits

segment code use32 class=code
    start:
        mov BL, 0
        mov ESI, sir
        mov ECX, len
        jecxz end_loop
        repeat:
            lodsd ; EAX = low dword and inc ESI with 4 ; 110abcb0
            lodsw ; AX = low word of high word and inc ESI with 2 ; 3110
            lodsw ; AX = high word of the high dword and inc ESI with 2 ; 0012
            ; AL contains the low byte of the high word of the high dword ; 12
            mov AH, 0 ; AX = AL unsigned conversion
            div byte [opt] ; AL = AX/opt ; AH = AX%opt
            cmp AH, 0
            jne dont_increment
                inc BL ; found a multiple of 8
            dont_increment:
        loop repeat
        end_loop:
        
        sum_loop:
            mov AL, BL
            mov AH, 0 ; AX = BL
            div byte [ten] ; AL = BL/10 ; AH = BL%10
            add BL, AH
            cmp AL, 0
            je out_of_loop
        jmp sum_loop
        out_of_loop:
        
    
        push    dword 0
        call    [exit]