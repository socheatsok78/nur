{
  description = "@socheatsok78 personal NUR repository";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      forAllSupportedSystems = nixpkgs.lib.genAttrs supportedSystems;
      # forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;

      # modules = import ./modules; # NixOS modules
      overlays = import ./overlays; # nixpkgs overlays
    in
    {
      # modules = modules;
      overlays = {
        default = overlays;
      };
      packages = forAllSupportedSystems (
        system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system}
      );
      legacyPackages = forAllSupportedSystems (
        system: import ./default.nix {
          pkgs = import nixpkgs { inherit system; };
        }
      );
    };
}
