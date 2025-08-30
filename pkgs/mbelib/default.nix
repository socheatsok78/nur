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
    rev = "34adf9f054bc5650ace162a4917dcbc2cfa6102e";
    sha256 = "sha256-j/P+KMIN6PqMnUHfcNmAOdHPXWnJm8P3jVmWK5smQPw=";
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
