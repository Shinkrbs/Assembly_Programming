.model small
.stack 64

.data
    
    prisonerA db 1 DUP(' ', '$')
    prisonerB db 1 DUP(' ', '$') 
    
    promptA db "Prisoner A: ", "$"
    promptB db "Prisoner B: ", "$"
    
    res1 db "Each Serve 2 Years", "$"
    res2 db "Prisoner A: 10 Years", 0Dh, 0Ah, "Prisoner B: goes free", "$"  
    res3 db "Prisoner A: goes free", 0Dh, 0Ah, "Prisoner B: 10 Years", "$"
    res4 db "Each Serve 5 Years", "$"
    
    res db "Try Again? [Y/N]", '$'

.code
main proc near

    mov AX, @data
    mov DS, AX
    
    start:
    ; Restart video mode to clear screen :)
    mov AH, 00H   
    mov AL, 03H  
    int 10H  
    
    ; Display prompt for Prisoner A
    mov AH, 09H
    lea DX, promptA
    int 21H

    ; Get user input for prisoner A
    validateA:
    cmp AL, 'C'
    je validInputA
    cmp AL, 'c'
    je validInputA
    cmp AL, 'D'
    je validInputA
    cmp AL, 'd'
    je validInputA

    mov AH, 08H   
    int 21H
    jmp validateA 

    validInputA:
    mov prisonerA, AL
    
    ; Print newline
    mov AH, 02H
    mov DL, 0Dh
    int 21H
    mov DL, 0Ah
    int 21H
    
    ; Display prompt for Prisoner B 
    mov AH, 09H
    lea DX, promptB
    int 21H

    ; Get user input for prisoner B 
    validateB:
    cmp AL, 'C'
    je validInputB
    cmp AL, 'c'
    je validInputB
    cmp AL, 'D'
    je validInputB
    cmp AL, 'd'
    je validInputB 
    
    mov AH, 08H
    int 21H
    jmp validateB
    
    validInputB:
    mov prisonerB, AL  
    
    mov AH, 02H
    mov DL, 0Dh
    int 21H
    mov DL, 0Ah
    int 21H
    
    call validateResult
    
    mov AH, 02H
    mov DL, 0Dh
    int 21H
    mov DL, 0Ah
    int 21H 
    
    ; Display restart 
    mov AH, 09H
    lea DX, res
    int 21H
    
    ; Validate restart input
    validateRes:
    mov AH, 08H   
    int 21H

    cmp AL, 'Y'
    je start
    cmp AL, 'y'
    je start
    cmp AL, 'N'
    je exit
    cmp AL, 'n'
    je exit

    jmp validateRes 
 
    exit: 
    mov AX, 4C00H
    int 21H        

main endp   

validateResult proc near

    ; Validate prisoner choices
    mov AL, prisonerA
    mov BL, prisonerB

    cmp AL, 'C'
    je checkB_C
    cmp AL, 'c'
    je checkB_C
    jmp checkDefectA

    checkB_C:
    cmp BL, 'C'
    je displayRes1
    cmp BL, 'c'
    je displayRes1
    jmp displayRes2
    
    checkDefectA:
    cmp BL, 'C'
    je displayRes3
    cmp BL, 'c'
    je displayRes3
    jmp displayRes4
    
    displayRes1:
    lea DX, res1
    jmp printResult
    
    displayRes2:
    lea DX, res2
    jmp printResult
    
    displayRes3:
    lea DX, res3
    jmp printResult

    displayRes4:
    lea DX, res4
    
    printResult:
    mov AH, 09H
    int 21H

    ret
validateResult endp
