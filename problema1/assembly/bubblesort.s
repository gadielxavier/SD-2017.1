.data
vetor: .word 9,5,4,3,6,7,8,1,2
size: .word 9

.text

main:
	
	movia r20, vetor	#r20 recebe endereço da memoria
	ldw r9, 0(r20)		#r9 recebe conteudo da memoria
	
	addi r10, r0, 0		#contador do primeiro FOR
	addi r14, r0, 0		#contador segundo FOR
	movia r11, size		#r11 recebe endereço da memoria
	ldw r12, 0(r11) 	#r12 recebe tamanho do vetor
	subi r13, r12, 1	#recebe penultima posicao do vetor
	
	FOR:
	beq r10, r13, SAIFOR 	#if (r10 == r12) SAIFOR
	addi r14, r0, 0
	movia r20, vetor
	
	
	
	SEGFOR:
	beq r14, r13 ,SAISECFOR
	
	#corpo segundo for	
	ldb r15, 0(r20) 	#pega o primeiro valor do array
	addi r20,r20,4		#pula para o próximo valor do array
	ldb r16, 0(r20)		#pega o segundo valor do array
	
	bgtu r15,r16, SWAPP
	addi r14, r14,1
	beq r0,r0, SEGFOR
	
	
	SAISECFOR:
	addi r10, r10, 1
	beq r0,r0, FOR
	
	
	
	SWAPP:
	stw r15, 0(r20)
	subi r20,r20,4
	stw r16, 0(r20)
	addi r20, r20,4
	addi r14, r14, 1
	
	beq r0,r0, SEGFOR

	SAIFOR:


