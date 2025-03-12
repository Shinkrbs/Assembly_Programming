.model small
.stack 64

.data


.code
    main proc near
        
            mov AX, 4C00H
            int 21H  
    main endp