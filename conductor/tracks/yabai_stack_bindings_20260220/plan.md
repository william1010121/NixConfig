# Implementation Plan: Yabai Stacking Key Bindings

## Phase 1: Verification Setup
- [x] Task: Create a verification script (0505f23) `tests/verify_stacking_bindings.sh` to check for the presence of new bindings and absence of old ones.
    - [ ] Add check for `ctrl + alt - j/k/s` stacking commands.
    - [ ] Add check for `ctrl + alt + cmd - h/j/k/l` increase resize commands.
    - [ ] Add check for absence of old decrease resize commands on `ctrl + alt + cmd`.

## Phase 2: Implementation
- [x] Task: Modify `config/skhdrc` to reorganize resize bindings (a2ebb2d).
    - [ ] Remove existing "Decrease window size" section.
    - [ ] Update "Increase window size" section to use `ctrl + alt + cmd`.
- [x] Task: Modify `config/skhdrc` to add stacking bindings (9266d73).
    - [ ] Add `ctrl + alt - j/k` for stack navigation.
    - [ ] Add `ctrl + alt - s` for `--insert stack`.
- [ ] Task: Conductor - User Manual Verification 'Yabai Stacking Key Bindings' (Protocol in workflow.md)
