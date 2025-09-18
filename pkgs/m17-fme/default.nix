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
  pversion = "2025-09-15";
  name = "${pname}-${pversion}";

  src = fetchFromGitHub {
    owner = "lwvmobile";
    repo = "m17-fme";
    rev = "20474be849c9b3d4a383bf5fe16ecb1177fbd52c";
    sha256 = "sha256-QkSNMUn5Nelns92Z0Kc4bsa/sLnO4mEl+OILaM0bz6M=";
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
