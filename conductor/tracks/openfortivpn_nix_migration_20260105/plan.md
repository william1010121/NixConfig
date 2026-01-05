# Plan: Migrate openfortivpn to Nix

## Phase 1: Configuration & Installation [checkpoint: 59d852b]
- [x] Task: Add `openfortivpn` to Nix Configuration
    - [x] Create a new test file `tests/test_packages_config.py` (or check existing `tests/reproduce_issue.sh`) to verify package presence.
    - [x] Add `pkgs.openfortivpn` to `modules/packages.nix` (or appropriate module).
    - [x] Run `darwin-rebuild switch --flake .` to apply changes.
- [x] Task: Uninstall Homebrew Version
    - [x] Verify if `openfortivpn` is currently installed via Homebrew.
    - [x] Run `brew uninstall openfortivpn` to remove the broken installation.
    - [x] Verify `which openfortivpn` points to the Nix store path. 7b83a56
- [x] Task: Conductor - User Manual Verification 'Configuration & Installation' (Protocol in workflow.md)

## Phase 2: Verification
- [x] Task: Verify Installation
    - [x] Run `openfortivpn --version` to ensure the binary executes and libraries load correctly.
    - [x] Check that `sudo openfortivpn --help` works (basic sudo check). f01dbfb
- [~] Task: Conductor - User Manual Verification 'Verification' (Protocol in workflow.md)
