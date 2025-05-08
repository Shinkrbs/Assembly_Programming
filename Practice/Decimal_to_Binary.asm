.model small
.stack 64

.data
    
    inp dw 1000
    res dw 0
    
.code

    main proc near
        
        mov AX, @data
        mov DS, AX
        mov ES, AX
        
        mov AX, inp 
        call binary
        
        mov AX, 4C00H
        int 21H
    main endp  
    
    binary proc near
           
          mov BX, 0
          
          binary_loop:
            
            cmp AX, 0
            je done
            
            mov DX, 0
            mov CX, 2
            div CX
            
            shl res, 1
            or res, DX
            
            inc CX
            
            jmp binary_loop
            
            done:
                ;call reverse 
                ret
    
    binary endp   
    
    reverse proc near
            
            mov AX, res
            mov BX, 0               ; BX = Final Reversed Result
            mov CX, 10
            
            rev_loop:
                
                cmp AX, 0
                je done_rev
                
                mov DX, 0
                div CX
                
                push AX
                push DX 
                
                mov AX, BX
                mul CX
                
                pop DX
                
                add AX, DX 
                mov BX, AX 
                
                pop AX
                
                jmp rev_loop
 
            done_rev:
                mov res, BX
                ret  
        
    reverse endp