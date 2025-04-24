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
        ; signed interpretation
        
        ; a+b = 100
        mov AL, byte [a] ; AL = a
        cbw              ; AX = a = 4
        cwde             ; EAX = a = 4
        add EAX, dword [b] ; EAX = a+b = 4+96 = 100
        mov EDX, EAX       ; EDX = a+b = 100
        
        ; c*d = 240
        mov AL, byte [c] ; AL = c = 30
        imul byte [d]    ; AX = AL*d = c*d = 30*8 = 240
        cwde             ; EAX = 240
        
        ; a+b+c*d = 340
        add EDX, EAX ; EDX = AX+DX = c*d+a+b = 340
        mov ECX, EDX
        ; ECX = c*d+a+b = 340
       
        
        ; 9-a = 5
        mov AL, byte 9   ; AL = 9
        sub AL, byte [a] ; AL = 9-a = 9-4 = 5
        cbw              ; AX = 5
        mov BX, AX       ; BX = 5
        push EDX
        pop AX
        pop DX           ; DX:AX = EDX
        
        
        ; (a+b+c*d)/(9-a) = 68
        idiv BX ; AX = AX/DL = (a+b+c*d)/(9-a) = 68
                ; DX = AX%DL = (a+b+c*d)%(9-a) = 0
        cwde    ; EAX = (a+b+c*d)/(9-a) = 68
        cdq     ; EDX:EAX = (a+b+c*d)/(9-a) = 68
        
        ; ECX:EBX = x = 100
        mov EBX, dword [x]
        mov ECX, dword [x+4]
        
        ; x-(a+b+c*d)/(9-a) = 32
        sub EBX, EAX ; EBX = EBX-EAX and set CF to 0 or 1
        sbb ECX, EDX
        
        ; final result in ECX:EBX = x-(a+b+c*d)/(9-a)
        ; = 100-(4+96+30*8)/(9-4) = 32
        
  
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
