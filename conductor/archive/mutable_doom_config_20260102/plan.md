# Plan: Mutable Doom Emacs Configuration

This plan outlines the steps to transition the Doom Emacs configuration from a read-only Nix-managed symlink to a mutable local directory with a helper script for resetting/updating.

## Phase 1: Preparation and Nix Configuration
Goal: Remove the read-only management of `~/.config/doom` and prepare the environment.

- [x] Task: Create reproduction/verification script to check current status (symlink vs directory)
- [x] Task: Modify `modules/home.nix` to disable `xdg.configFile."doom"`
- [x] Task: Apply Nix configuration (`darwin-rebuild switch`) and verify `~/.config/doom` is no longer managed by Nix
- [ ] Task: Conductor - User Manual Verification 'Phase 1: Preparation and Nix Configuration' (Protocol in workflow.md)

## Phase 2: Implement Reset Helper Script
Goal: Create and install the `reset-doom-config` script.

- [x] Task: Define the `reset-doom-config` script content with backup and copy logic
- [x] Task: Add the script to the Nix configuration (e.g., as a package or via `home.packages`)
- [x] Task: Apply Nix configuration to install the script
- [x] Task: Verify the script is available in the global PATH
- [x] Task: Conductor - User Manual Verification 'Phase 2: Implement Reset Helper Script' (Protocol in workflow.md)

## Phase 3: Verification and Finalization
Goal: Ensure the full workflow (reset, backup, edit) works as expected.

- [x] Task: Run `reset-doom-config` for the first time and verify `~/.config/doom` is populated correctly
- [x] Task: Verify that files in `~/.config/doom` are writable
- [x] Task: Verify the backup functionality by running `reset-doom-config` again
- [x] Task: Document the new workflow in a README or similar if appropriate
- [x] Task: Conductor - User Manual Verification 'Phase 3: Verification and Finalization' (Protocol in workflow.md)
