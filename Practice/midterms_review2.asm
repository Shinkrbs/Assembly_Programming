.model small
.stack 64

.data
    
    byteArr1 db 1, 2, 3, 4, 5, 6, 0
    byteArr2 db 3, 4, 5, 6, 7, 1, 12, 13, 0
    wordArr3 dw 10 DUP(?)
    
.code 
    
    main proc near
        
        mov AX, @data
        mov DS, AX
        mov ES, AX
        
        call f1
        
        mov AX, 4C00H
        int 21H
        
    main endp
    
    f1 proc near
           
        lea SI, byteArr1
        lea DI, byteArr2
        mov CL, 0
        
        L1:
            mov AL, [SI]
            inc SI
            inc CL
            cmp AL, 0
            jne L1 
            
        mov CH, 0
        mov AL, 1
          
        L2:
        
            mov AL, [DI]
            inc DI
            inc CH    
            cmp AL, 0
            jne L2
            
        cmp CH, CL
        jb start
        jmp start1
        
        start:
            
            mov CL, CH
            mov CH, 00
            
        start1:
            
            mov CH, 00
            
        push CX
        lea SI, byteArr1
        lea DI, byteArr2
        lea BX, wordArr3
        push BX
        
        startLoop:
            
            mov AL, [SI]
            mov AH, [DI]
            mul AH
            mov [BX], AX
            inc SI
            inc DI
            add BX, 2
            loop startLoop
            
        pop BX
        pop CX   
        mov AX, 00 
        
        startLoop1:
              
            add AX, [BX]
            add BX, 2
            loop startLoop1
            mov [BX], AX
        ret           
    f1 endp