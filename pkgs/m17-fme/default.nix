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
  pversion = "2025-09-08";
  name = "${pname}-${pversion}";

  src = fetchFromGitHub {
    owner = "lwvmobile";
    repo = "m17-fme";
    rev = "13c93705ef988e8b3514a5bf83dc9cdded39ed79";
    sha256 = "sha256-v7/wL6WWFdIT187BTR7X7Fr5NygDZL8JbsrlRuLiXYw=";
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
