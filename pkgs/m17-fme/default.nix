{
  lib,
  stdenv,
  cmake,
  fetchFromGitHub,
  libsndfile,
  itpp,
  ncurses,
  socat,
  codec2,
  pkg-config,
  pulseaudioSupport ? !stdenv.hostPlatform.isDarwin,
  libpulseaudio,
}:

assert pulseaudioSupport -> libpulseaudio != null;

stdenv.mkDerivation rec {
  pname = "m17-fme";
  pversion = "2025-08-26";
  name = "${pname}-${pversion}";

  src = fetchFromGitHub {
    owner = "lwvmobile";
    repo = "m17-fme";
    rev = "c9096a1c7539876af267069f98dc664f0b961892";
    sha256 = "sha256-1ceKEUgnCf000b89MFG0NIhhfVzV0QBLdLPwdcBvPg0=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    libsndfile
    itpp
    ncurses.dev
    pkg-config
    codec2
    socat
  ]
  ++ lib.optionals pulseaudioSupport [ libpulseaudio ];

  doCheck = true;

  meta = with lib; {
    description = "M17 Project - Florida Man Edition";
    longDescription = ''
      Standalone M17 Project Voice and Data Packet Encoder and Decoder
    '';
    homepage = "https://github.com/lwvmobile/m17-fme";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
