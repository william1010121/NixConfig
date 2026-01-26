# macOS host configuration for william-2
{ config, pkgs, lib, self, ... }:

{
  # Set Git commit hash for darwin-version
  system.configurationRevision = self.rev or self.dirtyRev or null;
}
