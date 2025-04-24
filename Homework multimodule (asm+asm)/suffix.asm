; 13. Three strings of characters are given. Show the longest common suffix for each of the three pairs of two strings that can be formed

bits 32                         
segment code use32 public code
global get_suffix

; char* get_suffix(char* s1, char* s2);
;   [esp] - ret addres
;   [esp+4] - s1
;   [esp+8] - s2

; get_suffix(char*, char*): char*
;       - 2 parameters s1,s2: char*
;       - calculates the longest suffix between s1 and s2
;       - return address of result string in eax: char*
;       - uses/modifies eax, ebx, ecx, edx, esi, edi

get_suffix:
    
    mov esi, [esp+4] ; esi = s1
    mov edi, [esp+8] ; edi = s2
    
    mov ecx, 0
    
    ; get length of s1
    len1_loop:
    mov al, [esi+ecx]
    test al, al
    jz string1_end
        inc ECX
    jmp len1_loop
    string1_end:
    
    mov ebx, ecx ; ebx = length of s1
    mov ecx, 0
    
    ; get length of s2
    len2_loop:
    mov al, [edi+ecx]
    test al, al
    jz string2_end
        inc ecx
    jmp len2_loop
    string2_end:
    
    mov edx, ecx ; edx = length of s2
    
    find_suffix:
    
        dec ebx
        dec edx
        jl suffix_end
    
        mov al, [esi+ebx] ; al = ebx-th character of s1
        cmp al, [edi+edx] ; compare al with edx-th character of s2 (fictive subtraction)
        jne suffix_end ; jump if no longer suffix
            dec ecx
    
    jmp find_suffix
    suffix_end:
    
    lea eax, [edi+ecx] ; load in eax the address of the longest suffix
    
    ret 4*2