import json

with open('conductor/tracks/bulk_package_migration_20260102/final_mapping.json', 'r') as f:
    data = json.load(f)

nixpkgs = data['nixpkgs']
# Sort by attribute name for clean config
sorted_attrs = sorted(set(nixpkgs.values()))

lines = ["{ pkgs, ... }:", "", "{", "  home.packages = with pkgs; ["]
for attr in sorted_attrs:
    lines.append(f"    {attr}")
lines.append("  ];")
lines.append("}")

with open('modules/packages.nix', 'w') as f:
    f.write("\n".join(lines) + "\n")

print(f"Generated modules/packages.nix with {len(sorted_attrs)} packages.")
