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
    read_file_name db "hw_lab8_input.txt", 0
    write_file_name db "hw_lab8_output.txt", 0
    
    access_mode_input db "r", 0
    access_mode_output db "w", 0
    
    file_descriptor dd -1
    len equ 100
    
    text times len db 0

segment code use32 class=code
    start:
        ; EAX = fopen(read_file_name, access_mode_input)
        push dword access_mode_input
        push dword read_file_name
        call [fopen]
        add ESP, 4*2
        
        mov [file_descriptor], EAX ; file_descriptor = EAX
        cmp EAX, 0 ; check if fopen() has successfully created the file (EAX != 0 -> success)
        
        je final
        
        ; EAX = fread(text, 1, len, file_descriptor)    // EAX will contain the number of chars read
        push dword [file_descriptor]
        push dword len
        push dword 1
        push dword text        
        call [fread]
        add ESP, 4*4
        
        push EAX
        
        ; fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add ESP, 4

        ; lowercase to uppercase
        pop ECX ; ECX = numbers of chars of text
        mov ESI, text
        text_loop:
            lodsb ; AL = load first byte, ESI += 1
            cmp AL, 'a'
            jb not_lowercase ; <'a' -> jump
            cmp AL, 'z'
            ja not_lowercase ; <'z' -> jump
                sub AL, 'a'-'A'
                mov [ESI-1], AL
            not_lowercase:
        loop text_loop
        
        ; EAX = fopen(read_file_name, access_mode_input)
        push dword access_mode_output
        push dword write_file_name
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