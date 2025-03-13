.model small
.stack 64

.data 

    ; flags isPerfect with 1 if var1 is a perfect number, 0 if otherwise 
    ; review for module quiz
    var1 dw 6
    sum dw 0
    isPerfect db 0

.code 

    main proc near
        
            mov AX, @data
            mov DS, AX
            mov ES, AX
            
            mov CX, var1
            
            start:
                
                mov DX, 00
                mov AX, var1
                div CX 
                
                cmp DX, 00
                je acc
                jmp end
                
                acc: 
                    add sum, AX
             end:
                loop start
                
             mov AX, var1
             sub sum, AX
             cmp AX, sum
             
             jne noflag
             
             flag:
                
                inc isPerfect
                jmp stop 
                
             noflag:
                 
                 mov AL, 00
                 mov isPerfect, AL
                 
              stop: 
              
                 mov AX, 4C00H
                 int 21H         
    main endp