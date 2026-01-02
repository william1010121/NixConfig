import json

manual_fixes = {
    "aom": "libaom",
    "highway": "libhwy",
    "cjson": "cjson",
    "libxcb": "xorg.libxcb"
}

# Read report to get the 90 found
found_map = {}
with open('conductor/tracks/bulk_package_migration_20260102/mapping_report.txt', 'r') as f:
    lines = f.readlines()
    for line in lines:
        if line.startswith("Nixpkgs: "):
            # Format: Nixpkgs: <attr> (was <original>)
            parts = line.strip().split("Nixpkgs: ")[1].split(" (was ")
            attr = parts[0]
            original = parts[1][:-1] # remove closing paren
            found_map[original] = attr

# Merge
final_map = found_map.copy()
final_map.update(manual_fixes)

# Verify we have all from original list
with open('conductor/tracks/bulk_package_migration_20260102/packages_list.txt', 'r') as f:
    originals = [l.strip() for l in f if l.strip()]

missing = []
for o in originals:
    if o not in final_map:
        missing.append(o)

result = {
    "nixpkgs": final_map,
    "homebrew": missing # Should be empty
}

with open('conductor/tracks/bulk_package_migration_20260102/final_mapping.json', 'w') as f:
    json.dump(result, f, indent=2)

print(f"Final mapping created. Mapped: {len(final_map)}. Unmapped: {len(missing)}.")
if missing:
    print("Unmapped:", missing)
