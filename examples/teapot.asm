// Run at: https://peterhigginson.co.uk/AQA/
// r12 marks the pointer to the image data in memory
mov r12, #img_data

// r11 is the current position in VRAM which is being written to
mov r11, #256

// r0 signifies the row of pixels (item of image data in the img_data section) which is being drawn
mov r0, #0

loop:
    mov r1, r12
    add r1, r1, r0
    // Get the image data of the current row, r0, storing into r2
    ldr r2, [r1]
    add r0, r0, #1
    cmp r0, #24
    bgt exit

    // Begin extracting each pixel (bit)
    mov r3, #31
pixels:
    // Now extracting nth bit:
    // Operand of bit extraction is r2
    // Output register is r7
    mov r7, #0
    // Bit to be extracted is r3

    // Bit mask for AND operation
    mov r6, #1
    lsl r6, r6, r3
    and r7, r2, r6
    lsr r7, r7, r3

    cmp r7, #1
    bne blank_pixel
    str r7, [r11]

blank_pixel:
    // Update the pixel of VRAM being drawn to to the next pixel
    add r11, r11, #1

    // Move onto next pixel in the row
    cmp r3, #0
    sub r3, r3, #1
    bgt pixels

    b loop

exit:
    halt

img_data:
	dat 0
	dat 0
	dat 0
	dat 245760
	dat 114688
	dat 245760
	dat 2096664
	dat 8388412
	dat 536870712
	dat 285212656
	dat 276824048
	dat 276824048
	dat 419430368
	dat 218103776
	dat 117440480
	dat 67108832
	dat 67108736
	dat 16777088
	dat 8388480
	dat 8388352
	dat 4193792
	dat 2095104
	dat 16384
	dat 0