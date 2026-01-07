# Specification: Fix openfortivpn via Nix Migration

## Overview
**Goal:** Resolve the `dyld: Library not loaded: /opt/homebrew/opt/openssl@3/lib/libssl.3.dylib` error in `openfortivpn` by migrating the installation from Homebrew to Nix.

The current Homebrew installation is broken due to a missing `openssl@3` dependency. Migrating to a Nix-managed installation aligns with the project's "Nixpkgs First" strategy and ensures a reproducible environment where dependencies are correctly linked.

## Functional Requirements
1.  **Nix Installation:** Add `openfortivpn` to the declarative Nix configuration (likely `modules/packages.nix`).
2.  **Homebrew Cleanup:** Uninstall the existing `openfortivpn` package from Homebrew to prevent binary path conflicts.
3.  **System Rebuild:** Apply the updated `nix-darwin` configuration to install the tool and its dependencies (`openssl`, etc.) via Nix.

## Acceptance Criteria
1.  **Binary Accessibility:** `which openfortivpn` must return a Nix store path (e.g., `/run/current-system/sw/bin/openfortivpn`).
2.  **Execution Success:** Running `openfortivpn --version` must output the version information without any `dyld` or library loading errors.
3.  **Command Path:** Confirm that the Homebrew-managed binary at `/opt/homebrew/bin/openfortivpn` is either removed or superseded by the Nix version.

## Non-Functional Requirements
-   **Declarative Consistency:** The change must be made in the Nix modules to ensure reproducibility.
-   **Security:** The tool must remain functional with `sudo`, as required for managing network interfaces on macOS.

## Out of Scope
-   Automating VPN credentials or managing the `~/fortinet/csit` config file via Nix (keep as a manual user asset for now).
-   Fixing other unrelated Homebrew dependency issues.
