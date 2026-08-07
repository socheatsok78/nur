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

[1mgit+file:///Users/socheat/Workspace/github.com/socheatsok78/nur[0m
[32;1m├───[0m[1mchecks[0m
[32;1m│   ├───[0m[1maarch64-darwin[0m
[32;1m│   │   ├───[0m[1mcertstrap[0m: derivation 'certstrap-1.3.0'
[32;1m│   │   ├───[0m[1mdsd-fme[0m: derivation 'dsd-fme-2026-07-11'
[32;1m│   │   ├───[0m[1mitpp[0m: derivation 'it++-4.3.1'
[32;1m│   │   ├───[0m[1mlibpulseaudio[0m: derivation 'libpulseaudio-17.0'
[32;1m│   │   ├───[0m[1mm17-fme[0m: derivation 'm17-fme-2026-01-26'
[32;1m│   │   ├───[0m[1mmbelib[0m: derivation 'mbelib-1.3.0'
[32;1m│   │   ├───[0m[1mmbelib-lwvmobile[0m: derivation 'mbelib-lwvmobile-2022-08-25'
[32;1m│   │   ├───[0m[1mpulseaudio[0m: derivation 'pulseaudio-17.0'
[32;1m│   │   ├───[0m[1mpulseaudioFull[0m: derivation 'pulseaudio-17.0'
[32;1m│   │   ├───[0m[1msdr-server[0m: derivation 'sdr-server-2025-11-23'
[32;1m│   │   ├───[0m[1msdrpp-brown[0m: derivation 'sdrpp-brown-1.2.1-2026-05-08'
[32;1m│   │   └───[0m[1msdrpp-brown-server[0m: derivation 'sdrpp-brown-1.2.1-2026-05-08'
[32;1m│   ├───[0m[1maarch64-linux[0m
[32;1m│   │   ├───[0m[1mcertstrap[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1mdsd-fme[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1mitpp[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1mlibpulseaudio[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1mm17-fme[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1mmbelib[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1mmbelib-lwvmobile[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1mpulseaudio[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1mpulseaudioFull[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1msdr-server[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1msdrpp-brown[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   └───[0m[1msdrpp-brown-server[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   ├───[0m[1mx86_64-darwin[0m
[32;1m│   │   ├───[0m[1mcertstrap[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1mdsd-fme[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1mitpp[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1mlibpulseaudio[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1mm17-fme[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1mmbelib[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1mmbelib-lwvmobile[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1mpulseaudio[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1mpulseaudioFull[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1msdr-server[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   ├───[0m[1msdrpp-brown[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   │   └───[0m[1msdrpp-brown-server[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   └───[0m[1mx86_64-linux[0m
[32;1m│       ├───[0m[1mcertstrap[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│       ├───[0m[1mdsd-fme[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│       ├───[0m[1mitpp[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│       ├───[0m[1mlibpulseaudio[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│       ├───[0m[1mm17-fme[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│       ├───[0m[1mmbelib[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│       ├───[0m[1mmbelib-lwvmobile[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│       ├───[0m[1mpulseaudio[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│       ├───[0m[1mpulseaudioFull[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│       ├───[0m[1msdr-server[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│       ├───[0m[1msdrpp-brown[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│       └───[0m[1msdrpp-brown-server[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m├───[0m[1mdarwinModules[0m: [35;1munknown[0m
[32;1m├───[0m[1mformatter[0m
[32;1m│   ├───[0m[1maarch64-darwin[0m: package 'nixfmt-tree-2.5.0'
[32;1m│   ├───[0m[1maarch64-linux[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   ├───[0m[1mx86_64-darwin[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m│   └───[0m[1mx86_64-linux[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m├───[0m[1mlegacyPackages[0m
[32;1m│   ├───[0m[1maarch64-darwin[0m [35;1momitted[0m (use '--legacy' to show)
[32;1m│   ├───[0m[1maarch64-linux[0m [35;1momitted[0m (use '--legacy' to show)
[32;1m│   ├───[0m[1marmv6l-linux[0m [35;1momitted[0m (use '--legacy' to show)
[32;1m│   ├───[0m[1marmv7l-linux[0m [35;1momitted[0m (use '--legacy' to show)
[32;1m│   ├───[0m[1mi686-linux[0m [35;1momitted[0m (use '--legacy' to show)
[32;1m│   ├───[0m[1mpowerpc64le-linux[0m [35;1momitted[0m (use '--legacy' to show)
[32;1m│   ├───[0m[1mriscv64-linux[0m [35;1momitted[0m (use '--legacy' to show)
[32;1m│   ├───[0m[1mx86_64-darwin[0m [35;1momitted[0m (use '--legacy' to show)
[32;1m│   ├───[0m[1mx86_64-freebsd[0m [35;1momitted[0m (use '--legacy' to show)
[32;1m│   └───[0m[1mx86_64-linux[0m [35;1momitted[0m (use '--legacy' to show)
[32;1m├───[0m[1moverlays[0m
[32;1m│   ├───[0m[1mdefault[0m: [35;1mNixpkgs overlay[0m
[32;1m│   ├───[0m[1minetutils[0m: [35;1mNixpkgs overlay[0m
[32;1m│   └───[0m[1munfree[0m: [35;1mNixpkgs overlay[0m
[32;1m└───[0m[1mpackages[0m
[32;1m    ├───[0m[1maarch64-darwin[0m
[32;1m    │   ├───[0m[1mcertstrap[0m: package 'certstrap-1.3.0'
[32;1m    │   ├───[0m[1mdsd-fme[0m: package 'dsd-fme-2026-07-11'
[32;1m    │   ├───[0m[1mitpp[0m: package 'it++-4.3.1'
[32;1m    │   ├───[0m[1mlibpulseaudio[0m: package 'libpulseaudio-17.0'
[32;1m    │   ├───[0m[1mm17-fme[0m: package 'm17-fme-2026-01-26'
[32;1m    │   ├───[0m[1mmbelib[0m: package 'mbelib-1.3.0'
[32;1m    │   ├───[0m[1mmbelib-lwvmobile[0m: package 'mbelib-lwvmobile-2022-08-25'
[32;1m    │   ├───[0m[1mpulseaudio[0m: package 'pulseaudio-17.0'
[32;1m    │   ├───[0m[1mpulseaudioFull[0m: package 'pulseaudio-17.0'
[32;1m    │   ├───[0m[1msdr-server[0m: package 'sdr-server-2025-11-23'
[32;1m    │   ├───[0m[1msdrpp-brown[0m: package 'sdrpp-brown-1.2.1-2026-05-08'
[32;1m    │   └───[0m[1msdrpp-brown-server[0m: package 'sdrpp-brown-1.2.1-2026-05-08'
[32;1m    ├───[0m[1maarch64-linux[0m
[32;1m    │   ├───[0m[1mcertstrap[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1mdsd-fme[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1mitpp[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1mlibpulseaudio[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1mm17-fme[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1mmbelib[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1mmbelib-lwvmobile[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1mpulseaudio[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1mpulseaudioFull[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1msdr-server[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1msdrpp-brown[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   └───[0m[1msdrpp-brown-server[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    ├───[0m[1mx86_64-darwin[0m
[32;1m    │   ├───[0m[1mcertstrap[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1mdsd-fme[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1mitpp[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1mlibpulseaudio[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1mm17-fme[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1mmbelib[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1mmbelib-lwvmobile[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1mpulseaudio[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1mpulseaudioFull[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1msdr-server[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   ├───[0m[1msdrpp-brown[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    │   └───[0m[1msdrpp-brown-server[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m    └───[0m[1mx86_64-linux[0m
[32;1m        ├───[0m[1mcertstrap[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m        ├───[0m[1mdsd-fme[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m        ├───[0m[1mitpp[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m        ├───[0m[1mlibpulseaudio[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m        ├───[0m[1mm17-fme[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m        ├───[0m[1mmbelib[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m        ├───[0m[1mmbelib-lwvmobile[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m        ├───[0m[1mpulseaudio[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m        ├───[0m[1mpulseaudioFull[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m        ├───[0m[1msdr-server[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m        ├───[0m[1msdrpp-brown[0m [35;1momitted[0m (use '--all-systems' to show)
[32;1m        └───[0m[1msdrpp-brown-server[0m [35;1momitted[0m (use '--all-systems' to show)
```

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

