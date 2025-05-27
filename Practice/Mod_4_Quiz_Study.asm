.model small
.stack 64

.data 

; Test 1
outChar db 0, '$'
paraList label byte
maxLen db 10
actLen db ?
kbData db 10 dup(''), '$'

; Test 2
ascChar db 2FH 

; Test 3
input db ' ', '$'

.code
main proc near
    
    mov AX, @data
    mov DS, AX
    mov ES, AX
    
    call funcCounter 
    ;call ascToChar
    ;call toHex
    
    exit:
    mov AX, 4C00H
    int 21H

main endp

setVideoMode proc near 
    
    mov AH, 00H
    mov AL, 036H
    int 10H
    ret

setVideoMode endp   

funcCounter proc near
    
    call setVideoMode
    
    ; Get input from keyboard
    mov AH, 0AH
    lea DX, paraList
    int 21H 
    
    ; Get keystroke from keyboard 
    mov AH, 00H
    int 16H 
    
    mov CX, 00
    mov CL, actLen
    lea BX, kbData
    
    L1:
    mov AH, [BX]
    cmp AL, AH
    jne continue
    inc outChar
    
    continue:
    inc BX
    
    loop L1
    
    ; ASCII character 30-39, '0'-'9'
    mov AL, outChar
    add AL, 30H
    mov outChar, AL
    
    ; Display Character with Attribute 
    lea DX, outChar
    mov AH, 09H
    int 21H
                  
    ret
      
funcCounter endp   

ascToChar proc near 
    
    call setVideoMode
    
    mov DH, 00
    L2: 
    ; To set cursor position and create new line
    mov AH, 02H
    mov BH, 00
    inc DH
    mov DL, 00
    int 10H 
    
    inc ascChar 
    
    ;Display 
    mov AH, 0AH
    mov AL, ascChar
    mov BH, 00
    mov BL, 0FH
    mov CX, 1
    int 10H
    
    mov AH, ascChar
    cmp AH, 3FH
    jne L2

ascToChar endp  

toHex proc near
  
    call setVideoMode  
      
    mov AH, 00H
    int 16H
    mov BL, AL
      
    shr BL, 4
      
    ; Convert to ASCII for printing
    cmp BL, 09H
    jbe ConvertNum
    add BL, 07H        ; Adjust for hex letters 'A'-'F'
    ConvertNum:
    add BL, 30H        ; Convert to ASCII

    ; Print the character
    mov AH, 02H        ; DOS print function
    mov DL, BL         ; Store ASCII character in DL
    int 21H            ; Print result

    ret
  
  
    
toHex endp