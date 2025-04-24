bits 32
global start        

extern exit, scanf, printf , fread, fopen, fclose   
     
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
import fread msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll

segment data use32 class=data
    read_mode db "r", 0
    input_file db "input2c.txt", 0
    file_descriptor dd 0
    format db "%s", 0
    text times 100 db 0
    is_xyXY db 0
   
    
segment code use32 class=code
    start:
       
        push dword read_mode
        push dword input_file
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
        
        text_iteration:
        
            mov al, [esi+ebx]
            cmp al, 0
            je text_end
            
            mov [is_xyXY], byte 0
            
            cmp al, 'y'
            jne not_y
                mov eax, 'a'
                mov [is_xyXY], byte 1
            not_y:
            
            cmp al, 'z'
            jne not_z
                mov eax, 'b'
                mov [is_xyXY], byte 1
            not_z:
            
            cmp al, 'Y'
            jne not_Y
                mov eax, 'A'
                mov [is_xyXY], byte 1
            not_Y:
            
            cmp al, 'Z'
            jne not_Z
                mov eax, 'B'
                mov [is_xyXY], byte 1
            not_Z:
            
            mov dl, 1
            cmp dl, [is_xyXY]
            je xyXY
                cmp dl, 'A'
                jb not_letter
                
                cmp dl, 'z'
                ja not_letter
                
                add al, byte 2
                
                not_letter:
            xyXY:
            
            mov [esi+ebx], al
            
            inc ebx
        
            jmp text_iteration
            
        text_end:
        
        push dword text
        push dword format
        call [printf]
        add esp, 4*2
        
        program_end:
        
        push    dword 0
        call    [exit] 
