  AREA asm_area, CODE, READONLY
  EXPORT sample
	  
sample
  LDR R0, =0x00005432 ; load 16-bit packed BCD digits
  LDR R2, =0x0000000F ; mask for BCD0
  ANDS R2, R0         ; R2 contains BCD0
  LDR R3, =0x000000F0 ; mask for BCD1
  ANDS R3, R0         ; R3 contains BCD1
  LDR R4, =0x00000F00 ; mask for BCD2
  ANDS R4, R0         ; R4 contains BCD2
  LDR R5, =0x0000F000 ; mask for BCD3
  ANDS R5, R0         ; R5 contains BCD3
  
  LDR R6, =0x00000001 ; 1
  MULS R2, R6, R2     ; BCD0 * 1
  LDR R6, =0x0000000A ; 10
  MULS R3, R6, R3     
  LSRS R3, #4         ; R3 <- BCD1 * 10
  LDR R6, =0x00000064 ; 100
  MULS R4, R6, R4     
  LSRS R4, #8         ; R4 <- BCD2 * 100
  LDR R6, =0x000003E8 ; 1000
  MULS R5, R6, R5     
  LSRS R5, #12        ; R5 <- BCD3 * 1000
  
  MOV R1, R2          ; BCD0 * 1
  ADDS R1, R1, R3     ; BCD0 * 1 + BCD1 * 10
  ADDS R1, R4, R1     ; BCD0 * 1 + BCD1 * 10 + BCD2 * 100
  ADDS R1, R1, R5     ; BCD0 * 1 + BCD1 * 10 + BCD2 * 100 + BCD3 * 1000
  
jobDone
  B jobDone
  
  END