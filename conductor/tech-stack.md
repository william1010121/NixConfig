# Tech Stack

## Core Technologies
- **Nix:** The primary functional programming language used for defining the entire system configuration.
- **Nix Flakes:** Used for managing project dependencies (inputs like nixpkgs, nix-darwin, and home-manager) with precise version locking via `flake.lock`.

## System & User Management
- **nix-darwin:** Provides declarative configuration for macOS, managing system-level packages, services, and preferences.
- **Home Manager:** Manages the user environment, including dotfiles and user-specific application configurations, integrated with nix-darwin.

## Key Managed Tools
- **Window Management:** `yabai` (tiling window manager) and `skhd` (hotkey daemon).
- **Editors:** `vim` and `neovim` for terminal-based text editing.
- **Git Utilities:** `lazygit` for an interactive TUI for Git operations.

## Architecture
- **Modular Nix Modules:** The project uses a modular approach, with system-wide settings in `flake.nix` and user-specific logic extracted into modules within the `modules/` directory (e.g., `modules/home.nix`, `modules/window-manager.nix`).
