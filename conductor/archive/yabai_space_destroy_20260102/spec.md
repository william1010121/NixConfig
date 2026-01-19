# Specification: Investigation - yabai Space Destruction Failure

## Overview
This track focuses on investigating and resolving an issue where `yabai` fails to destroy spaces on macOS 16.x. Despite having System Integrity Protection (SIP) disabled and scripting additions installed, the command `yabai -m space --destroy` executes silently without actually removing the space, regardless of whether the space is empty or contains windows.

## Problem Statement
- **Environment:** macOS 16.x, `yabai` with scripting additions enabled.
- **Symptom:** `yabai -m space --destroy` fails silently.
- **Scope:** Affects both empty and non-empty spaces.
- **Current State:** Other space operations (focus, move, create) are functioning correctly.

## Goals
1. Identify the root cause of the silent failure for space destruction.
2. Verify if it's a configuration issue, a `yabai` bug, or a macOS 16.x limitation/change.
3. Implement a fix or provide a documented workaround.

## Functional Requirements
- The system must allow for the destruction of a space via `yabai` commands or a validated alternative.
- Destruction should work for the current space and targeted spaces (if applicable).

## Non-Functional Requirements
- Maintain system stability.
- Ensure the fix adheres to the project's Nix-managed configuration.

## Acceptance Criteria
- [ ] The command `yabai -m space --destroy` (or a working equivalent) successfully removes a space.
- [ ] The fix is integrated into the `nix-darwin` configuration if changes are required.
- [ ] Root cause and solution are documented.

## Out of Scope
- Fixing other unrelated `yabai` or `skhd` bugs.
- Major refactoring of the window management configuration unless required for the fix.
