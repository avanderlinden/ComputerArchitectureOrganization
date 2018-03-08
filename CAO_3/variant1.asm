
#main:
#	ori $a0, $zero, 3
#	jal func1
#	addi $t0, $v0, 1
#	j end


#func1:
#	addi $v0, $a0, 1
#	jr $ra
#
	
#end:


		.text
		j	main			# Jump to main-routine

		.data
str1:		.asciiz "Insert the array size \n"
str2:		.asciiz "Insert the array elements,one per line  \n"
str3:		.asciiz "The sorted array is : \n"
str5:		.asciiz "\n"

		.text
		.globl	main
main: 
		la	$a0, str1		# Print of str1
		li	$v0, 4			#
		syscall				#

		li	$v0, 5			# Get the array size(n) and
		syscall				# and put it in $v0
		move	$s2, $v0		# $s2=n
		sll	$s0, $v0, 2		# $s0=n*4
		sub	$sp, $sp, $s0		# This instruction creates a stack
						# frame large enough to contain
						# the array
		la	$a0, str2		#
		li	$v0, 4			# Print of str2
		syscall				#
            
		move	$s1, $zero		# i=0
for_get:	bge	$s1, $s2, exit_get	# if i>=n go to exit_for_get
		sll	$t0, $s1, 2		# $t0=i*4
		add	$t1, $t0, $sp		# $t1=$sp+i*4
		li	$v0, 5			# Get one element of the array
		syscall				#
		sw	$v0, 0($t1)		# The element is stored
						# at the address $t1
		la	$a0, str5
		li	$v0, 4
		syscall
		addi	$s1, $s1, 1		# i=i+1
		j	for_get
exit_get:	move	$a0, $sp		# $a0=base address af the array
		move	$a1, $s2		# $a1=size of the array
		jal	isort			# isort(a,n)
						# In this moment the array has been 
						# sorted and is in the stack frame 
		la	$a0, str3		# Print of str3
		li	$v0, 4
		syscall

print:		move	$s1, $zero		# i=0
for_print:	bge	$s1, $s2, exit_print	# if i>=n go to exit_print
		sll	$t0, $s1, 2		# $t0=i*4
		add	$t1, $s3, $t0		# $t1=address of a[i]
		lw	$a0, 0($t1)		#
		li	$v0, 1			# print of the element a[i]
		syscall				#

		la	$a0, str5
		li	$v0, 4
		syscall
		addi	$s1, $s1, 1		# i=i+1
		j	for_print
exit_print:	add	$sp, $sp, $s0		# elimination of the stack frame 
                jr $ra
                
                
                

		
isort:				
		move $s3, $a0
		
		jal  print
		
		la	$a0, str5 		# print \n
		li	$v0, 4
		syscall
		
		#move $t0, $s3
		#jal  print
		

		
		#move $s4, $a1
		move $t8, $zero			# i=0
for_sort:	bge $t8, $a1, _for_sort		# if i > array length ($a1)
		
		move $a0, $s3
		move $a2, $t8
		jal idx_min
		
		move $a3, $v0			# a3 = mini
		move $a2, $t8			# a2 = i
		move $a0, $s3			# a0 = v[0]
		jal swap
		
		jal print
		
		la	$a0, str5 		# print \n
		li	$v0, 4
		syscall
		
		addi $t8, $t8, 1		# i++
		j for_sort
_for_sort:	
		move $a0, $s3
		jal  print

		li	$v0, 10			# EXIT
		syscall				#

swap:		
		sll $t0, $a2, 2
		sll $t1, $a3, 2
		
		add $t0, $t0, $a0
		add $t1, $t1, $a0
		
		
		lw $t2, 0($t0)
		lw $t3, 0($t1)
		
		sw $t3, 0($t0)
		sw $t2, 0($t1)
		
		jr $ra


idx_min:	subi $t9, $a1, 1 	# last=length-1
		move $s5, $a2		#mini = first
		
		sll $t6, $s5, 2
		add $t6, $t6, $a0
		lw $s6, 0($t6)		# min = v[first]
		
		
		addi $t4, $s5, 1	# i = first+1
idx_for:	bge $t4, $t9, _idx_min  # if i > last then stop
		
		sll $t7, $t4, 2		
		add $t7, $t7, $a0	# get v[i]
		lw $s7, 0($t7)		
		
		addi $t4, $t4, 1	# i++
		
		bge $s7, $s6, idx_for	# if ( v[i] >= min ); continue
		
		move $s5, $t4		# mini = i
		move $s6, $s7		# min = v[i]
		
		j idx_for
		
_idx_min:
		move $v0, $s5		# return mini
		jr $ra
