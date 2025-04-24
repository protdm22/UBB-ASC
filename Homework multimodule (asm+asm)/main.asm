; 13. Three strings of characters are given. Show the longest common suffix for each of the three pairs of two strings that can be formed

bits 32
global start
extern exit, printf, scanf

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

extern get_suffix

segment data use32 class=data
    format_read db "%s", 0
    msg_read1 db "Enter the first string: ", 0
    msg_read2 db "Enter the second string: ", 0
    msg_read3 db "Enter the third string: ", 0
    message db "Longest suffix between %s and %s is %s", 10, 13, 0
    s1 resb 100 ; reserve space for first string
    s2 resb 100 ; reserve space for second string
    s3 resb 100 ; reserve space for third string
    
segment code use32 public code
    start:
        ; print message for first string
        push dword msg_read1
        call [printf]
        add esp, 4
        
        ; read first string
        push dword s1
        push dword format_read
        call [scanf]
        add esp, 4*2
        
        ; print message for second string
        push dword msg_read2
        call [printf]
        add esp, 4
        
        ; read second string
        push dword s2
        push dword format_read
        call [scanf]
        add esp, 4*2
        
        ; print message for third string
        push dword msg_read3
        call [printf]
        add esp, 4
        
        ; read third string
        push dword s3
        push dword format_read
        call [scanf]
        add esp, 4*2
    
        ; get_suffix(s1,s2)
        push s2
        push s1
        call get_suffix
        
        ; printf(get_suffix(s1,s2))
        push eax
        push s2
        push s1
        push dword message
        call [printf]
        add esp, 4*4
        
        ; get_suffix(s1,s3)
        push s3
        push s1
        call get_suffix
        
        ; printf(get_suffix(s1,s3))
        push eax
        push s3
        push s1
        push dword message
        call [printf]
        add esp, 4*4
        
        ; get_suffix(s2,s3)
        push s3
        push s2
        call get_suffix
        
        ; printf(get_suffix(s2,s3))
        push eax
        push s3
        push s2
        push dword message
        call [printf]
        add esp, 4*4
  
        push    dword 0
        call    [exit]
