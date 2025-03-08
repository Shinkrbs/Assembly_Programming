.model small
.stack 64 

.data
    input dw 100    
    cycle_ctr dw 0  

.code  

    main proc near
        mov AX, @data
        mov DS, AX
        mov ES, AX
    
        mov CX, 0          
        mov AX, input  
    
    collatz:
        cmp AX, 1          ; If AX == 1, stop
        jz res
        
        inc CX             
        test AX, 1         ; Test if AX == 1 to stop loop
        jz even
        jmp odd
                    
    even:
        ; Even Case: AX = n / 2
        mov DX, 0       ; Ensure DX is empty before division
        mov BX, 2
        div BX          ; AX = AX / 2 (divide by 2)
        jmp collatz  
        
    odd:
        ; Odd case: AX = 3 * n + 1          
        mov BX, 3
        mul BX
        inc AX            
        jmp collatz
    
    res:
        mov cycle_ctr, CX     ; Final Count is stored in CX 
    
        mov AX, 4C00H      
        int 21H
    
    main endp