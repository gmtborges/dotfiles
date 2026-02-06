import fontforge
import glob
import os

script_dir = os.path.dirname(os.path.abspath(__file__))

X_SCALE = 1.00
Y_SCALE = 1.05

FONT_FAMILY = "Source Code Pro Custom"
FONT_SUFFIX = "_Custom"

CV_FEATURES = ['cv01', 'cv02']


def apply_character_variants(font, features):
    """Apply character variant substitutions as defaults."""
    applied = []
    for lookup in font.gsub_lookups:
        lookup_info = font.getLookupInfo(lookup)
        lookup_type = lookup_info[0]
        feature_script_lang = lookup_info[2]

        for feature_tuple in feature_script_lang:
            feature_tag = feature_tuple[0]
            if feature_tag in features and lookup_type == 'gsub_single':
                for subtable in font.getLookupSubtables(lookup):
                    for glyph in font.glyphs():
                        subs = glyph.getPosSub(subtable)
                        for sub in subs:
                            if sub[1] == 'Substitution':
                                variant_name = sub[2]
                                if variant_name in font:
                                    font.selection.select(variant_name)
                                    font.copy()
                                    font.selection.select(glyph.glyphname)
                                    font.paste()
                applied.append(feature_tag)
    return list(set(applied))


def rename_font(font, new_family):
    """Rename font to avoid conflicts with original."""
    original_family = font.familyname
    original_fullname = font.fullname

    weight = original_fullname.replace(original_family, "").strip()
    if not weight:
        weight = "Regular"

    font.familyname = new_family
    font.fullname = f"{new_family} {weight}"
    font.fontname = f"{new_family.replace(' ', '')}-{weight.replace(' ', '')}"

    font.sfnt_names = ()
    font.appendSFNTName("English (US)", "Copyright", "")
    font.appendSFNTName("English (US)", "Family", new_family)
    font.appendSFNTName("English (US)", "SubFamily", weight)
    font.appendSFNTName("English (US)", "UniqueID", f"{new_family} {weight}")
    font.appendSFNTName("English (US)", "Fullname", f"{new_family} {weight}")
    font.appendSFNTName("English (US)", "PostScriptName", f"{new_family.replace(' ', '')}-{weight.replace(' ', '')}")

    return weight


font_files = [f for f in glob.glob(os.path.join(script_dir, "*.otf"))
              if FONT_SUFFIX not in f]

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

    print(f"  Scaled glyphs: {X_SCALE}x width, {Y_SCALE}x height")
    print(f"  Metrics preserved: ascent={original_ascent}, descent={original_descent}")

    applied_cvs = apply_character_variants(font, CV_FEATURES)
    if applied_cvs:
        print(f"  Applied character variants: {', '.join(applied_cvs)}")
    else:
        print(f"  No character variants found for: {', '.join(CV_FEATURES)}")

    weight = rename_font(font, FONT_FAMILY)
    print(f"  Renamed to: {FONT_FAMILY} {weight}")

    base, ext = os.path.splitext(os.path.basename(font_path))
    output_path = os.path.join(script_dir, f"{base}{FONT_SUFFIX}.otf")

    font.generate(output_path)
    font.close()

    print(f"  Generated: {os.path.basename(output_path)}\n")

print("Done processing all fonts!")
