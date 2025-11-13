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
  pversion = "2025-10-31";
  name = "${pname}-${pversion}";

  rev = "eb76ea20399a76a0d19a36dd162cbd7a4111eb2a";
  src = fetchFromGitHub {
    owner = "lwvmobile";
    repo = "dsd-fme";
    rev = rev;
    sha256 = "sha256-861CudqyODgDZv+o5BjY/V6bIAqS1XCZiGQ46Y7v/BY=";
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
    sed -i 's|git_describe(GIT_TAG)|set(GIT_TAG "${pversion} (${rev})")|' CMakeLists.txt
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
