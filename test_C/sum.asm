bits 32
global _sum
segment data public data use32
segment code public code use32
_sum:
    push ebp
    mov ebp, esp
    
    mov esi, [ebp+8]
    mov edi, [ebp+12]
    
    mov ecx, 0
    
    len1_loop:
    mov al, [esi+ecx]
    test al, al
    jz string1_end
        inc ECX
    jmp len1_loop
    string1_end:
    
    mov ebx, ecx
    mov ecx, 0
    
    len2_loop:
    mov al, [edi+ecx]
    test al, al
    jz string2_end
        inc ECX
    jmp len2_loop
    string2_end:
    
    mov edx, ecx
    
    find_suffix:
    
        dec ebx
        dec edx
        jl suffix_end
    
        mov al, [esi+ebx]
        cmp al, [edi+edx]
        jne suffix_end
            dec ecx
    
    jmp find_suffix
    suffix_end:
    
    lea eax, [edi+ecx]
    
    pop ebp
    
    ret