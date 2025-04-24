bits 32
global start        

extern exit, fread, fopen, fclose, printf

import exit msvcrt.dll
import fread msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    read_mode db "r", 0
    input_file db "practical_exam.txt", 0
    message db "First word: %s  |  number of words: %d", 10, 13, 0
    file_descriptor dd 0
    buffer dd 0
    word_count dd 0
    is_sentence_start db 1
    first_word resb 100
    
    
segment code use32 class=code
    start:
    
        ; eax = fopen(input_file, read_mode)
        push dword read_mode
        push dword input_file
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax
        
        cmp eax, 0
        je program_end
        
        mov esi, first_word ; load the address of first_word in esi
        xor ebx, ebx ; ebx = 0 (counter for the first_word positions)
        
        read_loop:
        
            ; eax = fread(buffer, 1(size:bytes), 1(nr of chars read), file_descriptor)
            push dword [file_descriptor]
            push dword 1
            push dword 1
            push dword buffer
            call [fread]
            add esp, 4*4
            
            cmp eax, 0
            je end_read_loop
            
            mov al, byte [buffer]
            
            cmp al, ' '
            jne not_space
            
                ; if al == ' '
                
                ; cmp [is_sentence_start], byte 1
                ; je not_space
                
                mov byte [is_sentence_start], 0
                inc dword [word_count]
                
            not_space:
            
            cmp al, '?'
            jne not_q_mark
                
                ; if al == '?'
                mov byte [is_sentence_start], 1
                inc dword [word_count]
                mov [esi+ebx], byte 0
                
                ; printf(message, &first_word, word_count)
                push dword [word_count]
                push dword first_word
                push dword message
                call [printf]
                add esp, 4*3
                
                ; reinitialize all variables/registers that count things in a sentence
                mov dword [word_count], 0 ; word_count = 0
                mov [first_word], byte 0 ; first_word string = '\0'
                xor ebx, ebx ; counter for the first_word positions
                
                jmp read_loop
                
            not_q_mark:
            
            cmp [is_sentence_start], byte 1
            jne not_first_word
            
                ;if !(al == '?' || al == ' ') && is_sentence_start == 1
                mov [esi+ebx], al
                inc ebx
                
            not_first_word:
            
            jmp read_loop
            
        end_read_loop:
        
        
        ; fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        program_end:
        
        push    dword 0
        call    [exit]
