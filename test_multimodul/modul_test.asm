; 

bits 32
segment code use32 public code
global factorial

factorial:
    mov EAX, 1
    mov ECX, [ESP + 4]
    repeat:
        mul ECX
    loop repeat
    ret 4
