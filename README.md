## About

[@socheatsok78](https://github.com/socheatsok78)'s Nix User Repository

[![Build and populate cache](https://github.com/socheatsok78/nur/actions/workflows/build.yml/badge.svg)](https://github.com/socheatsok78/nur/actions/workflows/build.yml)

## Usage

**List of available packages:**

```bash
nix flake show github:socheatsok78/nur
```

## Flake

To use this repository as a flake, add the following to your `flake.nix`:

```nix
{
  inputs = {
    nixpkgs = {
        # Set your preferred Nixpkgs version here
    };
    socheatsok78-nur = {
      url = "github:socheatsok78/nur/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nur, ... }: {

    # NixOS module
    nixosConfigurations = {
      hostname = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            nixpkgs.overlays = [ socheatsok78-nur.overlays.default ];
          }
          # ...
        ];
      };
    };

    # nix-darwin module
    darwinConfigurations = {
      hostname = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          {
            nixpkgs.overlays = [ socheatsok78-nur.overlays.default ];
          }
          # ...
        ];
      };
    };

  };
}
```

## Packages

```sh
$ nix flake show

git+file:///Users/socheat/Workspace/github.com/socheatsok78/nur
├───checks
│   ├───aarch64-darwin
│   │   ├───certstrap: derivation 'certstrap-1.3.0'
│   │   ├───dsd-fme: derivation 'dsd-fme-2026-07-11'
│   │   ├───itpp: derivation 'it++-4.3.1'
│   │   ├───libpulseaudio: derivation 'libpulseaudio-17.0'
│   │   ├───m17-fme: derivation 'm17-fme-2026-01-26'
│   │   ├───mbelib: derivation 'mbelib-1.3.0'
│   │   ├───mbelib-lwvmobile: derivation 'mbelib-lwvmobile-2022-08-25'
│   │   ├───pulseaudio: derivation 'pulseaudio-17.0'
│   │   ├───pulseaudioFull: derivation 'pulseaudio-17.0'
│   │   ├───sdr-server: derivation 'sdr-server-2025-11-23'
│   │   ├───sdrpp-brown: derivation 'sdrpp-brown-1.2.1-2026-05-08'
│   │   └───sdrpp-brown-server: derivation 'sdrpp-brown-1.2.1-2026-05-08'
│   ├───aarch64-linux
│   │   ├───certstrap: derivation 'certstrap-1.3.0'
│   │   ├───dsd-fme: derivation 'dsd-fme-2026-07-11'
│   │   ├───itpp: derivation 'it++-4.3.1'
│   │   ├───libpulseaudio: derivation 'libpulseaudio-17.0'
│   │   ├───m17-fme: derivation 'm17-fme-2026-01-26'
│   │   ├───mbelib: derivation 'mbelib-1.3.0'
│   │   ├───mbelib-lwvmobile: derivation 'mbelib-lwvmobile-2022-08-25'
│   │   ├───pulseaudio: derivation 'pulseaudio-17.0'
│   │   ├───pulseaudioFull: derivation 'pulseaudio-17.0'
│   │   ├───sdr-server: derivation 'sdr-server-2025-11-23'
│   │   ├───sdrpp-brown: derivation 'sdrpp-brown-1.2.1-2026-05-08'
│   │   └───sdrpp-brown-server: derivation 'sdrpp-brown-1.2.1-2026-05-08'
│   ├───x86_64-darwin
│   │   ├───certstrap: derivation 'certstrap-1.3.0'
│   │   ├───dsd-fme: derivation 'dsd-fme-2026-07-11'
│   │   ├───itpp: derivation 'it++-4.3.1'
│   │   ├───libpulseaudio: derivation 'libpulseaudio-17.0'
│   │   ├───m17-fme: derivation 'm17-fme-2026-01-26'
│   │   ├───mbelib: derivation 'mbelib-1.3.0'
│   │   ├───mbelib-lwvmobile: derivation 'mbelib-lwvmobile-2022-08-25'
│   │   ├───pulseaudio: derivation 'pulseaudio-17.0'
│   │   ├───pulseaudioFull: derivation 'pulseaudio-17.0'
│   │   ├───sdr-server: derivation 'sdr-server-2025-11-23'
│   │   ├───sdrpp-brown: derivation 'sdrpp-brown-1.2.1-2026-05-08'
│   │   └───sdrpp-brown-server: derivation 'sdrpp-brown-1.2.1-2026-05-08'
│   └───x86_64-linux
│       ├───certstrap: derivation 'certstrap-1.3.0'
│       ├───dsd-fme: derivation 'dsd-fme-2026-07-11'
│       ├───itpp: derivation 'it++-4.3.1'
│       ├───libpulseaudio: derivation 'libpulseaudio-17.0'
│       ├───m17-fme: derivation 'm17-fme-2026-01-26'
│       ├───mbelib: derivation 'mbelib-1.3.0'
│       ├───mbelib-lwvmobile: derivation 'mbelib-lwvmobile-2022-08-25'
│       ├───pulseaudio: derivation 'pulseaudio-17.0'
│       ├───pulseaudioFull: derivation 'pulseaudio-17.0'
│       ├───sdr-server: derivation 'sdr-server-2025-11-23'
│       ├───sdrpp-brown: derivation 'sdrpp-brown-1.2.1-2026-05-08'
│       └───sdrpp-brown-server: derivation 'sdrpp-brown-1.2.1-2026-05-08'
├───darwinModules: unknown
├───formatter
│   ├───aarch64-darwin: package 'nixfmt-tree-2.5.0'
│   ├───aarch64-linux: package 'nixfmt-tree-2.5.0'
│   ├───x86_64-darwin: package 'nixfmt-tree-2.5.0'
│   └───x86_64-linux: package 'nixfmt-tree-2.5.0'
├───legacyPackages
│   ├───aarch64-darwin omitted (use '--legacy' to show)
│   ├───aarch64-linux omitted (use '--legacy' to show)
│   ├───armv6l-linux omitted (use '--legacy' to show)
│   ├───armv7l-linux omitted (use '--legacy' to show)
│   ├───i686-linux omitted (use '--legacy' to show)
│   ├───powerpc64le-linux omitted (use '--legacy' to show)
│   ├───riscv64-linux omitted (use '--legacy' to show)
│   ├───x86_64-darwin omitted (use '--legacy' to show)
│   ├───x86_64-freebsd omitted (use '--legacy' to show)
│   └───x86_64-linux omitted (use '--legacy' to show)
├───overlays
│   ├───default: Nixpkgs overlay
│   ├───inetutils: Nixpkgs overlay
│   └───unfree: Nixpkgs overlay
└───packages
    ├───aarch64-darwin
    │   ├───certstrap: package 'certstrap-1.3.0'
    │   ├───dsd-fme: package 'dsd-fme-2026-07-11'
    │   ├───itpp: package 'it++-4.3.1'
    │   ├───libpulseaudio: package 'libpulseaudio-17.0'
    │   ├───m17-fme: package 'm17-fme-2026-01-26'
    │   ├───mbelib: package 'mbelib-1.3.0'
    │   ├───mbelib-lwvmobile: package 'mbelib-lwvmobile-2022-08-25'
    │   ├───pulseaudio: package 'pulseaudio-17.0'
    │   ├───pulseaudioFull: package 'pulseaudio-17.0'
    │   ├───sdr-server: package 'sdr-server-2025-11-23'
    │   ├───sdrpp-brown: package 'sdrpp-brown-1.2.1-2026-05-08'
    │   └───sdrpp-brown-server: package 'sdrpp-brown-1.2.1-2026-05-08'
    ├───aarch64-linux
    │   ├───certstrap: package 'certstrap-1.3.0'
    │   ├───dsd-fme: package 'dsd-fme-2026-07-11'
    │   ├───itpp: package 'it++-4.3.1'
    │   ├───libpulseaudio: package 'libpulseaudio-17.0'
    │   ├───m17-fme: package 'm17-fme-2026-01-26'
    │   ├───mbelib: package 'mbelib-1.3.0'
    │   ├───mbelib-lwvmobile: package 'mbelib-lwvmobile-2022-08-25'
    │   ├───pulseaudio: package 'pulseaudio-17.0'
    │   ├───pulseaudioFull: package 'pulseaudio-17.0'
    │   ├───sdr-server: package 'sdr-server-2025-11-23'
    │   ├───sdrpp-brown: package 'sdrpp-brown-1.2.1-2026-05-08'
    │   └───sdrpp-brown-server: package 'sdrpp-brown-1.2.1-2026-05-08'
    ├───x86_64-darwin
    │   ├───certstrap: package 'certstrap-1.3.0'
    │   ├───dsd-fme: package 'dsd-fme-2026-07-11'
    │   ├───itpp: package 'it++-4.3.1'
    │   ├───libpulseaudio: package 'libpulseaudio-17.0'
    │   ├───m17-fme: package 'm17-fme-2026-01-26'
    │   ├───mbelib: package 'mbelib-1.3.0'
    │   ├───mbelib-lwvmobile: package 'mbelib-lwvmobile-2022-08-25'
    │   ├───pulseaudio: package 'pulseaudio-17.0'
    │   ├───pulseaudioFull: package 'pulseaudio-17.0'
    │   ├───sdr-server: package 'sdr-server-2025-11-23'
    │   ├───sdrpp-brown: package 'sdrpp-brown-1.2.1-2026-05-08'
    │   └───sdrpp-brown-server: package 'sdrpp-brown-1.2.1-2026-05-08'
    └───x86_64-linux
        ├───certstrap: package 'certstrap-1.3.0'
        ├───dsd-fme: package 'dsd-fme-2026-07-11'
        ├───itpp: package 'it++-4.3.1'
        ├───libpulseaudio: package 'libpulseaudio-17.0'
        ├───m17-fme: package 'm17-fme-2026-01-26'
        ├───mbelib: package 'mbelib-1.3.0'
        ├───mbelib-lwvmobile: package 'mbelib-lwvmobile-2022-08-25'
        ├───pulseaudio: package 'pulseaudio-17.0'
        ├───pulseaudioFull: package 'pulseaudio-17.0'
        ├───sdr-server: package 'sdr-server-2025-11-23'
        ├───sdrpp-brown: package 'sdrpp-brown-1.2.1-2026-05-08'
        └───sdrpp-brown-server: package 'sdrpp-brown-1.2.1-2026-05-08'
```

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

