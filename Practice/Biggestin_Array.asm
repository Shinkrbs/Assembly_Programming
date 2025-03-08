.model small 
.stack 64  

; Goal: Find the biggest integer in array
.data 
    arr db 100, 3, 4, 50, 7, 8, 10 
    biggest db ?
    len equ $- arr                      ; Calculates the length of array using $ - directive
    
.code 

   main proc near 
   mov AX,@data 
   mov DS,AX 
   mov ES,AX 
   
   mov SI, 1
   mov CX, len - 1
   mov BH, arr[0]
   
   loop:                                ; Base Case
        cmp CX, 0
        jz done
                                        ; Traverses the array
        mov BL, arr[SI]                 ; Compares the current value
        cmp BH, BL                      ; Jumps to big function
        jl big
        
   continue:
        inc SI
        dec CX
        jmp loop
             
   big:
        mov BH, BL
        jmp continue
   
   done:
       mov biggest, BH 
       mov AX,4C00H 
       int 21H 
 
   main endp 