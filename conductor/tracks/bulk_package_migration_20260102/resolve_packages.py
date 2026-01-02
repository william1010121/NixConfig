import json
import subprocess
import sys

def resolve_packages():
    with open('conductor/tracks/bulk_package_migration_20260102/packages_list.txt', 'r') as f:
        packages = [line.strip() for line in f if line.strip()]

    # Manual mappings for known Homebrew -> Nixpkgs differences
    mappings = {
        "berkeley-db@5": "db",
        "python@3.13": "python313",
        "bdw-gc": "boehmgc",
        "cjson": "cJSON", # Case sensitive
        "pkg-config": "pkg-config", 
        "little-cms2": "lcms2",
        "desktop-file-utils": "desktop-file-utils",
        "shared-mime-info": "shared-mime-info",
        "gdk-pixbuf": "gdk-pixbuf",
        "at-spi2-core": "at-spi2-core",
        "adwaita-icon-theme": "adwaita-icon-theme",
        "xorgproto": "xorg.xorgproto",
        "libx11": "xorg.libX11",
        "libxau": "xorg.libXau",
        "libxcb": "xorg.libXcb",
        "libxdmcp": "xorg.libXdmcp",
        "libxext": "xorg.libXext",
        "libxfixes": "xorg.libXfixes",
        "libxi": "xorg.libXi",
        "libxrender": "xorg.libXrender",
        "libxtst": "xorg.libXtst",
        "libtiff": "libtiff",
        "libjpeg-turbo": "libjpeg",
        "jpeg-turbo": "libjpeg_turbo",
        "pango": "pango",
        "cairo": "cairo",
        "harfbuzz": "harfbuzz",
        "fontconfig": "fontconfig",
        "freetype": "freetype",
        "fribidi": "fribidi",
        "glib": "glib",
        "openssl": "openssl",
        "sqlite": "sqlite",
        "c-ares": "c-ares",
        "libarchive": "libarchive",
        "cmake": "cmake",
        "autoconf": "autoconf",
        "boost": "boost",
        "eigen": "eigen",
        "gflags": "gflags",
        "glog": "glog",
        "protobuf": "protobuf",
        "abseil": "abseil-cpp",
        "assimp": "assimp",
        "ceres-solver": "ceres-solver",
        "double-conversion": "double-conversion",
        "tbb": "tbb",
        "suite-sparse": "suitesparse",
        "metis": "metis",
        "openblas": "openblas",
        "hdf5": "hdf5",
        "hwloc": "hwloc",
        "imath": "imath",
        "openexr": "openexr",
        "lzo": "lzo",
        "bzip2": "bzip2",
        "xz": "xz",
        "zlib": "zlib",
        "zstd": "zstd",
        "libdeflate": "libdeflate",
        "libpng": "libpng",
        "libwebp": "libwebp",
        "webp": "libwebp",
        "jpeg-xl": "libjxl",
        "openjpeg": "openjpeg",
        "dav1d": "dav1d",
        "aom": "aom",
        "libavif": "libavif",
        "libheif": "libheif",
        "libde265": "libde265",
        "x265": "x265",
        "libvmaf": "libvmaf",
        "highway": "highway",
        "tesseract": "tesseract",
        "leptonica": "leptonica",
        "ghostscript": "ghostscript",
        "jbig2dec": "jbig2dec",
        "qpdf": "qpdf",
        "poppler": "poppler",
        "imagemagick": "imagemagick",
        "graphicsmagick": "graphicsmagick",
        "ffmpeg": "ffmpeg",
        "capstone": "capstone",
        "dtc": "dtc",
        "libb2": "libb2",
        "libidn": "libidn",
        "libmpc": "libmpc",
        "libomp": "llvmPackages.openmp",
        "libsigsegv": "libsigsegv",
        "clisp": "clisp",
        "cunit": "cunit",
        "check": "check",
        "cppunit": "cppunit",
        "gtest": "gtest",
        "graphite2": "graphite2",
        "isl": "isl",
        "jasper": "jasper",
        "libaec": "libaec",
        "openjph": "openjph",
        "python-packaging": "python3Packages.packaging",
        "python-setuptools": "python3Packages.setuptools",
        "cffi": "python3Packages.cffi",
        "pycparser": "python3Packages.pycparser",
    }
    
    nix_list = []
    for p in packages:
        if p in mappings:
            nix_list.append(f'{{ name = "{p}"; attr = "{mappings[p]}"; }}')
        else:
            nix_list.append(f'{{ name = "{p}"; attr = "{p}"; }}')

    nix_expr = f'''
    let
      pkgs = import <nixpkgs> {{ system = "aarch64-darwin"; config.allowUnfree = true; }};
      lib = pkgs.lib;
      candidates = [
        {' '.join(nix_list)}
      ];
      check = c:
        let 
          path = lib.splitString "." c.attr;
          found = lib.hasAttrByPath path pkgs;
        in
        {{
            original = c.name; 
            attr = c.attr; 
            found = found; 
        }};
    in
      builtins.map check candidates
    '''
    
    try:
        cmd = ['nix', 'eval', '--impure', '--json', '--expr', nix_expr]
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
        results = json.loads(result.stdout)
        
        found = []
        missing = []
        
        for r in results:
            if r['found']:
                found.append(f"Nixpkgs: {r['attr']} (was {r['original']})")
            else:
                missing.append(r['original'])

        with open('conductor/tracks/bulk_package_migration_20260102/mapping_report.txt', 'w') as f:
            f.write("--- FOUND IN NIXPKGS ---\n")
            for item in found:
                f.write(item + "\n")
            f.write("\n--- MISSING / NEEDS HOMEBREW OR FURTHER SEARCH ---\n")
            for item in missing:
                f.write(item + "\n")
        
        print(f"Mapping complete. Found {len(found)}, Missing {len(missing)}.")
        
    except subprocess.CalledProcessError as e:
        print(f"Error running nix-instantiate: {e.stderr}")
    except Exception as e:
        print(f"Error: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    resolve_packages()