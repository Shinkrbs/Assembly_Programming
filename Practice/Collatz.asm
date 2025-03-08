.model small 
.stack 64
 
.data 
   ; Goal Count Number of steps to reach collatz sequence.
   input dw 10
   result dw ?
    
.code 

   main proc near 
   mov AX,@data 
   mov DS,AX 
   mov ES,AX 
   
   mov CX, 0
   mov AX, input
   
   loop:
        cmp AX, 1   ; Base Case
        jz done     ; End the loop
        
        test AX, 1  ; Check if current number is odd or even
        jz even
        
        jnz odd

   odd: 
        mov DX, 0
        mov BX, 3
        mul BX
        add AX, 1
        inc CX
        jmp loop
        
   even:
        mov DX, 0
        mov BX, 2
        div BX
        inc CX 
        jmp loop
        
   done:
        mov result, CX
        mov AX,4C00H 
        int 21H 
 
   main endp 