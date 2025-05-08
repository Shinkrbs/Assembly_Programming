.model small
.stack 64

; Bubble Sort in Descending Order
.data
    
    array db 9, 8, 7, 6, 5, 4, 3, 2, 1
    len equ ($ - array) 
    

.code
    
    main proc near 
        
        mov AX, @data
        mov DS, AX
        mov ES, AX 
        
        mov SI, 0
        call bubble_sort 
        
        mov AX, 4C00H
        int 21H
    main endp
    
    bubble_sort proc near
        
        out_loop:
            
            mov BH, 0                   ; Treat BH as flag 
            cmp SI, len - 1
            jg done 
            
            mov DI, 0                   ; DI = j, SI = i
            
        in_loop:
            
            cmp DI, len - SI - 1        ; while DI < len - SI - 1
            jg done_in
            
   
            mov AL, array[DI]           ; array[DI] < array[DI + 1]
            cmp AL, array[DI + 1] 
            jg next
            
            ;mov AH, array[DI]
            ;xchg AH, array[DI + 1]
            ;mov array[DI], AH
            
            ; Swap Elements  
            mov AL, array[DI]
            mov AH, array[DI + 1]
            mov array[DI], AH
            mov array[DI + 1], AL

            mov BH, 1                   ; swap_flag = true
            
        next:
            
            inc DI
            jmp in_loop 
            
        done_in:
            
            cmp BH, 0                   ; compare if swap_flag = false, exit if true
            je done
            
            inc SI
            jmp out_loop   
               
        done:
            ret    
        
    bubble_sort endp