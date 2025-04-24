bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 4
    c db 30
    d db 8
    b dd 96
    x dq 100
    
segment code use32 class=code
    start:
        ; 13. x-(a+b+c*d)/(9-a); a,c,d-byte; b-doubleword; x-qword
        ; unsigned interpretation
        
        ; a+b = 100
        mov EDX, 0
        mov DL, byte [a] ; DL = a = 4
        ; EDX = a = 4
        add EDX, dword [b] ; EDX = a+b = 4+96 = 100
        
        ; c*d = 240
        mov AL, byte [c] ; AL = c = 30
        mul byte [d] ; AX = AL*d = c*d = 30*8 = 240
        
        
        ; (a+b+c*d)
        mov EBX, 0
        mov BX, AX          ; EBX = AX
        add EDX, EBX        ; EDX = EDX+EBX = c*d+a+b
        ; EDX = (c*d+a+b)
        
        ; (a+b+c*d)/(9-a)
        mov CL, byte 9      ; CL = 9
        sub CL, byte [a]    ; CL = 9-a
        mov CH, 0           ; CX = 9-a
        push EDX    
        pop AX
        pop DX ; DX:AX = EDX = (c*d+a+b) = 340
        div CX ; DX:AX = DX:AX/CX = (a+b+c*d)/(9-a) = 68
        ; DX:AX = (a+b+c*d)/(9-a) = 68
        
        mov EBX, 0
        mov BX, AX      ; EBX = AX
        mov EAX, EBX    ; EAX = EBX = (a+b+c*d)/(9-a) = 68
        
        ; ECX:EBX = x = 100
        mov EBX, dword [x]
        mov ECX, dword [x+4] ; ECX:EBX = x
        
        ; x-(a+b+c*d)/(9-a)
        mov EDX, 0 ; Clear EDX
        sub EBX, EAX ; EBX = EBX-EAX and set CF to 0 or 1
        sbb ECX, EDX
        ; final result in ECX:EBX = x-(a+b+c*d)/(9-a)
        ; = 100-(4+96+30*8)/(9-4) = 32
        
  
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
