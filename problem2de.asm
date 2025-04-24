bits 32
global start        

extern exit, fread, printf, fopen, fclose

import exit msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll

segment data use32 class=data
    message db "words = %d, characters = %d", 0
    read_mode db "r", 0
    input_file db "input2de.txt", 0
    buffer dd 0
    file_descriptor dd 0
    words dd 0
    characters dd 0
    
segment code use32 class=code
    start:
        
        push dword read_mode
        push dword input_file
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax
        
        cmp eax, 0
        je program_final
        
        read_loop:
        
            push dword [file_descriptor]
            push dword 1
            push dword 1
            push dword buffer
            call [fread]
            add esp, 4*4
            
            cmp eax, 0
            je end_read_loop
            
            add [characters], dword 1
            
            cmp [buffer], byte ' '
            jne not_space
                add [words], dword 1
            not_space:
            
            jmp read_loop
        
        end_read_loop:
        
        add [words], dword 1
        
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        push dword [characters]
        push dword [words]
        push message
        call [printf]
        add esp, 4*3
        
        program_final:
        
        push    dword 0
        call    [exit]
