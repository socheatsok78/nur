{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
}:

stdenv.mkDerivation {
  pname = "mbelib";
  version = "2022-08-25";

  src = fetchFromGitHub {
    owner = "lwvmobile";
    repo = "mbelib";
    rev = "30dc79074ca022366a27d705b8023011d9600339";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  nativeBuildInputs = [ cmake ];

  doCheck = true;

  meta = with lib; {
    description = "P25 Phase 1 and ProVoice vocoder";
    homepage = "https://github.com/szechyjs/mbelib";
    license = licenses.isc;
    platforms = platforms.unix;
    maintainers = [ ];
  };
}
