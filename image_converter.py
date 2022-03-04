import time
import sys
import os
import logging
from PIL import Image

# If pyperclip is available, the user can also get the program output on their clipboard.
try:
    import pyperclip
    PYPERCLIP = True
except ImportError:
    PYPERCLIP = False

try:
    image_name = sys.argv[1]
except IndexError:
    image_name = input("Please input an image name: ")

try:
    img: Image.Image = Image.open(image_name).resize((32, 24), Image.NEAREST)
    img.convert("RGBA")
except FileNotFoundError:
    logging.error(f"Desired input file {image_name} was not found. Please try a different image.")
    sys.exit(1)

def color_value(pixel):
    return 1 if (sum(pixel) / len(pixel)) > 127 else 0

out = []
for row in range(img.height):
    binary_row = ""
    for col in range(img.width):
        c = color_value(img.getpixel((col, row)))
        binary_row += str(c)
    out.append("\t" + f"dat {str(int(binary_row, 2))}")

with open(os.path.join("assembly", "image_drawer.asm"), mode="r", encoding="utf-8") as asm_base_file:
    string_output = asm_base_file.read() + "\n".join(out)

try:
    pyperclip.copy(string_output)
except NameError:
    pass

try:
    output_filename = sys.argv[2]
except IndexError:
    i = input("Please enter an output file name (leave blank for default): ")
    output_filename = i if i else f"asm-{time.strftime('%Y-%m-%d-%M-%S')}.asm"

with open(os.path.join("output", output_filename), mode="w") as output_asm:
    output_asm.write(string_output)