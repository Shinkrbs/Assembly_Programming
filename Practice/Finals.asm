.model small
.stack 64

.data  
    b db 5
    c dw 0707H
    d dw 0707H 
    
    ; Repeat Prefix
    SEND_STR db 20 dup("*")  ;Send Field
    RECV_STR 20 dup (?)  ; Receive Field  
    
    ; Load String Instruction
    String1 db "Interstellar"
    String3 db "Interstellar"
    String4 db 12 dup('*') 
    String2 db 12 dup(20H)
    String5 db 12 dup(?) 
   
    ; XLAT instruction
    XLAT_TBL db 45 dup(40h)
                db 60h, 4bh
                db 40h
                db 0f0h, 0f1h, 0f2h. 0f3h, 0f4h
                db 0f5h, 0f6h, 0f7h, 0f8h, 0f9h
                db 198 dup(40h)
    
    ; Tables Direct Addressing
    MONTH_TBL DB 'January..' 
            DB 'February.' 
            DB 'March....' 
            DB 'April....' 
            DB 'May......' 
            DB 'June.....' 
            DB 'July.....' 
            DB 'August...' 
            DB 'September' 
            DB 'October..' 
            DB 'November.' 
            DB 'December.'
    

.code
main proc near
    
    mov AX, @data
    mov DS, AX
    mov ES, AX
    
    call func
    ;call repeat_mov 
    ;call load
    
    exit:
        mov AX, 4C00H
        int 21H    
main endp 

func proc near
    
    ; set video mode
    mov AH, 00H
    mov AL, 03H
    int 10H 
    
    l1:
        mov AX, 0601H
        mov BH, 0EFH
        mov CX, c
        mov dx, d
        int 10H
        
        sub c, 0101H
        add d, 0101H
        dec b
        cmp b, 0
        jne l1
    ret      
func endp    

repeat_mov proc near
    
    CLD
    mov CX, 20
    lea SI, SEND_STR
    lea DI, RECV_STR
    rep movsb
    ret
    
    ; REP: Repeat operation until CX is 0
    ; REPE/REPX: Repeat the operation while ZF indicates zero. Stop when ZF indicates not equal/zero when CX is decremented to zero
    ; REPNE/REPNZ: REpeat the operation while ZF indicates not zero. Stop when ZF indicates zero or when CZ is decremented to zero
repeat_mov endp    

load proc near
    
    CLD
    mov CX, 12
    lea SI, String1
    lea DI, String2+11
    
    l2:                           ; lods, getting charactiel in SI/AL
        lodsb                     ; mov AL, [SI]
        mov [DI], AL              ; inc SI
        dec DI 
    loop l2
           
load endp  

compare proc near
    
    CLD
    mov CX, 12
    lea DI, String3               ; Compares String 1 from String 2 not the other way around
    lea SI, String4
    repe cmpsb
    je ret                        ; je provides exit
compare endp 


store proc near
    
    ; jcxz  jump if cx is zero
    CLD
    mov AL, 20H                   ; 20H is ASCII for space
    mov CX, 12
    lea DI, String5
    rep stosb                         
store endp 

scan proc near
    
    CLD
    mov AL, 'r'                   ; scan for r
    mov CX, 12                    ; 12 characters to search technically the size of the search
    lea DI, String1               ; the character being scanned
    repne scasb                   ; repeat if not equal and scans every byte of the string
    je ret                        ; return if r is found
scan endp 

xlat_func proc near 
    
    lea BX, XLAT_TBL              ; BX, base address
    mov AX, 50                    ; AL, offset
    xlat 
    xlat                          ; AL + BX
    xlat                          ; translate byte to index in table
xlat_func endp

direct_addressing proc near
    
    ; Convert ASCII to month
    xor word ptr MONTH_IN, 3030h
    mov AX, 0
    mov BL, MONTH_IN+1
    mov AL, MONTH_IN+0
    mov DL, 10
    mul DL
    add AL, BL
    
    
    ; Locate the month table
        
direct_addressing endp