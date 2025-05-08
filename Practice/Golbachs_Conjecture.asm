.model small
.stack 64

.data  
    
    array dw 10, 12, 14, 16, 18
    result dw 10 dup(0)                                     ; stores the goldbachs pair by two
    prime db 1                                              ; eg. for indx(0) = 23, pairs = res(0 - 1) 
    limit dw ?
    g_limit dw ? 
    ctr dw 0

.code
    main proc near
        
        mov AX, @data
        mov DS, AX
        mov ES, AX   
        
        lea SI, array
        lea DI, result  
        
        call goldbach
        
        mov AX, 4C00H
        int 21H 
                                                                                   
    main endp
    
    goldbach proc near
        
        g_loop: ; Get Value from Array
            
            mov CX, ctr
            cmp CX, 5
            je g_done
            
            mov AX, [SI]
            mov g_limit, AX
            
            ; Test for even   
            test AX, 1
            jnz next_val 
            
            mov AX, 3
            
        outer_loop: ; Start Calculation here, outer loop i = AX
            
            cmp AX, g_limit ; Compare if i < g_limit
            jge next_val 
            
            ; Test for Prime
            call isPrime
            cmp prime, 0
            je next_num_out 
            
            mov BX, 3                                           
            
        inner_loop: ; Inner loop j = BX
        
            cmp BX, g_limit ; Compare if j < g_limit
            jge next_num_out
            
            push AX  
            mov AX, BX
            call isPrime
            pop AX 
            cmp prime, 0
            je next_num_in
               
            push AX
            add AX, BX
            cmp AX, g_limit
            pop AX
            jne next_num_in
            
            mov [DI], AX
            add DI, 2
            mov [DI], BX
            add DI, 2 
            jmp next_val
                
        next_num_in:
            
            add BX, 2
            jmp inner_loop
                 
        next_num_out:
            
            add AX, 2
            jmp outer_loop
            
        next_val:
            
            add SI, 2 
            inc ctr
            jmp g_loop
            
        g_done:
            ret
            
    goldbach endp 
    
    isPrime proc near 
        
        mov prime, 1        ; assume prime initially
        cmp AX, 2
        je done_prime       ; 2 is prime
        
        test AX, 1
        jz not_prime        ; even numbers >2 are not prime
        
        push AX
        mov CX, 3           ; start divisor at 3
        
        find_limit:
            push AX
            mov DX, 0
            mov BX, 2
            div BX
            mov limit, AX    ; limit = n/2
            pop AX
        
        check_loop:
            cmp CX, limit
            ja done_prime    ; if divisor > limit, we're done
            
            push AX
            mov DX, 0
            mov BX, CX
            div BX
            cmp DX, 0
            pop AX
            je not_prime     ; if divisible, not prime
            
            add CX, 2        ; check next odd number
            jmp check_loop
            
        not_prime:
            mov prime, 0
            
        done_prime:
            pop AX
            ret    
           
    isPrime endp 