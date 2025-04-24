bits 32
global start        

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    format db "%d ", 0
    message db "Sorted array: ", 0
    a db 10, 4, 6, 2, 1, 50, 25, 4, 200
    lena db $-a
    

segment code use32 class=code
    start:
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
        
        push message
        call [printf]
        add esp, 4

        xor eax, eax
        
        display_loop:
            cmp eax, dword [lena]
            je final_program
            
            pushad
            
            xor ebx, ebx
            mov bl, [esi+eax]
            
            push ebx
            push dword format
            call [printf]
            add esp, 4*2
            
            popad
            
            inc eax
            jmp display_loop
            
        final_program:

        push    dword 0
        call    [exit]
