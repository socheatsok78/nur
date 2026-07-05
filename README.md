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
git+file:///Users/socheat/Workspace/github.com/socheatsok78/nur
├───overlays
│   ├───default: Nixpkgs overlay
│   └───unfree: Nixpkgs overlay
└───packages
    └───supported-platforms
        ├───certstrap: package 'certstrap-1.3.0'
        ├───dsd-fme: package 'dsd-fme-2026-06-26'
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
