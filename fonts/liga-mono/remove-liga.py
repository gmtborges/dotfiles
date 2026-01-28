import fontforge
import glob
import os

script_dir = os.path.dirname(os.path.abspath(__file__))
ttf_files = glob.glob(os.path.join(script_dir, "*.ttf"))

if not ttf_files:
    print("No .ttf files found in script directory")
    exit(1)

print(f"Found {len(ttf_files)} font file(s) to process\n")

LIGATURE_FEATURES = {'liga', 'clig', 'dlig', 'hlig', 'calt', 'rclt'}

for ttf_path in ttf_files:
    if "_Fixed" in ttf_path:
        print(f"Skipping already processed: {os.path.basename(ttf_path)}")
        continue

    print(f"Processing: {os.path.basename(ttf_path)}")
    font = fontforge.open(ttf_path)

    original_family = font.familyname
    original_fullname = font.fullname

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

    weight = original_fullname.replace(original_family, "").strip()
    if not weight:
        weight = "Regular"

    font.familyname = "Liga Mono Fixed"
    font.fullname = f"Liga Mono Fixed {weight}"
    font.fontname = f"LigaMonoFixed-{weight.replace(' ', '')}"

    # Clear all existing name table entries and set new ones
    font.sfnt_names = ()
    font.appendSFNTName("English (US)", "Copyright", "")
    font.appendSFNTName("English (US)", "Family", "Liga Mono Fixed")
    font.appendSFNTName("English (US)", "SubFamily", weight)
    font.appendSFNTName("English (US)", "UniqueID", f"Liga Mono Fixed {weight}")
    font.appendSFNTName("English (US)", "Fullname", f"Liga Mono Fixed {weight}")
    font.appendSFNTName("English (US)", "PostScriptName", f"LigaMonoFixed-{weight.replace(' ', '')}")

    base, ext = os.path.splitext(os.path.basename(ttf_path))
    clean_name = base.replace("psudoFont_", "") + "_Fixed" + ext
    output_path = os.path.join(script_dir, clean_name)

    font.generate(output_path)
    font.close()

    print(f"  Generated: {os.path.basename(output_path)}\n")

print("Done processing all fonts!")
