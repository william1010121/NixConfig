# Plan: Investigation - yabai Space Destruction Failure

## Phase 1: Diagnosis and Information Gathering [checkpoint: 941eaf7]
- [x] Task: Verify environment and logs
    - [x] Check `yabai --version` and ensure it's up to date.
    - [x] Check `yabai -m query --spaces` to see how spaces are indexed.
    - [x] Examine `yabai` logs (usually `/tmp/yabai.err.log` or similar) while running the destroy command.
- [x] Task: Test command variants
    - [x] Attempt `yabai -m space --destroy <index>` for a specific index.
    - [x] Test destruction on a secondary display vs. primary display.
- [x] Task: Conductor - User Manual Verification 'Diagnosis and Information Gathering' (Protocol in workflow.md)

## Phase 2: Root Cause Analysis & Fix Experimentation [checkpoint: a95553c]
- [x] Task: Re-validate Scripting Additions
    - [x] Force a reload of scripting additions: `sudo yabai --load-sa`.
    - [x] Verify `yabai` has necessary Accessibility and Screen Recording permissions in System Settings.
- [x] Task: Investigate macOS 16 Specifics
    - [x] Search for known issues regarding `yabai` space destruction on macOS 16 (Sequoia/Future).
    - [x] Test if manual space destruction (Mission Control) works to rule out OS-level locks.
- [x] Task: Implement Fix or Workaround
    - [x] If a configuration change is needed, apply it to `modules/window-manager.nix`.
    - [x] If it's a known bug with a workaround (e.g., specific timing or sequence), implement the script/logic.
- [~] Task: Conductor - User Manual Verification 'Root Cause Analysis & Fix Experimentation' (Protocol in workflow.md)

## Phase 3: Integration and Finalization
- [x] Task: Update Nix Configuration
    - [x] Ensure any necessary changes are committed to the `nix-darwin` flake.
    - [x] Run `darwin-rebuild switch --flake .` to verify the setup remains stable.
- [x] Task: Document Findings
    - [x] Update `config/yabairc` or add comments in `modules/window-manager.nix` explaining the fix for macOS 16.
- [~] Task: Conductor - User Manual Verification 'Integration and Finalization' (Protocol in workflow.md)
