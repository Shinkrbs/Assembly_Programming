.stack 64

.data

    var1 db 94
    var2 dw 123AH
    var3 dd 6531
    set1 db "EFG" ;ASCII 'A' is 41H
    set2 dw 413BH,2CH,1BFH
    set3 dd 1424,1213
    
.code

main proc near
    
    ;data segment starts as 07140
    mov AX, @data
    mov ES,AX
    mov DS,AX
    
    ;start evaluating here
    mov AL,var1
    mov BX,set2
    add BL,AL ;BL = BL + AL
    mov CX,var2
    mov DX,BX
    add DL,CH
    ;end evaluation here
    
    mov AX,DX
    int 21H
    
main endp
