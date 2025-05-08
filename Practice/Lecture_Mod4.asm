.model small
.stack 64

.data
       
    PARA_LIST LABEL BYTE; Start a parameter list
    MAX_LEN DB 20 ; Maximum number input characters

    ACT_LEN DB ? ; Actual number of input characters
    KB_DATA DB 20 DUP(' ', '$');Characters entered in Kb 
    
    dispStr db "This is a string: ", "$" 
    
.code
    
    main proc near
    
    mov AX, @data
    mov ES, AX
    mov DS, AX
    
    mov AH, 09H 
    lea DX, dispStr
    int 21H
    
    ; input
    mov AH, 00H
    lea DX, PARA_LIST
    int 21H 
    
    ; Display
    lea DX, KB_DATA
    mov AH, 09H
    int 21H
    
    mov AX, 04C00H
    int 21H
    main endp