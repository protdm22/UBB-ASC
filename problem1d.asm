bits 32
global start        

extern exit, fopen, fclose, fscanf, printf

import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fscanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    read_mode db "r", 0
    input_file db "input1d.txt", 0
    read_format db "%d", 0
    outf db "Max length = %d", 10, 13, 0
    output_format db "%d ", 0
    buffer dd 0
    file_descriptor dd 0
    array_length dd 0
    max_sub_len dd 0
    max_sub_start dd 0
    current_sub_len dd 0
    current_sub_start dd 0
    was_even db 0
    array resd 100
    
segment code use32 class=code
    start:
        
        push dword read_mode
        push dword input_file
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax
        
        cmp eax, 0
        je program_final
        
        xor ebx, ebx
        
        mov esi, array
        
        read_loop:
            push ebx
            
            push dword buffer
            push dword read_format
            push dword [file_descriptor]
            call [fscanf]
            add esp, 4*3
            
            pop ebx
            
            cmp eax, 1
            jne end_read_loop
            
            mov edx, [buffer]
            mov [esi+ebx*4], edx
            
            inc ebx
            
            jmp read_loop
            
        end_read_loop:
        
        mov [array_length], ebx
        
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        
        xor ebx, ebx
        
        mov esi, array
        
        iterate_array:
        
            cmp ebx, [array_length]
            je end_iterate_array
            
            mov eax, [esi+ebx*4]
            
            shr eax, 1
            
            jc odd_nr
                
                cmp [was_even], byte 1
                
                je not_first
                    mov [was_even], byte 1
                    mov [current_sub_start], ebx
                    mov [current_sub_len], dword 1
                not_first:
                    
                jne first
                    add [current_sub_len], dword 1
                first:
                
                inc ebx
                jmp iterate_array
                
            odd_nr:
            
            mov [was_even], byte 0
            
            mov eax, [max_sub_len]
            cmp [current_sub_len], eax
            
            jbe not_max
                mov eax, [current_sub_len]
                mov [max_sub_len], eax
                mov eax, [current_sub_start]
                mov [max_sub_start], eax
            not_max:
            
            inc ebx
            jmp iterate_array
        
        end_iterate_array:
            
        mov eax, [max_sub_len]
        cmp [current_sub_len], eax
        
        jbe not_max_final
            mov eax, [current_sub_len]
            mov [max_sub_len], eax
            mov eax, [current_sub_start]
            mov [max_sub_start], eax
        not_max_final:
        
        push dword [max_sub_len]
        push dword outf
        call [printf]
        add esp, 4*2
       
        mov edx, [max_sub_start]
        lea esi, [array+edx*4]
        
        xor ebx, ebx
        
        print_loop:
        
            cmp ebx, [max_sub_len]
            je program_final
            
            push dword [esi+ebx*4]
            push dword output_format
            call [printf]
            add esp, 4*2
            
            inc ebx
        
            jmp print_loop
            
        program_final:
        
        push    dword 0
        call    [exit]
