import fontforge
import glob
import os

script_dir = os.path.dirname(os.path.abspath(__file__))

X_SCALE = 1.05      # 5% wider
Y_SCALE = 1.1       # 10% taller

font_files = [f for f in glob.glob(os.path.join(script_dir, "*.otf"))
              if "_Tall" not in f]

if not font_files:
    print("No .otf font files found in script directory")
    exit(1)

print(f"Found {len(font_files)} .otf font file(s) to process\n")

for font_path in font_files:
    print(f"Processing: {os.path.basename(font_path)}")
    font = fontforge.open(font_path)

    original_ascent = font.ascent
    original_descent = font.descent
    original_em = font.em

    font.selection.all()

    for glyph in font.glyphs():
        if glyph.isWorthOutputting():
            glyph.transform((X_SCALE, 0, 0, Y_SCALE, 0, 0))
            glyph.width = int(glyph.width * X_SCALE)

    new_ascent = int(original_ascent * Y_SCALE)
    new_descent = int(original_descent * Y_SCALE)

    font.ascent = new_ascent
    font.descent = new_descent

    font.os2_typoascent = new_ascent
    font.os2_typodescent = -new_descent
    font.os2_winascent = new_ascent
    font.os2_windescent = new_descent
    font.hhea_ascent = new_ascent
    font.hhea_descent = -new_descent

    print(f"  Scaled glyphs: {X_SCALE}x width, {Y_SCALE}x height")
    print(f"  Ascent: {original_ascent} -> {new_ascent}")
    print(f"  Descent: {original_descent} -> {new_descent}")

    base, ext = os.path.splitext(os.path.basename(font_path))
    output_path = os.path.join(script_dir, f"{base}_Tall.otf")

    font.generate(output_path)
    font.close()

    print(f"  Generated: {os.path.basename(output_path)}\n")

print("Done processing all fonts!")
