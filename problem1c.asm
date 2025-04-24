bits 32
global start        

extern exit, fopen, fclose, fscanf, fprintf

import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fscanf msvcrt.dll
import fprintf msvcrt.dll

segment data use32 class=data
    read_mode db "r", 0
    write_mode db "w", 0
    input_file db "input1c.txt", 0
    output_file db "output1c.txt", 0
    format db "%d", 0
    space db " ", 0
    buffer dd 0
    file_descriptor dd 0
    array_len dd 0
    array resd 100
    is_nr dd 0
    iterations db 0

segment code use32 class=code
    start:
    
        push dword read_mode
        push dword input_file
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax
        
        cmp eax, 0
        je program_final
        
        mov esi, array
        
        xor ebx, ebx
        
        read_loop:
            push ebx
        
            push dword buffer
            push dword format
            push dword [file_descriptor]
            call [fscanf]
            add esp, 4*3
            
            pop ebx
            
            cmp eax, 1
            jne end_read_loop
            
            mov eax, [buffer]
            mov [esi+ebx*4], eax
            
            inc ebx
            jmp read_loop
            
        end_read_loop:
        
        mov [array_len], ebx
        
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        push dword write_mode
        push dword output_file
        call [fopen]
        add esp, 4*2
        
        mov esi, array
        
        mov [file_descriptor], eax
        
        cmp eax, 0
        je program_final
        
        xor ebx, ebx
        
        iterate:
            cmp ebx, [array_len]
            je iterate_final
            
            push ebx
            
            mov eax, [esi+ebx*4]
            mov [is_nr], dword 0
            
            mov byte [iterations], 0
            
            base2_conv:
                cmp byte [iterations], 32
                je end_base2_conv
                
                shl eax, 1
                jnc no_carry
                    mov [is_nr], dword 1
                
                    push eax
                    
                    push dword 1
                    push dword format
                    push dword [file_descriptor]
                    call [fprintf]
                    add esp, 4*3
                    
                    pop eax
                    jmp no_nr
                no_carry:
                
                mov ebx, 1
                
                cmp ebx, [is_nr]
                jne no_nr
                
                    push eax
                    
                    push dword 0
                    push dword format
                    push dword [file_descriptor]
                    call [fprintf]
                    add esp, 4*3
                    
                    pop eax
                
                no_nr:
                add [iterations], byte 1
                
                jmp base2_conv
                
            end_base2_conv:
            
            push eax
                    
            push dword space
            push dword [file_descriptor]
            call [fprintf]
            add esp, 4*2
            
            pop eax
            
            pop ebx
            inc ebx
            
            jmp iterate
            
        iterate_final:
        
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        program_final:
    
        push    dword 0
        call    [exit]
