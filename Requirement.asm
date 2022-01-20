.data

	ind: .long 0
	n: .long 0
	n_static: .long 0
	m: .long 0
	lungime_totala: .long 0
	v: .space 400
	st: .space 400
	sir: .space 1000
	
	zero: .long 0
	minusunu: .long -1
	
	backind: .long 0
	i: .long 1
	backkk: .long 0
	ultim: .long 0
	nr: .long 0
	
	
	resi: .space 10
	res: .space 10
	chDelim: .asciz " "
	formatScanf: .asciz "%300[^\n]"
	formatPrintf: .asciz "%d "
	
	newLine: .asciz "\n"
	
	
	
.text






afisare:


	xor %eax, %eax
	xor %ecx, %ecx
	xor %ebx, %ebx
		
	
				# aici incep clasica functiilor
	pushl %ebp
	movl %esp, %ebp
				# aici termin clasica functiilor

	
	

	
	# in lungime_totala am ce mi trb de comparat
	
	xor %ecx, %ecx
	
	xor %eax, %eax
	
	jmp et_afis1
	


et_afis1:
	
	cmp %ecx, lungime_totala
	je sfarsit22
	
	
	xor %eax, %eax
	movl (%esi, %ecx, 4), %eax
	
	pushl %ecx
	
	pushl %eax
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	
	popl %ecx
	
	inc %ecx
	jmp et_afis1


sfarsit22:
	
	xor %eax, %eax

	popl %ebp
	jmp exit








verificare:


				# aici incep clasica functiilor
	pushl %ebp
	movl %esp, %ebp
				# aici termin clasica functiilor
	
	pushl %ebx
	
	pushl minusunu     # initializare ultim=-1
	pushl zero         # initializare nr=0
	
	xor %ecx, %ecx
	
	movl 8(%ebp), %edx
	movl (%esi, %edx, 4), %ebx   # initializare %ebx= v[k]
	
for_verificare:
	
	cmp 8(%ebp), %ecx
	je final_for_verificare
	 
	 movl (%esi, %ecx, 4), %eax
	 
	 cmp %eax, %ebx
	 jne contor_for_verificare
	 
	 incl -12(%ebp)
	 movl %ecx, -8(%ebp)
	 
	 


contor_for_verificare:

	incl %ecx
	jmp for_verificare


final_for_verificare:

	cmpl $-1, -8(%ebp)
	je ret1
	
	cmpl $2, -12(%ebp)
	jg ret0
	
	
	 subl -8(%ebp), %edx     
	 cmp m, %edx
	 jle ret0
	
	jmp ret1
	
	

ret1:	
	
	popl %ebx
	popl %ebx	
	
	popl %ebx
	
	xor %eax, %eax
	movl $1, %eax
	
	popl %ebp
	ret
	
ret0:


	popl %ebx
	popl %ebx

	popl %ebx
	
	xor %eax, %eax
	movl zero, %eax
	
	popl %ebp
	ret
	
	
	








backtracking:

	pushl %ebp
	movl %esp, %ebp
	
	pushl %ebx
	
	movl 8(%ebp), %ebx
	
	cmp lungime_totala, %ebx
	je afisare_back1
	

	movl (%edi, %ebx, 4), %ecx   # il avem pe v[k] in %ecx
	
	cmp zero, %ecx
	jne ifback1
	
	
	
	xor %ecx, %ecx
	incl %ecx
	
	
	jmp for_back
	
for_back:
	
	cmp n, %ecx
	jg final_back
	
	movl 8(%ebp), %eax
	
	movl %ecx, (%esi, %eax, 4)    # st[k]=i
	
	pushl %ecx
	pushl %edx
	
	
	pushl %ebx
	call verificare
	popl %edx
	
	popl %edx
	popl %ecx
	
	
	cmp zero, %eax
	je contor_for_back
	
	
	pushl %eax
	pushl %ecx
	pushl %edx
	
	movl %ebx, %eax
	inc %eax
	
	
	pushl %eax
	call backtracking
	popl %eax

	
	popl %edx
	popl %ecx
	popl %eax
	
	jmp contor_for_back



contor_for_back:

	incl %ecx
	jmp for_back

	
final_back:
	
	popl %ebx
	
	popl %ebp
	ret
	



afisare_back1:

	call afisare




ifback1:


	movl %ecx, (%esi, %ebx, 4)   #   am facut st[k]=v[k]
	
	
	pushl %ecx
	pushl %edx
	
	
	pushl %ebx
	call verificare
	popl %edx
	
	popl %edx
	popl %ecx
	
	# in %eax am rezultatul
	
	cmp zero, %eax
	je final_back
	
	
	pushl %eax
	pushl %ecx
	pushl %edx
	
	movl %ebx, %eax
	inc %eax
	
	
	pushl %eax
	call backtracking
	popl %eax

	
	popl %edx
	popl %ecx
	popl %eax




	jmp final_back





.global main

main:


	pushl $sir
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	
	xor %eax, %eax

	pushl $chDelim
	pushl $sir
	call strtok 
	popl %ebx
	popl %ebx
	
	movl  %eax, res	
	
	pushl res
	call atoi
	popl %ebx
	
	xor %ebx, %ebx
	
	movl %eax, resi
	
	xor %eax, %eax
	movl resi, %eax
	movl %eax, n
	
	
	movl $0 , resi
	
	xor %eax, %eax
	
	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx
	
	
	
	movl  %eax, res	
	
	pushl res
	call atoi
	popl %ebx
	
	xor %ebx, %ebx
	
	movl %eax, resi
	
	xor %eax, %eax
	movl resi, %eax
	movl %eax, m
	
	movl $0, resi
	
	
	xor %ecx, %ecx
	xor %edi, %edi
	
	movl $v, %edi
	movl $st, %esi
	
	jmp et_for_citire


	
et_for_citire:

		
	xor %eax, %eax
	xor %ebx, %ebx
	xor %edx, %edx
	
	
	movl $0, ind
	movl %ecx, ind    # salvez indicele din %ecx
	
	
	pushl $chDelim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx 
	
	cmp $0, %eax
	je continui
	
	
	
	
	movl %eax , res
	
	
	pushl res
	call atoi
	popl %ebx
	xor %ebx, %ebx
	
	
	
	movl ind, %ecx
	
	movl %eax, (%edi, %ecx, 4)
	
	
	
	incl %ecx
	jmp et_for_citire
	
	



continui:

	movl %ecx, lungime_totala
	
	
	pushl %edi
	pushl %esi
	
	#  call backtracking
	
	pushl zero
	call backtracking
	popl %ebx


	#  cazul -1
	
	popl %esi
	popl %edi
	
	pushl minusunu
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx

	
exit:

	
	# push $0
	# call fflush
	# pop %ebx

	popl %esi
	popl %edi

	xor %eax, %eax
	xor %ebx, %ebx
	


	pushl $newLine
	call printf
	popl %ebx
	


	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
	