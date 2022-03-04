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
    cmp r0, #23
    bgt exit

    // Begin extracting each pixel (bit)
    mov r3, #32
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
    //out r7, 4

    cmp r7, #1
    bne blank_pixel
    str r7, [r11]

blank_pixel:
    // Update the pixel of VRAM being drawn to to the next pixel
    add r11, r11, #1

    // Move onto next pixel in the row
    sub r3, r3, #1
    cmp r3, #0
    bne pixels

    b loop

exit:
    halt

img_data:	DAT 0
	DAT 0
	DAT 0
	DAT 122880
	DAT 57344
	DAT 122880
	DAT 1048332
	DAT 4194206
	DAT 268435356
	DAT 142606328
	DAT 138412024
	DAT 138412024
	DAT 209715184
	DAT 109051888
	DAT 58720240
	DAT 33554416
	DAT 33554368
	DAT 8388544
	DAT 4194240
	DAT 4194176
	DAT 2096896
	DAT 1047552
	DAT 8192
	DAT 0