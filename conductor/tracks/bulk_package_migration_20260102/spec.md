# Spec: Bulk Package Migration to Home Manager

## Overview
This track involves migrating a large list of packages into the user's `home-manager` configuration. The goal is to move towards a reproducible Nix-based setup while maintaining Homebrew for packages not yet available in Nixpkgs.

## Track Type
Chore / Configuration Update

## Functional Requirements
- **Hybrid Package Management:** Implement a "Nixpkgs First" strategy.
- **Search & Map:** Each package in the provided list must be checked against Nixpkgs.
- **Nixpkgs Installation (User Scope):** Packages found in Nixpkgs will be added to the user's environment (`home.packages`) via Home Manager.
- **Homebrew Fallback (System Scope):** Packages not found in Nixpkgs will be added to the `homebrew.brews` list in the system configuration (as Homebrew is system-wide).
- **Modular Organization:**
    - Create a new Home Manager module `modules/packages.nix` for the Nixpkgs list.
    - Import `modules/packages.nix` into `modules/home.nix`.
    - Update `flake.nix` (or the relevant system module) with the remaining Homebrew packages.

## Included Packages
- Core list from user: `abseil`, `adwaita-icon-theme`, `aom`, `aribb24`, `assimp`, `at-spi2-core`, `autoconf`, `bdw-gc`, `berkeley-db@5`, `boost`, `cairo`, `capstone`, `ceres-solver`, `cffi`, `cgns`, `cjson`, `clisp`, `cmake`, `cpio`, `cunit`, `dav1d`, `dbus`, `desktop-file-utils`, `double-conversion`, `dtc`, `eigen`, `fontconfig`, `freetype`, `fribidi`, `gcc`, `gd`, `gdbm`, `gdk-pixbuf`, `gflags`, `ghostscript`, `giflib`, `glib`, `glog`, `graphite2`, `harfbuzz`, `hdf5`, `highway`, `hwloc`, `imath`, `isl`, `jasper`, `jbig2dec`, `jpeg-turbo`, `jpeg-xl`, `leptonica`, `libaec`, `libarchive`, `libavif`, `libb2`, `libde265`, `libdeflate`, `libheif`, `libidn`, `libmpc`, `libomp`, `libsigsegv`, `libtiff`, `libvmaf`, `libx11`, `libxau`, `libxcb`, `libxdmcp`, `libxext`, `libxfixes`, `libxi`, `libxrender`, `libxtst`, `little-cms2`, `lzo`, `metis`, `openblas`, `openexr`, `openjpeg`, `openjph`, `pango`, `pycparser`, `python-packaging`, `python-setuptools`, `python@3.13`, `shared-mime-info`, `suite-sparse`, `tbb`, `tesseract`, `webp`, `x265`, `xorgproto`.
- Explicitly requested: `openssl`, `sqlite`, `c-ares`.

## Non-Functional Requirements
- **Clean Configuration:** Keep the user's `home.nix` clean by using the separate `modules/packages.nix` file.
- **Idempotency:** The configuration should be apply-able multiple times without side effects.

## Acceptance Criteria
- [ ] `modules/packages.nix` is created as a Home Manager module.
- [ ] `modules/home.nix` imports `modules/packages.nix`.
- [ ] Packages found in Nixpkgs are listed in `modules/packages.nix`.
- [ ] Packages ONLY available in Homebrew are added to `homebrew.brews` in `flake.nix`.
- [ ] A `darwin-rebuild switch` runs successfully.
