# This overlay is used to override the license of the Vault package in Nixpkgs.
#
# This is to remove the "--impure" requirement when building Vault,which is necessary for some use cases.
# which really annoying for my personal use case.
final: prev: {
  vault = prev.vault.overrideAttrs (attrs: {
    meta.license = prev.lib.licenses.mpl-2.0;
  });
}
