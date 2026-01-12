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
rec {
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  # Packages
  certstrap = pkgs.callPackage ./pkgs/certstrap { };
  dsd-fme = pkgs.callPackage ./pkgs/dsd-fme {
    inherit libpulseaudio mbelib-lwvmobile;
    pulseaudioSupport = true;
  };
  fosrl-installer = pkgs.callPackage ./pkgs/fosrl-installer { };
  libpulseaudio = pulseaudio.override {
    libOnly = true;
  };
  m17-fme = pkgs.callPackage ./pkgs/m17-fme {
    inherit libpulseaudio;
    pulseaudioSupport = true;
  };
  mbelib = pkgs.callPackage ./pkgs/mbelib { };
  mbelib-lwvmobile = pkgs.callPackage ./pkgs/mbelib-lwvmobile { };
  pulseaudio = pkgs.callPackage ./pkgs/pulseaudio { };
  pulseaudioFull = pulseaudio.override {
    jackaudioSupport = true;
    airtunesSupport = true;
    bluetoothSupport = !pkgs.stdenv.hostPlatform.isDarwin;
    advancedBluetoothCodecs = !pkgs.stdenv.hostPlatform.isDarwin;
    remoteControlSupport = !pkgs.stdenv.hostPlatform.isDarwin;
    zeroconfSupport = true;
  };
  sdr-server = pkgs.callPackage ./pkgs/sdr-server { };
}
