  AREA asm_area, CODE, READONLY
  EXPORT sample
	  
sample
  ; Loading the registers
  LDR R0, =0x0
  LDR R1, =0x0
  LDR R4, =0x0
  LDR R5, =0x00000008
  LDR R6, =0x80000000
  LDR R2, =sign32

loop
  LDR R3, [R2]
  TST R3, R6   ; checking the MSB
  BPL PVE
  MVNS R3, R3  ; 1's complement
  ADDS R0, R3
  ADCS R1, R4

PVE
  ADDS R2, #4  ; update the memory pointer
  SUBS R5, #1  ; decrement the counter
  CMP R5, #0
  BEQ done
  B loop
done
  B done
  
  AREA Data1, DATA, READWRITE ; data section begins
sign32
  DCD 0xFFFFFFFE, 0xFFFFFFFD, 0xFFFFFFFC, 0xFFFFFFFB, 0xFFFFFFFA, 0xFFFFFFF9, 0xFFFFFFF8, 0xFFFFFFF7   ; specified 32-bit constants
  
  END