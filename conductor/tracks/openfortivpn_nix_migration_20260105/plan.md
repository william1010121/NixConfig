# Plan: Migrate openfortivpn to Nix

## Phase 1: Configuration & Installation
- [x] Task: Add `openfortivpn` to Nix Configuration
    - [x] Create a new test file `tests/test_packages_config.py` (or check existing `tests/reproduce_issue.sh`) to verify package presence.
    - [x] Add `pkgs.openfortivpn` to `modules/packages.nix` (or appropriate module).
    - [x] Run `darwin-rebuild switch --flake .` to apply changes.
- [x] Task: Uninstall Homebrew Version
    - [x] Verify if `openfortivpn` is currently installed via Homebrew.
    - [x] Run `brew uninstall openfortivpn` to remove the broken installation.
    - [x] Verify `which openfortivpn` points to the Nix store path. 7b83a56
- [~] Task: Conductor - User Manual Verification 'Configuration & Installation' (Protocol in workflow.md)

## Phase 2: Verification
- [ ] Task: Verify Installation
    - [ ] Run `openfortivpn --version` to ensure the binary executes and libraries load correctly.
    - [ ] Check that `sudo openfortivpn --help` works (basic sudo check).
- [ ] Task: Conductor - User Manual Verification 'Verification' (Protocol in workflow.md)
