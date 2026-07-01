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

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
