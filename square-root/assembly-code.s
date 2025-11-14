  AREA asm_area, CODE, READONLY
  EXPORT sample
	  
sample
  LDR R0, =0x00000384 ; given square
  LDR R2, =0x00008000 ; setting mask
  LDR R3, =0xFFFF7FFF ; clearing mask
  LDR R1, =0x00008000 ; assumed square root
  MOV R4, R1
  MULS R4, R1, R4     ; square of assumed square root
 
loop 
  CMP R4, R0
  BLE notGreater
  ; if R4 is greater than we need to clear the bit that made it greater
  ANDS R1, R1, R3     ; R1 <- R1 & R3, clearing just set bit
  
notGreater
  LSRS R2, #1         ; right shift setting mask
  LSRS R3, #1         ; right shift clearing mask
  
  CMP R2, #0
  BEQ traversedThroughoutAllBits
  
  ORRS R1, R1, R2     ; R1 <- R1 | R2, setting the next bit
  MOV R4, R1
  MULS R4, R1, R4     ; recalculating square of current square root
  B loop
  
traversedThroughoutAllBits
  B traversedThroughoutAllBits
  END
	  