# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{
  pkgs ? import <nixpkgs> { },
}:
let
  # NUR
  maintainer = import ./maintainers; # list of maintainers

  # Call package with the maintainer
  # This is a convenience function to avoid repeating the maintainer argument
  # in every package definition.
  callPackage = path: { }: pkgs.callPackage path { inherit maintainer; };
in
{

  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  example-package = pkgs.callPackage ./pkgs/example-package { };
  # some-qt5-package = pkgs.libsForQt5.callPackage ./pkgs/some-qt5-package { };
  # ...

  certstrap = callPackage ./pkgs/certstrap { };
  pangolin-installer = callPackage ./pkgs/pangolin-installer { };
}
