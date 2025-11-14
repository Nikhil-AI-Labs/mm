  AREA asm_area, CODE, READONLY
  EXPORT sample
	  
sample
  LDR R0, =0x11010011 ; given 32-bit data
  LDR R3, =0x0        ; will serve as counter
  LDR R1, =0x0        ; trackks number of 1's
  
loop
  CMP R3, #32         ; counter == 32?
  BEQ onesCounted
  LSRS R0, #1         ; R0 <- R0 >> 1
  BCC notOne
  ADDS R1, R1, #1     ; R3 <- R3 + 1

notOne
  ADDS R3, R3, #1     ; R1 <- R1 + 1
  B loop
  
onesCounted
  LDR R2, =0x0        ; by default assume odd number of ones
  MOV R4, R1          ; count number of 1's
  LSRS R4, #1         ; R3 <- R3 >> 1 ; to manipulate carry flag C = 1 will indicate odd.
  
  BCS oddOnesPresent  ; branch if even no. of ones present
  LDR R2, =0xFF00FF00 ; the number of ones is even
  
oddOnesPresent
  B oddOnesPresent
  END