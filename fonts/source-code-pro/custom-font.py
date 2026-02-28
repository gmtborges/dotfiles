# Fontforge binary location /Applications/FontForge.app/Contents/Resources/opt/local/bin/fontforge
import fontforge
import glob
import os

script_dir = os.path.dirname(os.path.abspath(__file__))

X_SCALE = 1.00
Y_SCALE = 1.05

FONT_FAMILY = "Source Code Pro Custom"
FONT_SUFFIX = "_Custom"

# cv01 letter a
# cv02 letter g
CV_FEATURES = ['cv02']


def count_glyph_points(font, glyph_name):
    if glyph_name not in font:
        return 0
    return sum(len(c) for c in font[glyph_name].foreground)


def get_cv_directions(font, features):
    """Get the point-count delta (variant - base) for each CV substitution."""
    directions = {}
    for lookup in font.gsub_lookups:
        info = font.getLookupInfo(lookup)
        lookup_type = info[0]
        for feature_tuple in info[2]:
            tag = feature_tuple[0]
            if tag in features and lookup_type in ('gsub_single', 'gsub_alternate'):
                for subtable in font.getLookupSubtables(lookup):
                    for glyph in font.glyphs():
                        for sub in glyph.getPosSub(subtable):
                            if sub[1] in ('Substitution', 'AltSubs') and sub[2] in font:
                                base_pts = count_glyph_points(font, glyph.glyphname)
                                var_pts = count_glyph_points(font, sub[2])
                                directions[glyph.glyphname] = var_pts - base_pts
    return directions


def get_cv_mappings(font, features):
    """Extract character variant glyph mappings from a font's GSUB table."""
    mappings = {}
    for lookup in font.gsub_lookups:
        lookup_info = font.getLookupInfo(lookup)
        lookup_type = lookup_info[0]
        feature_script_lang = lookup_info[2]

        for feature_tuple in feature_script_lang:
            feature_tag = feature_tuple[0]
            if feature_tag in features and lookup_type in ('gsub_single', 'gsub_alternate'):
                for subtable in font.getLookupSubtables(lookup):
                    for glyph in font.glyphs():
                        subs = glyph.getPosSub(subtable)
                        for sub in subs:
                            if sub[1] in ('Substitution', 'AltSubs'):
                                mappings[glyph.glyphname] = sub[2]
    return mappings


def apply_character_variants(font, features, ref_directions=None, fallback_mappings=None):
    """Apply character variant substitutions as defaults.

    Uses ref_directions from the Regular font to skip substitutions that go
    in the opposite direction (e.g. italic fonts where the default glyphs
    already have the desired single-story forms).
    """
    applied = []
    skipped = 0
    for lookup in font.gsub_lookups:
        lookup_info = font.getLookupInfo(lookup)
        lookup_type = lookup_info[0]
        feature_script_lang = lookup_info[2]

        for feature_tuple in feature_script_lang:
            feature_tag = feature_tuple[0]
            if feature_tag in features and lookup_type in ('gsub_single', 'gsub_alternate'):
                for subtable in font.getLookupSubtables(lookup):
                    for glyph in font.glyphs():
                        subs = glyph.getPosSub(subtable)
                        for sub in subs:
                            if sub[1] in ('Substitution', 'AltSubs'):
                                variant_name = sub[2]
                                if variant_name in font:
                                    if ref_directions and glyph.glyphname in ref_directions:
                                        ref_delta = ref_directions[glyph.glyphname]
                                        cur_delta = count_glyph_points(font, variant_name) - count_glyph_points(font, glyph.glyphname)
                                        if ref_delta < 0 and cur_delta > 0:
                                            skipped += 1
                                            continue
                                    font.selection.select(variant_name)
                                    font.copy()
                                    font.selection.select(glyph.glyphname)
                                    font.paste()
                applied.append(feature_tag)

    if not applied and fallback_mappings:
        for base_name, variant_name in fallback_mappings.items():
            if base_name in font and variant_name in font:
                if ref_directions and base_name in ref_directions:
                    ref_delta = ref_directions[base_name]
                    cur_delta = count_glyph_points(font, variant_name) - count_glyph_points(font, base_name)
                    if ref_delta < 0 and cur_delta > 0:
                        skipped += 1
                        continue
                font.selection.select(variant_name)
                font.copy()
                font.selection.select(base_name)
                font.paste()
        applied.append('fallback')

    if skipped:
        print(f"  Skipped {skipped} substitution(s) (already correct)")

    return list(set(applied))


def rename_font(font, new_family):
    """Rename font to avoid conflicts with original."""
    original_family = font.familyname
    original_fullname = font.fullname

    style = original_fullname.replace(original_family, "").strip()
    if not style:
        style = "Regular"

    is_italic = "Italic" in style or font.italicangle != 0
    weight = style.replace("Italic", "").strip()
    if not weight:
        weight = "Regular"

    is_bold = weight == "Bold"
    is_ribbi = weight in ("Regular", "Bold")

    if is_italic and weight == "Regular":
        ribbi_subfamily = "Italic"
    elif is_italic and is_bold:
        ribbi_subfamily = "Bold Italic"
    elif is_bold:
        ribbi_subfamily = "Bold"
    else:
        ribbi_subfamily = "Regular" if not is_italic else "Italic"

    if is_ribbi:
        ribbi_family = new_family
    else:
        ribbi_family = f"{new_family} {weight}"

    font.familyname = new_family
    font.fullname = f"{new_family} {style}"
    font.fontname = f"{new_family.replace(' ', '')}-{style.replace(' ', '')}"

    font.sfnt_names = ()
    font.appendSFNTName("English (US)", "Copyright", "")
    font.appendSFNTName("English (US)", "Family", ribbi_family)
    font.appendSFNTName("English (US)", "SubFamily", ribbi_subfamily)
    font.appendSFNTName("English (US)", "UniqueID", f"{new_family} {style}")
    font.appendSFNTName("English (US)", "Fullname", f"{new_family} {style}")
    font.appendSFNTName("English (US)", "PostScriptName", f"{new_family.replace(' ', '')}-{style.replace(' ', '')}")

    if not is_ribbi:
        font.appendSFNTName("English (US)", "Preferred Family", new_family)
        font.appendSFNTName("English (US)", "Preferred Styles", style)

    return style


font_files = [f for f in glob.glob(os.path.join(script_dir, "*.otf"))
              if FONT_SUFFIX not in f]

if not font_files:
    print("No .otf font files found in script directory")
    exit(1)

regular_path = os.path.join(script_dir, "SourceCodePro-Regular.otf")
cv_mappings = {}
cv_directions = {}
if os.path.exists(regular_path):
    ref_font = fontforge.open(regular_path)
    cv_mappings = get_cv_mappings(ref_font, CV_FEATURES)
    cv_directions = get_cv_directions(ref_font, CV_FEATURES)
    ref_font.close()
    if cv_mappings:
        print(f"Extracted {len(cv_mappings)} CV mapping(s) from Regular for fallback\n")

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

    applied_cvs = apply_character_variants(font, CV_FEATURES, cv_directions, cv_mappings)
    if applied_cvs:
        print(f"  Applied character variants: {', '.join(applied_cvs)}")
    else:
        print(f"  No character variants found for: {', '.join(CV_FEATURES)}")

    style = rename_font(font, FONT_FAMILY)
    print(f"  Renamed to: {FONT_FAMILY} {style}")

    base, ext = os.path.splitext(os.path.basename(font_path))
    output_path = os.path.join(script_dir, f"{base}{FONT_SUFFIX}.otf")

    font.generate(output_path)
    font.close()

    print(f"  Generated: {os.path.basename(output_path)}\n")

print("Done processing all fonts!")
