let
  isReserved = n: n == "lib" || n == "overlays" || n == "modules";
  nameValuePair = n: v: {
    name = n;
    value = v;
  };
in
{
  default =
    final: prev:
    let
      nurAttrs = import ../default.nix { pkgs = prev; };
    in
    builtins.listToAttrs (
      map (n: nameValuePair n nurAttrs.${n}) (
        builtins.filter (n: !isReserved n) (builtins.attrNames nurAttrs)
      )
    );

  # Add your overlays here
  #
  inetutils = import ./inetutils-overlay.nix;
}
