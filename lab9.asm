; 

bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    buffer db "test"
    
segment code use32 class=code
    start:
        ; lowercase to upeprcase
        mov ECX, EAX
        mov ESI, buffer
        text_loop:
            lodsb ; AL
            cmp AL, 'a'
            jb not_lowercase
            cmp AL, 'z'
            ja not_lowercase
                sub AL, 'a'-'A'
                mov [ESI-1], AL
            not_lowercase:
        loop text_loop
  
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
