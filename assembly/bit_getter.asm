// Program that extracts a single bit from a binary number. Used inside the main assembly file.

// Operand of bit extraction
mov r3, #234

// Output
mov r6, #0
// Bit to be extracted
mov r4, #7

// Bit mask for AND operation
mov r5, #1
lsl r5, r5, r4
and r6, r3, r5
lsr r6, r6, r4
out r6, 4