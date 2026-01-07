# Specification: Mutable Doom Emacs Configuration

## Overview
Currently, the Doom Emacs configuration in `~/.config/doom` is managed directly by Home Manager using `xdg.configFile`, which results in a read-only directory symlinked to the Nix store. This prevents users from making quick, experimental changes within Emacs. This track will move to a "Mutable Copy" model where the configuration is managed manually via a helper script.

## Functional Requirements
1.  **Remove Declarative Management:** Disable the `xdg.configFile."doom"` block in `modules/home.nix` to stop Nix from enforcing read-only symlinks.
2.  **Global Reset Command:** Implement a shell script named `reset-doom-config` that will be available globally in the system path.
3.  **Reset Logic:** The `reset-doom-config` script must:
    -   **Backup:** If `~/.config/doom` exists, back it up to a timestamped directory (e.g., `~/.config/doom.<YYYYMMDD-HHMMSS>.bak`).
    -   **Clean:** Remove the current `~/.config/doom` path (whether it is a directory or symlink).
    -   **Restore:** Copy the contents of `/private/etc/nix-darwin/config/doom` to `~/.config/doom`.
    -   **Permissions:** Ensure all copied files and directories have write permissions for the user.
4.  **Initial Provisioning:** Ensure that after the first `darwin-rebuild`, the user has instructions or a trigger to populate the mutable directory.

## Non-Functional Requirements
-   **Independence:** The local `~/.config/doom` should be completely independent of the Nix store after copying, allowing standard file operations (edit, save, delete).

## Acceptance Criteria
-   `~/.config/doom` is a regular directory, not a symlink to `/nix/store/...`.
-   Files within `~/.config/doom` can be edited and saved by the user.
-   Running `reset-doom-config` creates a backup of the previous configuration before overwriting.
-   Running `reset-doom-config` successfully overwrites the local config with the source from the repository.

## Out of Scope
-   Automatic "sync-back" script (changes must be manually copied back to the repository if they are to be kept permanently).
