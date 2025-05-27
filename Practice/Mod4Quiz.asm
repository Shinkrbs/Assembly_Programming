.model small
.stack 64

.data

.code

main proc near

mov AX, @data
mov DS, AX
mov ES, AX

mov AH, 07H
int 21H

mov AX, 4C00H
int 21H
main endp