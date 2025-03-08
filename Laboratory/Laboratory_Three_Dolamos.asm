.model small 
.stack 64 

.data 

   InitArray db 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
   FibInit dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0                ; Reserve 20 for result

.code 

    main proc near 
        
        mov AX, @data 
        mov DS, AX 
        mov ES, AX 
        
        mov SI, 0               ; Index for InitArray
        mov DI, 0               ; Index for FibInit

    lp:                          
        cmp SI, 20              ; Check if all values in InitArray are traversed
        jge done       
    
        mov AL, InitArray[SI]   ; Get current value in initial array to AL
        cbw                     ; Conversion from byte to word
                                
        cmp AX, 0               ; n == 0
        je zero                 
        cmp AX, 1               ; n == 1
        je one                  

        push BX                 ; Process if n > 1
        push CX
        mov CX, AX  
        mov AX, 0   
        mov BX, 1   

    fib_lp: 
        add AX, BX  
        xchg AX, BX 
        loop fib_lp

        pop CX
        pop BX
        jmp res

    zero:                       ; Base Case F(0)
    
        mov AX, 0
        jmp res

    one:                        ; Base Case F(1)
   
        mov AX, 1
        jmp res

    res:                        ; Store result to FibInit word array
    
        mov FibInit[DI], AX 
    
        inc SI              
        add DI, 2               ; Increment DI to 2 to accomodate dw
        jmp lp
    
    done:
        mov AX, 4C00H 
        int 21H 
    
    main endp