let
  isReserved =
    n:
    n == "lib"
    || n == "overlays"
    || n == "nixosModules"
    || n == "homeModules"
    || n == "darwinModules"
    || n == "flakeModules";
  nameValuePair = n: v: {
    name = n;
    value = v;
  };

  # This is a list of packages that are overridden in this overlay. These packages will not be included in the default package set.
  isOverridedPackage = n: n == "pulseaudio" || n == "pulseaudioFull" || n == "libpulseaudio";
in
{
  default =
    final: prev:
    let
      nurAttrs = import ../default.nix { pkgs = prev; };
    in
    builtins.listToAttrs (
      map (n: nameValuePair n nurAttrs.${n}) (
        builtins.filter (n: !isReserved n && !isOverridedPackage n) (builtins.attrNames nurAttrs)
      )
    );
  unfree =
    final: prev:
    let
      unfree = import ./unfree.nix { pkgs = prev; };
    in
    builtins.listToAttrs (
      map (n: nameValuePair n unfree.${n}) (
        builtins.filter (n: !isReserved n) (builtins.attrNames unfree)
      )
    );

  # Add your overlays here
  #
  inetutils = import ./inetutils-overlay.nix;
}
