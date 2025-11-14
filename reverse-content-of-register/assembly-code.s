  AREA asm_are, CODE, READONLY
  EXPORT sample
	  
  ; we are copying the right most bits to the left one by one in R2 (reversed)
sample
  LDR R0, =0x00000020 ; counter = 32
  LDR R1, =0x11110001 ; loaded 32-bit provided data
  LDR R2, =0x00000000 ; initialized reversed value

loop
  CMP R0, #0          ; counter = 0?
  BEQ reversalCompleted
  LSLS R2, #1         ; R2 <- R2 << 1
  LSRS R1, #1         ; R1 <- R1 >> 1
  BCC carryFlagNotZero
  ADDS R2, R2, #1     ; R2 <- R2 + 1
  
carryFlagNotZero
  SUBS R0, R0, #1     ; R0 <- R0 - 1
  B loop
  
reversalCompleted
  B reversalCompleted
  END
  ; Exected value of R2 = 0x80008888