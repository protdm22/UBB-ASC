bits 32
global start        

extern exit, printf, fopen, fclose, fprintf, fscanf

import exit msvcrt.dll
import printf msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fscanf msvcrt.dll

segment data use32 class=data
    format db "%d ", 0
    read_format db "%d", 0
    message db "Sorted array: ", 0
    read_mode db "r", 0
    write_mode db "w", 0
    input_file db "input1b.txt", 0
    output_file db "output1b.txt", 0
    file_descriptor dd -1
    buffer dd -1
    a resb 100
    ;a db 10, 4, 6, 2, 1, 50, 25, 4, 200
    lena db 0
    ;lena db $-a
    

segment code use32 class=code
    start:
        push read_mode
        push input_file
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax
        
        cmp eax, 0
        jmp final_program
        
        mov esi, a
        
        read_loop:
            push dword buffer
            push dword read_format
            push dword [file_descriptor]
            call [fscanf]
            add esp, 4*3
            
            cmp eax, 1
            jne end_read
            
            xor edx, edx
            mov dl, [buffer]
            
            xor eax, eax
            mov al, [lena]
            
            mov [esi+eax], dl
            
            add [lena], byte 1
        
            jmp read_loop
            
        end_read:
        
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        mov esi, a
        xor eax, eax ; eax = i = 0
        
        sort_i_loop:
        
            cmp eax, dword [lena]
            je final_sort
        
            mov ebx, eax ; ebx = j = i
            add ebx, 1 ; ebx = i+1
            
            sort_j_loop:
                
                cmp ebx, dword [lena]
                je end_j_loop
                
                xor edx, edx
                mov dl, [esi+eax] ; DL = a[i]
                
                cmp dl, [esi+ebx]; cmp a[i],a[j]
                
                jbe dont_swap ; change this for ascending/descending
                
                    xchg dl, [esi+ebx]
                    mov [esi+eax], dl
                
                dont_swap:
                
                inc ebx ; j++
                jmp sort_j_loop
            end_j_loop:
            
            inc eax ; i++
            jmp sort_i_loop
    
        final_sort:
        
        push dword write_mode
        push dword output_file
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax
        
        cmp eax, 0
        je final_program
        
        push dword message
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*2

        xor eax, eax
        
        display_loop:
            cmp eax, dword [lena]
            je final_program
            
            pushad
            
            xor ebx, ebx
            mov bl, [esi+eax]
            
            push ebx
            push dword format
            push dword [file_descriptor]
            call [fprintf]
            add esp, 4*3
            
            popad
            
            inc eax
            jmp display_loop
            
        final_program:
        
        push dword [file_descriptor]
        call [fclose]

        push    dword 0
        call    [exit]
