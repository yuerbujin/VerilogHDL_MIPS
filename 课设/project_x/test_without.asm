test_addi:
add $s1,$0,0
add $s2,$0,0
add $s0,$0,100
addi $s3,$1,-100
nop
nop

test_addiu:
addiu $s4,$s0,-1000
nop
nop

test_andi:
andi $s5,$s0,1010
nop
nop

test_ori:
ori $s1,$s2,100
nop
nop

test_xori:
xori $s5,$s2,100
nop
nop

test_sltiu:
sltiu $s4,$s5,100
nop
nop

test_add:
add $s1,$s2,$s3
nop
nop

test_addu:
add $s1,$s1,$s2
nop
nop

test_sub:
sub $s1,$s2,$s3
nop
nop

test_subu:
subu $s3,$s2,$s2
nop
nop

test_and:
and $s4,$s5,$s2
nop
nop

test_or:
or $s2,$s3,$s1
nop
nop

test_nor:
nor $s2,$s3,$s4
nop
nop

test_xor:
xor $s4,$s3,$s2
nop
nop

test_slt:
slt $s0,$s2,$s3
nop
nop

test_sltu:
sltu $s1,$s3,$s5
nop
nop


save_test_result:
add $s6,$0,100
sw $s0,($s6)
sw $s1,4($s6)
sw $s2,8($s6)
sw $s3,12($s6)
sw $s4,16($s6)
sw $s5,20($s6)

addi 	$t0, $0, 0xffffffff

addi	$t1,$0,	0
nop
nop
sw	$t0,($t1)
nop
nop	
addi	$t1,$t1,4
nop
nop
sh	$t0,($t1)
nop
nop
addi	$t1,$t1,4
nop
nop
sb	$t0,($t1)
nop
nop
lw	$t2,($0)
nop
nop
addi	$t1,$t1,4
nop
nop
sw	$t2,($t1)		
nop
nop
lh	$t2,($0)
nop
nop
addi	$t1,$t1,4
nop
nop
sw	$t2,($t1)	
nop
nop	

lhu	$t2,($0)
nop
nop
addi	$t1,$t1,4
nop
nop
sw	$t2,($t1)	
nop
nop
lb	$t2,($0)
nop
nop
addi $t1,$t1,4
nop
nop
sw	$t2,($t1)		
nop
nop
lbu	$t2,($0)
nop
nop
addi	$t1,$t1,4
nop
nop
sw	$t2,($t1)	
nop
nop
lui	$t3,0xffff
nop
nop
addi	$t1,$t1,4
nop
nop
sw	$t2,($t1)	
nop
nop
sll	$t3,$t3,2
nop
nop
addi	$t1,$t1,4
nop
nop
sw	$t3,($t1)	
nop
nop
sra	$t3,$t3,2
nop
nop
addi	$t1,$t1,4
nop
nop
sw	$t3,($t1)	
nop
nop
srl	$t3,$t3,2
nop
nop
test_j:
addi    $t2,$0,60
nop
nop
addi	$t2,$t2,60
nop
nop
beq     $t2,120,test_beq
nop
nop
bne     $t2,180,test_j
nop
nop
sw	$t3,($t1)
nop
nop

test_beq:
jal test_jal
nop
nop
j end
nop
nop
test_jal:
jr $ra
nop
nop
end:
nop


