.model small
.stack 64

.data 
    
    var dw 6789
    result dw 0
    
.code
    
    main proc near
        
        mov AX, @data
        mov DS, AX
        mov ES, AX
        
        mov AX, var
        call SumofDigits
        
        mov AX, 4C00H
        int 21H
        
    main endp  
    
    SumofDigits proc near
        
        mov BX, 10
        
        check_loop:
            
            cmp AX, 0
            je done 
            
            mov DX, 0                     ; Extract Digit
            div BX
            
            push AX                       ; Save value of AX
            mov AX, result
            add AX, DX                    ; Add Modulu to result 
            mov result, AX                ; Mov the data back to result
            
            pop AX                        ; Retrieve the value of AX back
            jmp check_loop
            
        done:
        
            ret
       
    SumofDigits endp