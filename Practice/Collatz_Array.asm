.model small
.stack 64

.data 

     arr dw 10, 20, 30, 40, 50, 60, 70, 80, 90, 100
     res dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0           ; Reserve 10 bytes for results
     len equ ($ - arr) / 2                         ; length of arr
     
     
.code

    main proc near
         
         mov AX, @data
         mov DS, AX
         mov ES, AX
         
         ; Main Process Here
         mov SI, 0
         mov DI, 0
         mov BX, len
         
         loop_start: 
             
             cmp BX, 0
             jz end
             
             mov AX, arr[SI]
             mov CX, 0
             
         collatz:
             
             cmp AX, 1
             jz store
             
             test AX, 1
             jz even 
               
         odd:
         
            mov DX, 0
            mov DX, AX
            mov AX, 3
            mul DX
            add AX, 1
            inc CX
            jmp collatz
             
         even:
         
            mov DX, 0
            push BX                                ; Store the current length to stack
            mov BX, 2                              ; Use BX for division
            div BX
            pop BX                                 ; Store the length to BX again
            inc CX
            jmp collatz
                
         
         store:
         
            mov word ptr res[DI], CX
            add SI, 2
            add DI, 2
            dec BX
            jmp loop_start
            
        
        end:
           mov AX, 4C00H
           int 21H
    main endp               