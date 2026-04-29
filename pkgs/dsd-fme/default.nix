{
  lib,
  stdenv,
  cmake,
  fetchFromGitHub,
  mbelib-lwvmobile,
  libsndfile,
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
  pversion = "2026-03-28";
  name = "${pname}-${pversion}";

  rev = "ed1d1d630ce79db890bbf4b890317341bc5aa580";
  src = fetchFromGitHub {
    owner = "lwvmobile";
    repo = "dsd-fme";
    rev = rev;
    sha256 = "sha256-P01THOJXVC2MpAm6gUmi0bNliTDRiRheHfyU/k0slu4=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];
  buildInputs = [
    mbelib-lwvmobile
    libsndfile
    rtl-sdr-osmocom
    ncurses.dev
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
