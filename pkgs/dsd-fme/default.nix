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
  pversion = "2025-09-22";
  name = "${pname}-${pversion}";

  rev = "748bb5b1910188407a1004f2c607b536428701c9";
  src = fetchFromGitHub {
    owner = "lwvmobile";
    repo = "dsd-fme";
    rev = rev;
    sha256 = "sha256-sBO6t/ad6ebTmOPywfMFISe51vPvsPUrSFB8XyKZ+j8=";
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

  preConfigure = ''
    sed -i 's|git_describe(GIT_TAG)|set(GIT_TAG "${rev}")|' CMakeLists.txt
  '';

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
    homepage = "https://github.com/lwvmobile/dsd-fme";
    license = licenses.isc;
    platforms = platforms.unix;
  };
}
