.model small
.stack 64

.data 

outChar db 0, '$'
paraList label byte
maxLen db 10
actLen db ?
kbData db 10 dup(''), '$'

.code
main proc near
    
    mov AX, @data
    mov DS, AX
    mov ES, AX
    
    call funcCounter
    
    exit:
    mov AX, 4C00H
    int 21H

main endp

setVideoMode proc near 
    
    mov AH, 00H
    mov AL, 03H
    int 10H
    ret

setVideoMode endp   

funcCounter proc near
    
    call setVideoMode
    
    lea DX paraList
    mov AH, 0AH
    int 21H
    
funcCounter endp