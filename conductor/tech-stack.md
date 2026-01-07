# Tech Stack

## Core Technologies
- **Nix:** The primary functional programming language used for defining the entire system configuration.
- **Nix Flakes:** Used for managing project dependencies (inputs like nixpkgs, nix-darwin, and home-manager) with precise version locking via `flake.lock`.

## System & User Management
- **nix-darwin:** Provides declarative configuration for macOS, managing system-level packages, services, and preferences.
- **Home Manager:** Manages the user environment, including dotfiles and user-specific application configurations, integrated with nix-darwin.
- **Homebrew:** Integrated with nix-darwin's `homebrew` module to manage packages that require the latest versions not yet in nixpkgs, such as window management tools.

## Key Managed Tools
- **Window Management (Homebrew Managed):** `yabai` (tiling window manager) and `skhd` (hotkey daemon).
- **Editors:** `vim` and `neovim` for terminal-based text editing.
- **Doom Emacs:** Hybrid management using `writeShellScriptBin` to provide a mutable `~/.config/doom` directory while maintaining the source in the repository.
- **Git Utilities:** `lazygit` for an interactive TUI for Git operations.

## Architecture
- **Modular Nix Modules:** The project uses a modular approach, with system-wide settings in `flake.nix` and user-specific logic extracted into modules within the `modules/` directory (e.g., `modules/home.nix`, `modules/window-manager.nix`).
- **Centralized Package Configuration:** A dedicated `modules/packages.nix` module manages the bulk list of user-facing packages, keeping `home.nix` focused on configuration logic.
