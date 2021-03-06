# ARM Assembly: Image Renderer

This is a program which converts image data into a binary form which can then be processed by an ARM32 Assembly program, interpretable via the virtual machine on [Peter Higginson's simulator](http://peterhigginson.co.uk/AQA/).

## Usage
The program can be used either on the command line:
`python image_converter.py [image_file_path].[extension] <output-filename (optional)>`
...or, if no command line argument is supplied:
`python image_converter.py`, the user is prompted for a filepath.
The output of the program is a file output to the `output` directory, whose name can be specified on the command line
or, as with the input image, through user input at runtime.

## Dependencies
The program depends on `PIL` (installation: `pip install Pillow`) to process the images. Furthermore, any user who has the `pyperclip` clipboard module may also benefit from having the program copied directly to the clipboard.

## Gallery
### Utah teapot
![Utah teapot](assets/utah_teapot.png "Teapot rendered in the virtual machine")

### Reimu holding the apple
![Bad Apple!! frame](assets/bad_apple.png "Opening frame from Bad Apple!! in the virtual machine")

## Example program
Note: the only part that changes for each program is the `img_data` portion at the bottom of the file.
The remainder of the assembly is able to render any such image data once it's placed in that section.
This program is the example file in [examples/teapot.asm](examples/teapot.asm).
```
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
```