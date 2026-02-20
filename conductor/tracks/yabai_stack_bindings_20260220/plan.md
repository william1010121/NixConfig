# Implementation Plan: Yabai Stacking Key Bindings

## Phase 1: Verification Setup
- [ ] Task: Create a verification script `tests/verify_stacking_bindings.sh` to check for the presence of new bindings and absence of old ones.
    - [ ] Add check for `ctrl + alt - j/k/s` stacking commands.
    - [ ] Add check for `ctrl + alt + cmd - h/j/k/l` increase resize commands.
    - [ ] Add check for absence of old decrease resize commands on `ctrl + alt + cmd`.

## Phase 2: Implementation
- [ ] Task: Modify `config/skhdrc` to reorganize resize bindings.
    - [ ] Remove existing "Decrease window size" section.
    - [ ] Update "Increase window size" section to use `ctrl + alt + cmd`.
- [ ] Task: Modify `config/skhdrc` to add stacking bindings.
    - [ ] Add `ctrl + alt - j/k` for stack navigation.
    - [ ] Add `ctrl + alt - s` for `--insert stack`.
- [ ] Task: Conductor - User Manual Verification 'Yabai Stacking Key Bindings' (Protocol in workflow.md)
