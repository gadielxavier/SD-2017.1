.text
addi r8, r0, 7
addi r9, r0, 3
addi r11, r0, 1
beq r9, r0, SEZERO
beq r9, r11, SEUM
mov r12, r0
mov r10, r8

LOOP:
addi r12, r12, 1
beq r9, r12, FIM
mul r10, r10, r8
call LOOP

SEZERO:
addi r10, r0 , 1
call FIM

SEUM:
mov r10,r8
call FIM

FIM: