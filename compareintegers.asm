.data
	ARR1: .word 2,8,3,9,3,1,4,0,9,2,5,6,8,2,3,6,4,8,4,5,0,9,7,1,3,7,3,6,8,2   #Array 1 elements
	ARR2: .word 7,2,7,4,8,2,6,3,5,8,0,1,2,7,5,3,9,5,3,8,5,0,4,3,7,5,2,8,9,1   #Array 2 elements
	ARR3: .space 120                                                          #Creating int Array3[30]
	size:  .word 30
	arrmsg: .asciiz "ARR3 elements: " 
.text
	.globl main

main:	
        la $t1, ARR1   #Loading ARR1 address to $t1
        la $t2, ARR2   #Loading ARR2 address to $t2
        la $t3, ARR3   #Loading ARR3 address to $t3
        
        li $s0, 0        #counter = 0
        lw $s1, size 	 #size = 30
        
        li $v0, 4        #Printing arrmsg
        la $a0, arrmsg
        syscall      
        
loop:
	bge $s0, $s1, reset     #If counter equals to or bigger than 30 go to reset function
	
	lw $t5, 0($t1)          #Loading ARR1[counter] to $t5
	lw $t6, 0($t2)          #Loading ARR2[counter] to $t6
	
	slt $t0, $t5, $t6       #Comparing the integers with set less than method
	bne $t0, 0, chngindices #If the ARR1[counter] value is smaller then ARR2[counter] value go to changeindices function
	move $t6, $t5           #If it's not, move the values
	
	sw $t6, 0($t3)          #Store the changed (bigger) value in ARR3[counter]

chngindices:
	sw $t6, 0($t3)		#If ARR1[counter] value is smaller than ARR2[counter] value, store the ARR2 value to ARR3
	addi $t1, $t1, 4	#Passing to the next indice in ARR1
	addi $t2, $t2, 4	#Passing to the next indice in ARR2
	addi $t3, $t3, 4	#Passing to the next indice in ARR3
	addi $s0, $s0, 1	#counter += 1
	j loop 			#Return to loop function
	
reset:							
	li $s0, 0		#Setting counter to 0 for use it in printing
	la $t3, ARR3		#DIZI3'ü yazdýrma iþleminde kullanmak için sýfýrlama
	j print			#Go to print function

print:							
	bge $s0, $s1, finish    #If counter reaches 30, go to finish function
	
	lw $s2, 0($t3)		#Loading ARR3[counter] to $s2

	li $v0, 1	        #Printing $s2
	move $a0, $s2					
	syscall						
	
	li $a0, 32		#Adding space between printed values
	li $v0, 11					
	syscall						

	addi $t3, $t3, 4        #Passing to the next indice in ARR3
	addi $s0, $s0, 1        #counter += 1

	j print	        	#Return to same function again until counter reaches 30
	
finish:
	li $v0, 10		#return 0
	syscall						
	
	
        
        
        
     
