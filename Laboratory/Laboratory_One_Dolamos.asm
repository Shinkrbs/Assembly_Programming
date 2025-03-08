.model small 
.stack 64
 
.data 
   ;declare the variables from the memory map here
   var1 db 164
   var2 dw 084FBH
   var3 dd 085BA45FDH
   set1 db 5, 6, 7
   set2 db 08H, 0AH, 0BH, 0CH   
   set3 dw 078AH, 09453H, 0321AH     
     
   
.code 

   main proc near 
   mov AX,@data 
   mov DS,AX 
   mov ES,AX 
    
   ;Write your assembly code here
   
   ;Loaded items to register 
   mov AH, var1
   mov AL, set1
   mov BX, var2
   mov CX, set3
   mov DX, AX
   
   ;Stored items to memory from register
   mov var1, CH
   mov set1, CL
   mov var2, AX
   mov set3, BX
 
   mov AX,4C00H 
   int 21H 
 
   main endp  