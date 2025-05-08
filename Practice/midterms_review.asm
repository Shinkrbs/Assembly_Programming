.model small
.stack 64

.data
    
    mScr1 dw 5 DUP (1)
    mScr2 dw 5 DUP (2)
    mRes dw DUP (0)
    
.code
    
    main proc near
        
        mov AX, @data
        mov DS, AX
        mov ES, AX
        
        lea SI, mScr1
        mov CX, 5
        
        beginInit1:
            
            mov BX, [SI]
            mov DX, 0
            inc BX
            mov AX, BX
            add BX, CX  
            mov AX, BX
            mul CX
            mov BX, AX
            mov [SI], BX
            add SI, 2
            loop beginInit1
            
        lea BX, mScr1
        lea SI, mScr2
        mov CX, 5
        
        beginInit2:
            
            mov DX, 0
            mov AX, [SI]
            add AX, CX   
            div CX
            add DX, [BX]
            add AX, DX
            mov [SI], AX
            add SI, 2
            add BX, 2
            loop beginInit2  
            
        lea BX, mScr1
        lea SI, mScr2
        lea DI, mRes
        mov CX, 5
        
        beginInit3:
            
            mov AX, [BX]
            mov DX, [SI]
            cmp AX, DX
            jle a
            jmp s
            
            a:
                add AX, DX
                jmp store
            s:
                sub AX, DX 
                
            store:  
                
                mov [DI], AX
                add SI, 2
                add DI, 2
                add BX, 2
            loop beginInit3
            
         
        mov AX, 4C00H
        int 21H 
            
    main endp
        
        