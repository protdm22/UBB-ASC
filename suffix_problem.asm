bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    s1 db "cercel", 0
    s2 db "ciolacu marcel", 0

segment code use32 class=code
    start:
        ; Initialize BL and BH which whill store the lengths of the strings
        ; BL = len(s1)
        ; BH = len(s2)
        mov BL, 0
        mov BH, 0
        
        ; Calculate len of s1
        mov ESI, s1
        calculate_len1:
            lodsb
            cmp AL, 0
            jz final_len1
                add BL, 1
        jmp calculate_len1
        final_len1:
        
        ; Calculate len of s2
        mov ESI, s2
        calculate_len2:
            lodsb
            cmp AL, 0
            jz final_len2
                add BH, 1
        jmp calculate_len2
        final_len2:
        
        ; BL = len(s1)
        ; BH = len(s2)
        
        mov ECX, 0
        
        ; ECX = the len of s1 or s2 which is smaller
        cmp BL, BH
        ja len1_bigger
            mov CL, BL
        len1_bigger:
        
        jbe len2_bigger
            mov CL, BH
        len2_bigger:
        
        both_strings_exist:
            mov AL, [
        loop both_strings_exist
    
    
        push dword 0
        call [exit]
    
    