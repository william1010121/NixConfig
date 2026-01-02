# Plan: Bulk Package Migration to Home Manager

This plan outlines the steps to migrate a bulk list of packages into the Nix-Darwin and Home Manager configuration, following a "Nixpkgs First" strategy.

## Phase 1: Analysis and Mapping [checkpoint: cffada4]

- [x] Task: Map package list to Nixpkgs vs Homebrew. Identify which packages from the user's list are available in Nixpkgs and which must remain in Homebrew. cffada4
- [x] Task: Create a tracking document/log of the mapping for verification. cffada4
- [x] Task: Conductor - User Manual Verification 'Analysis and Mapping' (Protocol in workflow.md) cffada4

## Phase 2: Scaffolding [checkpoint: a21512d]

- [x] Task: Create `modules/packages.nix` as a skeleton Home Manager module. a21512d
- [x] Task: Modify `modules/home.nix` to import `./packages.nix`. a21512d
- [x] Task: Conductor - User Manual Verification 'Scaffolding' (Protocol in workflow.md) a21512d

## Phase 3: Implementation

- [ ] Task: Populate `home.packages` in `modules/packages.nix` with the identified Nix packages.
- [ ] Task: Update `homebrew.brews` in `flake.nix` with the identified Homebrew-only packages.
- [ ] Task: Conductor - User Manual Verification 'Implementation' (Protocol in workflow.md)

## Phase 4: Verification and Activation

- [ ] Task: Dry-run the configuration update. Run `darwin-rebuild build --flake .` to ensure there are no evaluation or build errors.
- [ ] Task: Apply the configuration. Run `darwin-rebuild switch --flake .`.
- [ ] Task: Verify package availability. Spot-check a few migrated packages (e.g., `cmake --version`, `sqlite3 --version`) to ensure they are correctly installed and linked.
- [ ] Task: Conductor - User Manual Verification 'Verification and Activation' (Protocol in workflow.md)
