; 13. Read two numbers a and b (base 10) from the keyboard and calculate: (a+b)*(a-b). The result of multiplication will be stored in a variable called "result" (defined in the data segment).

bits 32
global start

extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    a dd 0
    b dd 0
    result dq 0
    format db "%d", 0
    msga db "a = ", 0
    msgb db "b = ", 0


segment code use32 class=code
    start:
        ; print a =
        push dword msga
        call [printf]
        add ESP, 4
        
        ; read a
        push dword a
        push dword format
        call [scanf]
        add ESP, 4*2
        
        ; print b =
        push dword msgb
        call [printf]
        add ESP, 4
        
        ; read b
        push dword b
        push dword format
        call [scanf]
        add ESP, 4*2
        
        ; EAX = a-b
        mov EBX, dword [a]
        sub EBX, dword [b]
        
        ; EAX = a+b
        mov EAX, dword [a]
        add EAX, dword [b]
        
        mul EBX ; EDX:EAX = EAX*EBX
        
        ; result = EDX:EAX
        mov [result+4], EDX
        mov [result], EAX
        
        
        push   dword 0
        call   [exit]