.model small
.stack 64

; Finding out if a number is prime or not
.data    

    var dw 100     ; Number to check
    prime db 1     ; Assume prime initially (1 = prime, 0 = not prime)

.code 

    main proc near 
        
        mov AX, @data
        mov DS, AX
        mov ES, AX 
        
        mov AX, var   ; Load number
        mov BX, 2
        mov DX, 0
        div BX        ; AX = var / 2 (limit for checking)

        push AX       ; Save (var / 2)
        mov AX, var   ; Restore original number
        call isPrime  ; Check primality
        pop AX        ; Restore AX

        mov AX, 4C00H ; Exit program
        int 21H
    main endp
    
    isPrime proc near 
        
        mov CX, 2    ; Start divisor from 2
        mov prime, 1 ; Assume number is prime

    check_loop:    
    
        cmp CX, AX   ; If CX >= AX, exit
        jge done 

        mov DX, 0    ; Clear DX
        mov BX, CX   ; Set divisor
        div BX       ; AX / BX, remainder in DX

        cmp DX, 0    ; If remainder is 0, number is NOT prime
        je not_prime 

        inc CX       ; Increase divisor
        jmp check_loop

    not_prime:
        mov prime, 0 ; Set prime = 0 (not prime)
    
    done:
        ret
    isPrime endp
