{
  lib,
  stdenv,
  cmake,
  fetchFromGitHub,
  airspy,
  hackrf,
  libconfig,
  pkg-config,
  rtl-sdr-osmocom,
  zlib,

  systemd,
  useSystemd ? lib.meta.availableOn stdenv.hostPlatform systemd,
}:

stdenv.mkDerivation rec {
  pname = "sdr-server";
  pversion = "2025-11-23";
  name = "${pname}-${pversion}";

  rev = "059e085db571c04fb6a1770d131601436ce43379";
  src = fetchFromGitHub {
    owner = "dernasherbrezon";
    repo = "sdr-server";
    rev = rev;
    sha256 = "sha256-PXlfCZWL5bv0dEas3a32RVIudEh/ht6neLuc7ocCdrU=";
  };

  patches = [
    ./CMakeLists.txt.patch
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
  ];
  buildInputs = [
    airspy
    hackrf
    libconfig
    rtl-sdr-osmocom
    zlib
  ]
  ++ lib.optionals useSystemd [
    systemd
  ];

  preConfigure = let 
    libraryExtension = stdenv.hostPlatform.extensions.sharedLibrary;
  in ''
    substituteInPlace CMakeLists.txt --replace /usr/bin ${placeholder "out"}/bin
    substituteInPlace CMakeLists.txt --replace /etc/sdr-server ${placeholder "out"}/etc/sdr-server
    substituteInPlace CMakeLists.txt --replace /lib/systemd/system/ ${placeholder "out"}/lib/systemd/user/
    substituteInPlace src/sdr/airspy_lib.c --replace "dlopen(\"libairspy${libraryExtension}\"," "dlopen(\"${airspy}/lib/libairspy${libraryExtension}\","
    substituteInPlace src/sdr/hackrf_lib.c --replace "dlopen(\"libhackrf${libraryExtension}\"," "dlopen(\"${hackrf}/lib/libhackrf${libraryExtension}\","
    substituteInPlace src/sdr/rtlsdr_lib.c --replace "dlopen(\"librtlsdr${libraryExtension}\"," "dlopen(\"${rtl-sdr-osmocom}/lib/librtlsdr${libraryExtension}\","
  '';

  cmakeFlags = [
    "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
  ];

  doCheck = false;

  meta = with lib; {
    description = "High performant TCP server for rtl-sdr";
    longDescription = ''
      High performant TCP server for rtl-sdr
    '';
    homepage = "https://github.com/dernasherbrezon/sdr-server";
    license = licenses.gpl2Only;
    platforms = platforms.unix;
  };
}
