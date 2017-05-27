.text

main:
addi r17, r0, 1 #r17 eh o registrador com o resultado do fatorial
addi r18, r0, 3 #numero que se quer o fatorial


FATORIAL:
subi sp, sp, 8 #libera duas posicoes na pilha
stw ra, (sp) #armazena na posicao 1 da pilha
stw r16, 4(sp) #armazena na posicao 4 da pilha


#se numero igual a 0
beq r18, r0, ACABOU  #acaba fatorial se o numero desejado for igual a zero

mov r16, r18
subi r18, r18, 1
call FATORIAL
 
mul r17, r16, r17
 
ACABOU:
ldw ra, (sp)
ldw r16, 4(sp)
addi sp, sp, 8
beq ra, r0, FIM #evita erro de memoria invalida
jmp ra

FIM:
