.model small
.stack 64

.data  

    ; Prime part 2
    var dw 13
    result db 1              ; Assume prime (1 = Prime, 0 = Not Prime)
    limit dw 0
    
.code 
    
    main proc near
         
         mov AX, @data
         mov DS, AX
         mov ES, AX
         
         mov AX, var
         call isPrime 
         
         mov AX, 4C00H
         int 21H
         
    main endp 
    
    isPrime proc near
            
         mov CX, 2
         
         find_limit:
            
            push AX
            mov DX, 0
            mov BX, 2
            div BX
            mov limit, AX
            pop AX
            
         check_loop:
            
            cmp CX, limit
            je done
            
         find_factors:
            
            push AX
            mov DX, 0
            mov BX, CX
            div BX
            
            cmp DX, 0
            jne continue
          
         found_factor:
         
            mov result, 0
            pop AX
            ret
            
         continue:
            
            inc CX 
            pop AX
            jmp check_loop
            
         done: 
            
            ret    
            
    isPrime endp