  AREA asm_area, CODE, READONLY
  EXPORT sample
	  
sample
pass
  LDR R3, =array     ; reset data pointer
  LDR R2, =7         ; reset pair counter  
  LDR R1, =0         ; clear swapped flag

compare
  LDR R5, [R3]       ; current element
  LDR R6, [R3, #4]   ; next ele ment
  CMP R5, R6
  BLE no_swap
  STR R6, [R3]       ; swap
  STR R5, [R3, #4]
  LDR R1, =1         ; set swapped flag
no_swap
  ADDS R3, #4        ; Advance array pointer
  SUBS R2, #1
  BNE compare        ; Continue inner loop
  CMP R1, #0         ; check swapped flag
  BHI pass           ; Next bubble sort pass

sorted
  B sorted
  
  AREA data_area, DATA, READWRITE
array
  DCD 0x6, 0x1, 0x5, 0x8, 0x3, 0x4, 0x2, 0x7
	  
  END