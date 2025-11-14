  AREA asm_area, CODE, READONLY ; logical organisation. Each AREA is a section, and the linker can place them into memory regions defined in the scatter file / linker script.
  
  ; minuend - subtrahend = difference
  EXPORT sample
sample
  LDR R0, =0xA3D5C912 ; LSB of subtrahend
  LDR R1, =0xFE98CA12 ; MSB of subtrahend
  LDR R2, =0xA540B12A ; LSB of minuend
  LDR R3, =0xA4856C12 ; MSB of minuend
  
  LDR R4, =0x0        ; clearing a register for addition operation
  
  SUBS R6, R2, R0     ; difference LSB = minuend LSB - subtrahend LSB, updating flags
  SBCS R3, R3, R1     ; difference MSB = minuend MSB - subtrahend MSB - borrow, updating flags
  
  MOV R7, R3          ; difference MSB
  
  BCS Label           ; C = 1? it effectively checks no borrow
                      ;BMI can also be used
  
  ; from now the borrow is taken.
  MVNS R6, R6         ; ~difference LSB
  MVNS R7, R7         ; ~difference MSB
  ADDS R6, #1         ; 2's complement of difference LSB
  ADCS R7, R4
  
Label
  B Label
  END