import fontforge
import glob
import os

script_dir = os.path.dirname(os.path.abspath(__file__))

FONT_FAMILY = "Liga Mono Fixed"
FONT_SUFFIX = "_Fixed"
CV_FEATURES = ['cv09']
LIGATURE_FEATURES = {'liga', 'clig', 'dlig', 'hlig', 'calt', 'rclt'}


def count_glyph_points(font, glyph_name):
    if glyph_name not in font:
        return 0
    return sum(len(c) for c in font[glyph_name].foreground)


def get_cv_directions(font, features):
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


ttf_files = [f for f in glob.glob(os.path.join(script_dir, "*.ttf"))
             if FONT_SUFFIX not in f]

if not ttf_files:
    print("No .ttf font files found in script directory")
    exit(1)

regular_path = os.path.join(script_dir, "psudoFont_Liga_Mono_-_Regular.ttf")
cv_mappings = {}
cv_directions = {}
if CV_FEATURES and os.path.exists(regular_path):
    ref_font = fontforge.open(regular_path)
    cv_mappings = get_cv_mappings(ref_font, CV_FEATURES)
    cv_directions = get_cv_directions(ref_font, CV_FEATURES)
    ref_font.close()
    if cv_mappings:
        print(f"Extracted {len(cv_mappings)} CV mapping(s) from Regular for fallback\n")

print(f"Found {len(ttf_files)} font file(s) to process\n")

for ttf_path in ttf_files:
    print(f"Processing: {os.path.basename(ttf_path)}")
    font = fontforge.open(ttf_path)

    lookups_to_remove = set()
    for lookup in font.gsub_lookups:
        lookup_info = font.getLookupInfo(lookup)
        feature_script_lang = lookup_info[2]
        for feature_tuple in feature_script_lang:
            feature_tag = feature_tuple[0]
            if feature_tag in LIGATURE_FEATURES:
                lookups_to_remove.add(lookup)
                print(f"  Found ligature lookup: {lookup} (feature: {feature_tag})")
                break

    for lookup in lookups_to_remove:
        print(f"  Removing lookup: {lookup}")
        font.removeLookup(lookup)

    print(f"  Removed {len(lookups_to_remove)} ligature-related lookup(s)")

    if CV_FEATURES:
        applied_cvs = apply_character_variants(font, CV_FEATURES, cv_directions, cv_mappings)
        if applied_cvs:
            print(f"  Applied character variants: {', '.join(applied_cvs)}")
        else:
            print(f"  No character variants found for: {', '.join(CV_FEATURES)}")

    style = rename_font(font, FONT_FAMILY)
    print(f"  Renamed to: {FONT_FAMILY} {style}")

    base, ext = os.path.splitext(os.path.basename(ttf_path))
    clean_name = base.replace("psudoFont_", "") + FONT_SUFFIX + ext
    output_path = os.path.join(script_dir, clean_name)

    font.generate(output_path)
    font.close()

    print(f"  Generated: {os.path.basename(output_path)}\n")

print("Done processing all fonts!")
