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
  sdrpp-brown = pkgs.callPackage ./pkgs/sdrpp-brown {
    inherit libpulseaudio;
  };
  sdrpp-brown-server = sdrpp-brown.override {
    # Backend
    glfw_backend = false;

    # Sinks
    android_audio_sink = false;
    audio_sink = false;
    network_sink = false;
    mpeg_adts_sink = false;
    portaudio_sink = false;
    legacy_portaudio_sink = false;

    # Decoders
    atv_decoder = false;
    dab_decoder = false;
    falcon9_decoder = false;
    kg_sstv_decoder = false;
    m17_decoder = false;
    ch_extravhf_decoder = false;
    ch_tetra_demodulator = false;
    ft8_decoder = false;
    dsdcc_decoder = false;
    meteor_demodulator = false;
    pager_decoder = false;
    radio = false;
    ryfi_decoder = false;
    vor_receiver = false;
    weather_sat_decoder = false;

    # Misc
    discord_presence = false;
    frequency_manager = false;
    iq_exporter = false;
    recorder = false;
    rigctl_client = false;
    rigctl_server = false;
    tci_server = false;
    scanner = false;
    scheduler = false;
    noise_reduction_logmmse = false;
  };

  # The packages below has been deprecated from upstream nixpkgs
  # so we keep them here for legacy purpose.
  itpp = pkgs.callPackage ./pkgs/itpp { };
}
