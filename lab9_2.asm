; 

bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dd 20
    b dd 44
    s db 1,2,3,4,5
    ls equ $-s
    
segment code use32 class=code
    sumarray:
        ; int sumarray(s[] - array, ls -int)
        ; eax contains the result
        ; free the stack in the procedure
        ; ret add   - esp
        ; s         - esp+4
        ; ls        - esp+8
        
        mov ecx, [esp+8]
        mov esi, [esp+4]
        mov bl, 0
        jecxz .end_loop
        .repeat:
            lodsb
            add bl,al
        loop .repeat
        .end_loop:
        
        mov eax,0
        mov al,bl
        
        ret 2*4

    sum:
        ; int sum(int a, int b)
        ; params in rev order on stack
        ; result in EAX (the sum of numbers)
        ; procedure will free the stack for the 2 params 9not the caller program)
        ; ret address   - ESP
        ; a             - ESP + 4
        ; b             - ESP + 8
        
        mov EAX, [ESP+4] ; EAX = a
        mov eax, [esp+8] ; EAX = a+b
        ret 4*2
    
    start:
        push dword [b]
        push dword [a]
        call sum
        add ESP, 4*2
        
        ; EAX contains the sum
        
        ; int sumarray(s[] - array, ls - int)
        push dword ls
        push dword s
        call sumarray
            
        
  
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
