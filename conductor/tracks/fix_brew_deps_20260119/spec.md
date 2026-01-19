# Track Specification: Resolve Homebrew Dependency Conflicts

## Overview
The user is encountering errors during `darwin-rebuild switch` where Homebrew refuses to uninstall certain packages (e.g., `ca-certificates`, `gmp`, `libidn2`, etc.) because they are dependencies of `emacs-plus@29`, which is currently installed. This indicates a conflict between the packages managed by nix-darwin (trying to clean up unlisted Brew packages) and the persistent installation of `emacs-plus@29`.

## Functional Requirements
1.  **Resolve Dependency Conflict:** The system must reconcile the installed `emacs-plus@29` dependencies with the `nix-darwin` configuration.
2.  **Clean Rebuild:** Running `darwin-rebuild switch --flake .` should complete without "Refusing to uninstall" errors.
3.  **Preserve Functionality:** `emacs-plus@29` must remain functional after the resolution.

## Non-Functional Requirements
1.  **Idempotency:** The solution should be stable across multiple rebuilds.

## Acceptance Criteria
1.  `sudo darwin-rebuild switch --flake .` executes with Exit Code 0 and without the "Refusing to uninstall" error block in the output.
2.  `emacs-plus@29` remains installed and operational.

## Out of Scope
-   Migrating `emacs-plus` to a pure Nix derivation.
