; 13. A file name and a text (defined in the data segment) are given. The text contains lowercase letters, uppercase letters, digits and special characters. Transform all the lowercase letters from the given text in uppercase. Create a file with the given name and write the generated text to file.

bits 32
global start

extern exit, fread, fopen, fclose, fprintf
import exit msvcrt.dll
import fread msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll

segment data use32 class=data
    file_name db "hw_lab8.txt", 0
    access_mode db "w", 0
    
    file_descriptor dd -1
    
    text dd "test Test TEST email123@gmail.com", 0
    lentext equ $-text

segment code use32 class=code
    start:
        ; lowercase to uppercase
        mov ECX, lentext
        mov ESI, text
        text_loop:
            lodsb ; AL = load first byte, ESI += 1
            cmp AL, 'a'
            jb not_lowercase ; <'a'   --> jump
            cmp AL, 'z'
            ja not_lowercase ; >'z'   --> jump
                sub AL, 'a'-'A'
                mov [ESI-1], AL
            not_lowercase:
        loop text_loop
        
        ; EAX = fopen(read_file_name, access_mode_input)
        push dword access_mode
        push dword file_name
        call [fopen]
        add ESP, 4*2
        
        mov [file_descriptor], EAX ; file_descriptor = EAX
        cmp EAX, 0 ; check if fopen() has successfully created the file (EAX != 0 -> success)
        
        je final
        
        ; fprintf(file_descriptor, text)
        push dword text
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*2

        ; fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        final:
        
        push    dword 0
        call    [exit]
