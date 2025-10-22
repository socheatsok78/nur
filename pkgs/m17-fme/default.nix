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
  pversion = "2025-10-15";
  name = "${pname}-${pversion}";

  rev = "ff811b7dc4e72c78f543369cc44134e338b4798f";
  src = fetchFromGitHub {
    owner = "lwvmobile";
    repo = "m17-fme";
    rev = rev;
    sha256 = "sha256-ZvhIiT74b0gpG32H7PAztjG9ziJT3Iyz+sh8q11ivU4=";
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
