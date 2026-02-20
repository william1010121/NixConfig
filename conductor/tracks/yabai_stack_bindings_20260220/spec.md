# Specification: Yabai Stacking Key Bindings

## Overview
This track aims to add new key bindings to `skhdrc` for managing window stacks in `yabai`. It also involves reorganizing existing window resizing bindings to avoid conflicts.

## Functional Requirements
- **Stack Navigation:**
  - `ctrl + alt - j`: Focus the next window in the stack (`yabai -m window --focus stack.next`).
  - `ctrl + alt - k`: Focus the previous window in the stack (`yabai -m window --focus stack.prev`).
- **Stack Creation:**
  - `ctrl + alt - s`: Set the next window to be added as a stack (`yabai -m window --insert stack`).
- **Resize Binding Reorganization:**
  - Move "Increase window size" from `ctrl + alt - h/j/k/l` to `ctrl + alt + cmd - h/j/k/l`.
  - Remove existing "Decrease window size" bindings on `ctrl + alt + cmd - h/j/k/l`.

## Acceptance Criteria
- [ ] `ctrl + alt - j` successfully focuses the next window in a stack.
- [ ] `ctrl + alt - k` successfully focuses the previous window in a stack.
- [ ] `ctrl + alt - s` successfully sets the insertion mode to `stack`.
- [ ] `ctrl + alt + cmd - h/j/k/l` successfully increases the window size.
- [ ] Old "Decrease window size" bindings are removed.
- [ ] No syntax errors in `skhdrc`.

## Out of Scope
- Implementing custom scripts for contextual key bindings (bindings will be global but use stacking-specific commands).
- Changes to `yabairc`.
