# See
# https://discourse.nixos.org/t/how-to-write-a-universal-module-that-can-work-on-darwin-using-nix-darwin-nixos/11568/8
{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.my.foo;
in
{
  options = with lib; {
    my.foo = {
      enable = mkEnableOption ''
        Whether to enable foo module
      '';
    };
  };

  config =
    with lib;
    mkIf cfg.enable (mkMerge [
      (
        if (builtins.hasAttr "launchd" options) then
          {
            launchd.user.agents."foo" = {
              # some config
            };
          }
        else
          {
            # systemd
          }
      )
      {
        # shared stuff goes here
      }
    ]);
}
