# Cross-platform packages shared between macOS and Linux
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Development tools
    gcc
    cmake
    autoconf
    nodejs
    python313
    go
    clisp

    # Python packages
    python3Packages.cffi
    python3Packages.packaging
    python3Packages.pycparser
    python3Packages.setuptools

    # CLI tools
    bat
    eza
    tree
    lazygit
    direnv

    # Build dependencies
    abseil-cpp
    boost
    c-ares
    double-conversion
    gflags
    glog
    metis
    tbb

    # Cryptography & compression
    openssl
    openssl.out
    lzo
    libb2
    libdeflate
    boehmgc

    # Scientific computing
    eigen
    ceres-solver
    openblas
    hdf5
    suitesparse
    imath
    cgns
    hwloc
    libaec

    # Image processing
    tesseract
    leptonica
    ghostscript
    libwebp
    libjpeg_turbo
    libtiff
    giflib
    jasper
    libavif
    libaom
    libheif
    libde265
    libjxl
    libhwy
    libvmaf
    openjpeg
    openjph
    jbig2dec
    gd
    lcms2
    openexr
    x265
    dav1d
    aribb24

    # Font rendering & text
    fontconfig
    freetype
    harfbuzz
    graphite2
    fribidi
    pango
    cairo

    # General libraries
    glib
    libarchive
    libidn
    libmpc
    libsigsegv
    isl
    sqlite
    gdbm
    db
    cjson
    cunit
    cpio
    dtc
    capstone
    assimp
    llvmPackages.openmp

    # Networking
    openfortivpn

    # Language server
    copilot-language-server
  ];
}
