# Track Plan: Migrate yabai and skhd to Homebrew

## Phase 1: Preparation and Cleanup [checkpoint: 7159327]
This phase focuses on safely removing the existing Nix-managed setup to prevent conflicts.

- [x] Task: Disable yabai and skhd services in Nix configuration a652196
    - **Description:** Edit `modules/window-manager.nix` (or `flake.nix` and `home.nix`) to remove `services.yabai.enable = true` and `services.skhd.enable = true`, and remove the packages from `environment.systemPackages`.
    - **Step 1:** Locate the service definitions for yabai and skhd.
    - **Step 2:** Comment out or remove the configuration blocks and package additions.
    - **Step 3:** Rebuild the darwin configuration (`darwin-rebuild switch --flake .`) to apply changes.
    - **Verification:** Run `launchctl list | grep -E 'yabai|skhd'` to ensure the services are no longer running/loaded.

- [x] Task: Manually verify and kill lingering processes [shell-only]
    - **Description:** Ensure no orphan `yabai` or `skhd` processes are running.
    - **Step 1:** Run `pkill yabai` and `pkill skhd`.
    - **Step 2:** Check for any remaining launch agents/daemons in `~/Library/LaunchAgents` or `/Library/LaunchDaemons` that might have been left behind (though nix-darwin usually handles this).

## Phase 2: Homebrew Installation and Configuration
This phase handles the installation of the tools via Homebrew and setting up their services.

- [x] Task: Declare Homebrew packages in Nix (or install manually) 9c2ab6c
    - **Description:** We will use nix-darwin's `homebrew` module to manage these packages declaratively if possible, or instruct for manual installation if that's the user's preference for "latest" (since nix-managed brewfiles are good). Let's assume declarative management via `homebrew.brews`.
    - **Step 1:** In `flake.nix` (or a dedicated module), configure the `homebrew` section.
    - **Step 2:** Add `"yabai"` and `"skhd"` to the `homebrew.brews` list.
    - **Step 3:** Ensure `homebrew.taps` includes `koekeishiya/formulae` to get the latest versions.
    - **Step 4:** Rebuild the darwin configuration.
    - **Verification:** Run `brew list yabai` and `brew list skhd` to confirm installation.

- [ ] Task: Configure and Start Services
    - **Description:** Start the services using `yabai` and `skhd`'s service management (usually `brew services`).
    - **Step 1:** Run `yabai --start-service` (or `brew services start yabai`) and `skhd --start-service` (or `brew services start skhd`).
    - **Step 2:** Verify they are running with `brew services list`.

- [ ] Task: Restore/Link Configuration Files
    - **Description:** Ensure `~/.yabairc` and `~/.skhdrc` exist and are effective.
    - **Step 1:** If these files were symlinked by Nix, we need to ensure they are still managed by Home Manager or Nix, OR manually moved to the home directory if we are decoupling config management too (unlikely). We will assume we keep config management in Nix/Home Manager but point the files to `~/.config/yabai/yabairc` etc or `~/.yabairc`.
    - **Step 2:** Verify that the installed `yabai` and `skhd` are reading the correct config files.

- [ ] Task: Conductor - User Manual Verification 'Homebrew Installation and Configuration' (Protocol in workflow.md)
