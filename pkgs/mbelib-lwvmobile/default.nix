{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
}:

stdenv.mkDerivation {
  pname = "mbelib-lwvmobile";
  version = "2022-08-25";

  src = fetchFromGitHub {
    owner = "lwvmobile";
    repo = "mbelib";
    rev = "30dc79074ca022366a27d705b8023011d9600339";
    sha256 = "sha256-Un7ojRj2SLk7glpR5HNYDBEm4RUrXVselA3CZYtE45E=";
  };

  nativeBuildInputs = [ cmake ];

  doCheck = true;

  meta = with lib; {
    description = "Full Rate and Half Rate Radio Vocoder";
    homepage = "https://github.com/lwvmobile/mbelib";
    license = licenses.isc;
    platforms = platforms.unix;
    maintainers = [ ];
  };
}
