/* SCEI CONFIDENTIAL
 "PlayStation 2" Programmer Tool Runtime Library  Release 2.0
 */
/* 
 *                  I/O Proseccor sample program
 *                          Version 1.20
 *                           Shift-JIS
 *
 *      Copyright (C) 1998-1999 Sony Computer Entertainment Inc.
 *                        All Rights Reserved.
 *
 *                       ezbgm.irx - bgm_r2s.c
 *                          raw to spu pcm
 *
 *   Version   Date            Design    Log
 *  --------------------------------------------------------------------
 *   1.20      Nov.23.1999     morita    modify for EzBGM
 *   0.01      Nov.18.1999     ishii     optimize for IOP
 */

#include <cpureg.h>

#define src  a0
#define dst  a1
#define blk  a2
#define cnt  a3

	.globl	_BgmRaw2Spu
	.ent	_BgmRaw2Spu
_BgmRaw2Spu:
	subu	sp, (8*4)
	sw	s0, 0*4(sp)	; 	sw	s1, 1*4(sp)
	sw	s2, 2*4(sp)	; 	sw	s3, 3*4(sp)
	sw	s4, 4*4(sp)	; 	sw	s5, 5*4(sp)
	sw	s6, 6*4(sp)	; 	sw	s7, 7*4(sp)
	move	v0, zero
	move	v1, zero
	addi	cnt,zero, 256

					.set noreorder
	/* ��������A��Ŗ��߂̂Ȃ�т𐧌�B */
pcm_separate_loop:
	lw	t0, 0*4(src)	/* 1 + 4 clock */
	lw	t1, 1*4(src)	/* 1 + 2 clock */

	/* 7 clock */
	and	s0, t0, 0xffff		/* t0 �̉��ʂ� s0 �� */
	srl	s1, t0, 16		/* t0 �̏�ʂ� s1 �� */
	sll	t0, t1, 16		/* t1 �̉��ʂ���ɃV�t�g�� s0 �� */
	or	s0, t0
	srl	t1, t1, 16		/* t1 �̏�ʂ��}�X�N���� s1 �� */
	sll	t1, t1, 16
	or	s1, t1

	/* ���ɃL���b�V���ɓǂݍ��܂�Ă���͂� */
	lw	t2, 2*4(src)	/* 1 clock */
	lw	t3, 3*4(src)	/* 1 clock */
	/* ���̃L���b�V�����C����ǂݍ��ނ������������ */
	lw	t4, 4*4(src)	/* 1 + 4 clock */

	/* 7 clock */
	and	s2, t2, 0xffff		/* t2 �̉��ʂ� s2 �� */
	srl	s3, t2, 16		/* t2 �̏�ʂ� s3 �� */
	sll	t2, t3, 16		/* t3 �̉��ʂ���ɃV�t�g�� s2 �� */
	or	s2, t2
	srl	t3, t3, 16		/* t3 �̏�ʂ��}�X�N���� s3 �� */
	sll	t3, t3, 16
	or	s3, t3

	/* ���ɃL���b�V���ɓǂݍ��܂�Ă���͂� */
	lw	t5, 5*4(src)	/* 1 clock */
	lw	t6, 6*4(src)	/* 1 clock */
	lw	t7, 7*4(src)	/* 1 clock */
	add	src, 8*4	/* 1 clock */

	/* 7 clock */
	and	s4, t4, 0xffff		/* t4 �̉��ʂ� s4 �� */
	srl	s5, t4, 16		/* t4 �̏�ʂ� s5 �� */
	sll	t4, t5, 16		/* t5 �̉��ʂ���ɃV�t�g�� s4 �� */
	or	s4, t4
	srl	t5, t5, 16		/* t5 �̏�ʂ��}�X�N���� s5 �� */
	sll	t5, t5, 16
	or	s5, t5

	/* store  dst1(s0, s2),  dst2(s1, s3) */
	/* 4 clock */

	sw	s0, 0*4(dst)	;	sw	s2, 1*4(dst)
	sw	s1, (0*4+512)(dst); 	sw	s3, (1*4+512)(dst)
	/* �ȉ��ƕ��s���� +2, 4+2 clock �ŏ������܂��͂� */

	/* 7 clock */
	and	s6, t6, 0xffff		/* t6 �̉��ʂ� s6 �� */
	srl	s7, t6, 16		/* t6 �̏�ʂ� s7 �� */
	sll	t6, t7, 16		/* t7 �̉��ʂ���ɃV�t�g�� s6 �� */
	or	s6, t6
	srl	t7, t7, 16		/* t7 �̏�ʂ��}�X�N���� s7 �� */
	sll	t7, t7, 16
	or	s7, t7

	/* store  dst1(s4, s6),  dst2(s5, s7) */
	/* 4 clock */
	sw	s4, 2*4(dst)	; 	sw	s6, 3*4(dst)
	sw	s5, (2*4+512)(dst)	; 	sw	s7, (3*4+512)(dst)
	/* �ȉ��ƕ��s���� +2, 4+2 clock �ŏ������܂��͂� */

	add	dst, 4*4		/* 1 clock */


	/* �����܂ŁA��Ŗ��߂̂Ȃ�т𐧌�B */
					.set reorder

	add	v0, 8			/* 1 clock */
	blt	v0, cnt, pcm_separate_loop	/* 1 clock */

	add	dst, 512
	move	v0, zero

	add	v1, 1
	blt	v1, blk, pcm_separate_loop

	lw	s0, 0*4(sp)	; 	lw	s1, 1*4(sp)
	lw	s2, 2*4(sp)	; 	lw	s3, 3*4(sp)
	lw	s4, 4*4(sp)	; 	lw	s5, 5*4(sp)
	lw	s6, 6*4(sp)	; 	lw	s7, 7*4(sp)
	addu	sp, (8*4)
	j	ra
	.end	_BgmRaw2Spu

