# Override inetutils to version 2.6
# Due to build issues with Darwin systems
# https://github.com/NixOS/nixpkgs/issues/488689#issuecomment-3885811713
final: prev: {
  inetutils = prev.inetutils.overrideAttrs (attrs: rec {
    version = "2.6";
    src = prev.fetchurl {
      url = "mirror://gnu/${attrs.pname}/${attrs.pname}-${version}.tar.xz";
      hash = "sha256-aL7b/q9z99hr4qfZm8+9QJPYKfUncIk5Ga4XTAsjV8o=";
    };
  });
}
