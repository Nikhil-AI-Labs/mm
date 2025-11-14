  AREA asm_area, CODE, READONLY
  EXPORT sample
	  
sample
  LDR R0, =0xA3D5C921  ; LSB part of 64-bit data
  LDR R1, =0xFE98CA21  ; MSB part of 64-bit data
  
  MVNS R6, R0          ; 1's complement of LSB part
  MVNS R7, R1          ; 1's complement of MSB part
  
  ADDS R6, R6, #1      ; 2's complement of LSB part
  BCC jobDone
  ADDS R7, R7, #1      ; increment only if carry set

jobDone
  B jobDone
  
  END