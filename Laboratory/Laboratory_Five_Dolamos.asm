.model small
.stack 64 

.data 
 
    row db 0
    column db 0 
    ascii db 0
    foreColor db 0     
    backColor db 0 
        
.code
    main proc near  
        
        mov AX, @data
        mov DS, AX
        mov ES, AX 
        call writeChar
        mov AX, 4C00H
        int 21H  
        
    main endp  
    
    writeChar proc near  
        
        call setVideo
     
        mov BH, 0     
        mov BL, 0      
        mov ascii, 0   
         
        ; BH = row
    outer_loop: 
    
        cmp BH, 16
        jge end_outer 
        
        ; BL = column
        inner_loop:
        
            cmp BL, 16
            jge end_inner 
            
            ; Set cursor position and display character
            mov row, BH
            mov column, BL
            
            push BX
            add BL, 7   ; for lighter colors (0-15 starts at dark colors)
            mov foreColor, BL
            pop BX
            
            mov AL, foreColor
            xor AL, 07h    ; Invert the color bits (complementary color) 
            mov backColor, AL
            
            push BX
            push CX 
            
            call setCursorPos 
            call displayASCII
            
            pop CX
            pop BX
            
            inc BL  
            inc ascii      
            
            jmp inner_loop 
            
        end_inner:  
        
            inc BH
            mov BL, 0
            jmp outer_loop 
        
    end_outer:
        ret  
        
    writeChar endp 
    
    setCursorPos proc near 
         
        mov AH, 02H
        mov BH, 00    
        mov DH, row
        mov DL, column
        int 10H
        ret 
        
    setCursorPos endp 
    
    displayASCII proc near 
        
        mov AH, 09H         
        mov AL, ascii      
        mov BH, 00          
        
        ; Combine foreground and background colors into attribute byte
        mov BL, backColor   
        shl BL, 4           
        or BL, foreColor    
        
        mov CX, 1          
        int 10H
        ret 
        
    displayASCII endp
    
    setVideo proc near 
        
        mov AH, 00H
        mov AL, 03H         
        int 10H
        ret 
         
    setVideo endp