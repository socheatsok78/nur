{
  lib,
  stdenv,
  cmake,
  fetchFromGitHub,
  libsndfile,
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
  pversion = "2025-11-28";
  name = "${pname}-${pversion}";

  rev = "816930a4de9cf633b6a86d78ff77cb01060fc715";
  src = fetchFromGitHub {
    owner = "lwvmobile";
    repo = "m17-fme";
    rev = rev;
    sha256 = "sha256-6KErGZ4C8ttaBdQsDDEJjr7dkKQAGQLgB+viQXEex70=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];
  buildInputs = [
    libsndfile
    ncurses.dev
    codec2
    socat
  ]
  ++ lib.optionals pulseaudioSupport [ libpulseaudio ];

  preConfigure = ''
    sed -i 's|git_describe(GIT_TAG)|set(GIT_TAG "${pversion} (${rev})")|' CMakeLists.txt
  '';

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
