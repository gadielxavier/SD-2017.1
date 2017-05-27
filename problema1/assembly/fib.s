.text
	movia r17, resultado  	#move registrador para a memoria
	addi r8, r0, 8 		#QUANTIDADE DE NUMEROS NA SEQUENCIA DE FIB
	addi r9, r0, 0 		#Contador
	addi r10, r0, 1		#Numero
	addi r12, r0, 0		#num anterior
	addi r13, r0, 0		#resultado
		
FIB:
		
	stw r10, 0(r17)		#salva na memoria
	addi r17, r17, 1	#atualiza r17
	
	mov r13, r10 #atualiza resultado
	add r10, r10, r12 #atualiza numero
	mov r12, r13 #atualiza num anterior
	addi r9, r9, 1 #atualiza contador
	
	bne r9, r8, FIB
			
			
ACABOU:
	beq ra, r0, FIM #evita erro de memoria invalida
	ldw ra, (sp)
	ldw r16, 4(sp)
	addi sp, sp, 8
	
	
	jmp ra
			
FIM:

.data
resultado:
.word 0,0,0,0,0,0,0,0
			
.end
