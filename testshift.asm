bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, fread, printf, fopen, fclose

import exit msvcrt.dll
import scanf msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll  
import fopen msvcrt.dll  
import fclose msvcrt.dll    

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    read_mode db "r", 0
    filename resb 100
    f_format db "%s", 0
    n_format db "%d", 0
    print_format db "Number of bits on the %d position: %d", 0
    buffer dd 0
    msg1 db "Filename = ", 0
    msg2 db "N = ", 0
    file_descriptor dd 0
    text times 100 db 0
    n_bit db 0
    bit_counter db 0
    

; our code starts here
segment code use32 class=code
    start:
        push dword msg1
        call [printf]
        add esp, 4
        
        push dword filename
        push dword f_format
        call [scanf]
        add esp, 4*2
        
        push dword msg2
        call [printf]
        add esp, 4
        
        push dword buffer
        push dword n_format
        call [scanf]
        add esp, 4*2
        
        mov al, [buffer]
        mov [n_bit], al
        
        push dword read_mode
        push dword filename
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax
        
        cmp eax, 0
        je program_end
        
        push dword [file_descriptor]
        push dword 100
        push dword 1
        push dword text
        call [fread]
        add esp, 4*4
        
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        mov esi, text
        
        xor ebx, ebx
        
        iterate_text:
        
            mov al, [esi+ebx]
            
            cmp al, 0
            je end_iteration

            mov cl, [n_bit]
            shr al, cl
            
            jnc no_carry
                inc byte [bit_counter]
            no_carry:
            
            inc ebx
            
            jmp iterate_text
            
        end_iteration:
    
        xor eax, eax
        mov al, [n_bit]
    
        push dword [bit_counter]
        push eax
        push dword print_format
        call [printf]
        add esp, 4*3

        program_end:
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
