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
- [~] Task: Conductor - User Manual Verification 'Yabai Stacking Key Bindings' (Protocol in workflow.md)

## Phase 3: Visual & UX Enhancements
- [x] Task: Modify `config/yabairc` to increase `window_gap` to 10. (1b6d779)
- [x] Task: Modify `config/skhdrc` to use toggle script for opacity. (3ebf947)
- [x] Task: Modify `config/skhdrc` to add a binding for toggling space padding. (1b6d779)
- [ ] Task: Conductor - User Manual Verification 'Visual & UX Enhancements' (Protocol in workflow.md)
- [x] Task: Create `config/scripts/toggle_opacity.sh`. (3ebf947)
- [x] Task: Enable window opacity in `config/yabairc`. (3ebf947)
- [ ] Task: Add `ctrl + alt + cmd - s` binding for stack layout.
