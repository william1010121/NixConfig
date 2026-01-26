# Cross-Platform Nix Configuration

A unified Nix configuration supporting both **macOS** (via nix-darwin) and **Linux** (via Home Manager standalone).

## Supported Platforms

| Platform | Architecture | Configuration |
|----------|--------------|---------------|
| macOS    | aarch64 (Apple Silicon) | `darwinConfigurations."william-2"` |
| Linux    | x86_64 | `homeConfigurations."guoshengwei@linux"` |
| Linux    | aarch64 | `homeConfigurations."guoshengwei@linux-arm"` |

## Directory Structure

```
/private/etc/nix-darwin/
├── flake.nix                      # Main entry point
├── flake.lock
├── README.md
│
├── modules/
│   ├── common/                    # Cross-platform shared modules
│   │   ├── packages.nix           # Cross-platform packages (~70+)
│   │   ├── home-base.nix          # Home Manager base settings
│   │   └── programs/
│   │       ├── zsh.nix            # Zsh configuration (with platform detection)
│   │       ├── git.nix            # Git configuration
│   │       ├── direnv.nix         # Direnv configuration
│   │       └── vim.nix            # Vim configuration
│   │
│   ├── darwin/                    # macOS-specific modules
│   │   ├── default.nix            # Darwin system configuration
│   │   ├── homebrew.nix           # Homebrew packages
│   │   ├── window-manager.nix     # yabai/skhd configuration
│   │   └── home.nix               # macOS Home Manager extensions
│   │
│   └── linux/                     # Linux-specific modules
│       ├── default.nix            # Linux Home Manager entry
│       └── packages.nix           # Linux-specific packages (X11, GNOME)
│
├── hosts/                         # Host-specific configurations
│   ├── william-2/default.nix      # macOS host
│   └── linux/default.nix          # Linux host
│
├── users/                         # User configurations
│   └── guoshengwei/default.nix
│
└── config/                        # Dotfiles
    ├── doom/                      # Doom Emacs configuration
    ├── gitconfig/                 # Git configuration files
    ├── vimrc                      # Vim configuration
    ├── yabairc                    # yabai configuration (macOS)
    ├── skhdrc                     # skhd configuration (macOS)
    └── ...
```

## Quick Start

### macOS

```bash
# Build the configuration
darwin-rebuild build --flake .#william-2

# Apply the configuration
darwin-rebuild switch --flake .#william-2
```

### Linux

```bash
# Install Nix (if not already installed)
sh <(curl -L https://nixos.org/nix/install) --daemon

# Install Home Manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# Apply the configuration (x86_64)
nix run home-manager -- switch --flake .#guoshengwei@linux

# Or for ARM Linux
nix run home-manager -- switch --flake .#guoshengwei@linux-arm
```

## Package Categories

### Cross-Platform Packages (modules/common/packages.nix)

| Category | Packages |
|----------|----------|
| Development | gcc, cmake, nodejs, python313, go, clisp |
| CLI Tools | bat, eza, tree, lazygit, direnv |
| Scientific Computing | eigen, ceres-solver, openblas, hdf5, suitesparse |
| Image Processing | tesseract, ghostscript, libwebp, libjpeg_turbo |
| Font Rendering | fontconfig, freetype, harfbuzz, cairo, pango |
| Compression | openssl, lzo, libb2, libdeflate |

### macOS-Only (via Homebrew)

| Category | Packages |
|----------|----------|
| Window Manager | yabai, skhd |
| Editor | emacs-plus@29 |
| TeX | mactex-no-gui |
| Fonts | font-meslo-lg-nerd-font |

### Linux-Only (modules/linux/packages.nix)

| Category | Packages |
|----------|----------|
| X11 | xorg.libX11, xorg.libXext, xorg.libxcb, etc. |
| GNOME/GTK | gdk-pixbuf, dbus, at-spi2-core, adwaita-icon-theme |

## Customization

### Adding a New Package

1. **Cross-platform package**: Add to `modules/common/packages.nix`
2. **macOS-only package**: Add to `modules/darwin/homebrew.nix` (for Homebrew) or `modules/darwin/home.nix` (for Nix)
3. **Linux-only package**: Add to `modules/linux/packages.nix`

### Adding a New Program Configuration

Create a new file in `modules/common/programs/` and import it in `modules/common/home-base.nix`:

```nix
# modules/common/programs/myprogram.nix
{ config, pkgs, lib, isDarwin ? true, ... }:

{
  programs.myprogram = {
    enable = true;
    # Platform-specific settings
    settings = lib.optionalAttrs isDarwin {
      # macOS settings
    } // lib.optionalAttrs (!isDarwin) {
      # Linux settings
    };
  };
}
```

### Adding a New Host

1. Create `hosts/hostname/default.nix`
2. Add the configuration to `flake.nix`

## Platform Detection

The configuration uses an `isDarwin` boolean passed to modules:

```nix
{ config, pkgs, lib, isDarwin ? true, ... }:

{
  # Cross-platform settings
  home.packages = with pkgs; [
    common-package
  ] ++ lib.optionals isDarwin [
    darwin-only-package
  ] ++ lib.optionals (!isDarwin) [
    linux-only-package
  ];

  # Conditional strings in config
  programs.zsh.initExtra = ''
    # Common config
    ${lib.optionalString isDarwin ''
      # macOS-specific
    ''}
  '';
}
```

## Troubleshooting

### macOS: darwin-rebuild fails

```bash
# Check flake syntax
nix flake check

# Build with verbose output
darwin-rebuild build --flake .#william-2 --show-trace
```

### Linux: Home Manager switch fails

```bash
# Check if Nix is properly configured
nix --version

# Build with verbose output
home-manager switch --flake .#guoshengwei@linux --show-trace
```

### Zsh: Path or alias errors

- Check if the platform detection is working correctly
- Verify `isDarwin` is being passed to the zsh module
- Check `~/.zshrc` for any syntax errors

### Doom Emacs: mac-option-modifier not working on Linux

The `config/doom/config.el` uses platform detection:

```elisp
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta)
  (setq mac-right-option-modifier 'meta))
```

## Development

Enter the development shell:

```bash
nix develop
```

This provides:
- `nixpkgs-fmt` - Nix code formatter
- `nil` - Nix LSP for IDE integration

## License

Personal configuration - feel free to use as a reference for your own setup.
