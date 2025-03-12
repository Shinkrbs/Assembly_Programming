.model small 
.stack 64  

.data 
    array db 10, 9, 4, 2, 1, 3, 5, 7, 2, 6, 8, 12, 11, 13, 15 
    len equ ($ - array)  
 
.code  

   main proc near 
    
        mov AX,@data 
        mov DS,AX 
        mov ES,AX
        
        mov BX , 0                               ; BX = starting address                              
        call selection_sort 
        
        
        mov AX,4C00H 
        int 21H 
 
   main endp
   
   get_min proc near
        
        push BX
        push DI
        push SI
        
        mov SI, BX
        mov DI, CX 
        
        in_loop:                                   ; inner loop (j)
            
            inc DI
            cmp DI, len                            ; DI >= len
            jge done_min
            
            mov AL, array[SI]                      ; compare array[SI] < array[DI]
            cmp AL, array[DI]                      
            jl skip 
                                          
            mov SI, DI                             ; update index of min_indx
            
        skip:
            
            jmp in_loop 
            
        done_min:
            
            mov CX, SI 
            
            pop SI
            pop DI
            pop BX
            ret
    get_min endp
            
    selection_sort proc near
           
           out_loop:                            ; outer loop (i)
           
                cmp BX, len - 1
                jge done_sort 
                
                mov CX, BX
                push BX                         ; Save the current value of BX
                call get_min
                pop BX                          ; Get Value of BX again from function call  
                
                cmp BX, CX                      ; Skip if equal
                je skip_swap
                
                mov SI, BX
                mov AL, array[SI] 
                mov AH, AL                      ; treat AH as temp
                mov DI, CX
                mov AL, array[DI] 
                mov array[SI], AL               ; Swap the values   
                mov AL, AH
                mov array[DI], AL  
                
           skip_swap:
                
                inc BX
                jmp out_loop
                
           done_sort: 
           
                ret
     selection_sort endp     