# Initial Concept
A personal workstation setup and dotfile management project based on nix-darwin, Home Manager, and Nix Flakes.

# Product Guide

## Project Goal
The primary objective of this project is to manage a personal workstation setup and dotfiles using a reproducible and modular Nix-based configuration. It aims to provide a consistent and reliable environment across different machines, specifically focusing on macOS using nix-darwin.

## Core Features
- **Window Management & Hotkeys:** Comprehensive configuration for yabai and skhd to enable efficient tiling window management and keyboard-driven workflows.
- **Shell & Terminal Environment:** Robust setup for zsh, vim, and neovim, ensuring a productive command-line experience with customized dotfiles.
- **User-Specific Package Management:** Leveraging Home Manager with a "Nixpkgs First" strategy to manage a wide range of development tools and libraries in a declarative and reproducible manner.
- **Mutable Configuration Management:** Hybrid approach for complex configurations like Doom Emacs, using a "Mutable Copy" model with helper scripts (`reset-doom-config`) to balance reproducibility with user experimentability.
- **Enhanced Git Workflows:** Integration of advanced Git configurations and exploring secure secret management (e.g., sops-nix) for sensitive configuration data.
- **Cross-Platform Integration:** Improving compatibility and integration with cloud services and tools that span multiple platforms.

## Development Priorities
- **Refactoring for Organization:** Restructuring existing Nix modules to improve clarity, reduce duplication, and enhance the overall maintainability of the configuration.
- **Feature Expansion:** Incrementally adding new development tools and dotfiles to the managed configuration, ensuring they adhere to the project's standards.

## Guiding Principles
- **Reproducibility:** Every aspect of the system should be declaratively defined so that the entire environment can be perfectly recreated from the configuration files.
- **Readability:** The Nix code and associated configurations should be organized and commented to ensure they are easy to understand and modify.
