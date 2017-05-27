.text
	movia r16, resultado  	#move registrador para a memoria
	addi r8, r0, 32		#QUANTIDADE DE NUMEROS PRIMOS(entrada)
	addi r9, r0, 2		#contador q verifica se eh primo(apenas 2 divisores com resto 0)
	addi r10, r0, 1		#numero que sera verificado se eh primo(comeca a parti do 1))
	addi r15, r0, 0		#contador tmp que conta qtd de primos achados
	
MAIN:
	mov r11, r10		#r11 = r10
	addi r14, r0, 0 	#contador tmp (incrementar quando o resto eh zero)

LOOP:
	beq r15, r8, FIM
	beq r11, r0, PRIME	#se chegou no 0 acabou a verificacao
	call DIV

	
DIV:
	div r12, r10, r11	#r12 = r10/r11
	mul r13, r12, r11	#checa o resto
	sub r13, r10, r13 	#r13 = resto
	addi r11, r11, -1	#r11 = r11 - 1
	bne r13, r0, LOOP	#se o resto for diferente de zero
	addi r14, r14, 1	#icrementa o valor do contador tmp
	call LOOP
	

	
PRIME:
	beq r14, r9, SAVE
	addi r10, r10, 1
	call MAIN 
SAVE:
	
	stw r10, 0(r16)		#salva na memoria
	addi r16, r16, 1	#atualiza r16
	
	
	
	addi r15, r15, 1 	#icrementa o valor do nmrs de primos achados
	addi r10, r10, 1
	call MAIN 
	
FIM:

.data
resultado:
.word 0,0,0,0,0,0,0,0
