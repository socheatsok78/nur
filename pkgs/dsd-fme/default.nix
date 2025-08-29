{
  lib,
  stdenv,
  cmake,
  fetchFromGitHub,
  mbelib,
  libsndfile,
  itpp,
  ncurses,
  rtl-sdr,
  codec2,
  pkg-config,
  pulseaudioSupport ? !stdenv.hostPlatform.isDarwin,
  libpulseaudio,
  portaudioSupport ? stdenv.hostPlatform.isDarwin,
  portaudio,
}:

assert portaudioSupport -> portaudio != null;

stdenv.mkDerivation {
  name = "dsd-fme";

  src = fetchFromGitHub {
    owner = "lwvmobile";
    repo = "dsd-fme";
    rev = "bd75c1ab83152496897b50bc1b72f2945c750d8f";
    sha256 = "sha256-Hj6wEvwnm5zuQdktIWmtAi0IyGbFVpTfCh890BXwzbg=";
  };

  patches = [
    ./disable_oss_darwin.patch
  ];

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    mbelib
    libsndfile
    itpp
    rtl-sdr
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
