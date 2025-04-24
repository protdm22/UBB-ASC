; 

bits 32
global start

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

extern exit, printf, scanf

extern factorial
;%include "modul_test.asm"

segment data use32
    n dd 0
    message_print db "%d! = %d", 0
    message_read db "n = ",0 
    format_read db "%d", 0
    
segment code use32 public code
;segment code use32 class=code
    start:
        push dword message_read
        call [printf]
        add esp, 4
        
        push dword n
        push dword format_read
        call [scanf]
        add esp, 4*2
        
        push dword [n]
        call factorial
        
        push EAX
        push dword [n]
        push dword message_print
        call [printf]
        add esp, 4*3
        
  
        push    dword 0
        call    [exit]
