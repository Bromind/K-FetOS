.section .text
.globl enableMMU

@ Assuming TTB0 (processes) is in r0
@ and TTB1 (OS & IO) is in r1

enableMMU:
	push {r2}
	@ Invalidate Instruction cache
	mov	r2, #0
	mcr	p15, 0, r2, c7, c5, 0

	@ Clean and Invalidate Entire Data cache
	mcr	p15, 0, r2, c7, c14, 0

	@ invalidate Instruction & Data TLBs
	mcr	p15, 0, r2, c8, c5, 0

	@ Format r2
	sll	r2, r2, 14 @
	
	@TODO : Finish enabling MMU

	@return
	pop {r2}
	mov pc, lr

.globl disableMMU
	push {r0}

	@Invalidate Instruction cache
	mov r0, #0
	sub r0, r0, #1 @ r0 : 0xFFFF FFFF
	bic r0, r0, #5 @ r0 : 0xFFFF FFFF AND (NOT 0x0000 0005) : 0xFFFF FFFA

	push {r1}
	mrc p15, 0, r1, c1, c0, 0	@load
	and r1, r1, r0			@mask
	mcr p15, 0, r1, c1, c0, 0	@store
	
	pop {r1}
	pop {r0}
	mov pc, lr
