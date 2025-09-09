{
  lib,
  stdenv,
  cmake,
  fetchFromGitHub,
  mbelib-lwvmobile,
  libsndfile,
  itpp,
  ncurses,
  rtl-sdr-osmocom,
  codec2,
  pkg-config,
  pulseaudioSupport ? !stdenv.hostPlatform.isDarwin,
  libpulseaudio,
  portaudioSupport ? stdenv.hostPlatform.isDarwin,
  portaudio,
}:

assert pulseaudioSupport -> libpulseaudio != null;
assert portaudioSupport -> portaudio != null;

stdenv.mkDerivation rec {
  pname = "dsd-fme";
  pversion = "2025-09-02";
  name = "${pname}-${pversion}";

  src = fetchFromGitHub {
    owner = "lwvmobile";
    repo = "dsd-fme";
    rev = "9acd8c981e56096197a198df5bfa5c8e5cfbaa3a";
    sha256 = "sha256-AG/FofwdHohH5WWMQc33Q2y/tHUnWsfLJQ8qn0ksAc0=";
  };

  patches = [
    ./disable_oss_darwin.patch
  ];

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    mbelib-lwvmobile
    libsndfile
    itpp
    rtl-sdr-osmocom
    ncurses.dev
    pkg-config
    codec2
  ]
  ++ lib.optionals pulseaudioSupport [ libpulseaudio ]
  ++ lib.optionals portaudioSupport [ portaudio ];

  # cmakeFlags = [
  #   "-DCMAKE_CXX_FLAGS=-std=c++14"
  # ];

  doCheck = true;

  meta = with lib; {
    description = "Digital Speech Decoder - Florida Man Edition";
    longDescription = ''
      DSD is able to decode several digital voice formats from discriminator
      tap audio and synthesize the decoded speech. Speech synthesis requires
      mbelib, which is a separate package.
    '';
    homepage = "https://github.com/szechyjs/dsd";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
