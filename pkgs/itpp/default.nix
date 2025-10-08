{
  lib,
  stdenv,
  fetchurl,
  cmake,
  # gtest,
  blas,
  fftw,
  liblapack,
  gfortran,
}:

stdenv.mkDerivation rec {
  pname = "it++";
  version = "4.3.1";

  src = fetchurl {
    url = "mirror://sourceforge/itpp/itpp-${version}.tar.bz2";
    sha256 = "0xxqag9wi0lg78xgw7b40rp6wxqp5grqlbs9z0ifvdfzqlhpcwah";
  };

  nativeBuildInputs = [
    cmake
    gfortran
  ];
  buildInputs = [
    fftw
    liblapack

    # NOTE: OpenBLAS doesn't work here because IT++ doesn't pass aligned
    # buffers, which causes segfaults in the optimized kernels :-(
    blas
  ];

  # Rename VERSION file to avoid build failure: version:1:1: error: expected unqualified-id
  # Reported upstream at: https://sourceforge.net/p/itpp/bugs/262/
  preConfigure = ''
    mv VERSION VERSION.txt
  '';

  cmakeFlags = let 
    libExt = if stdenv.hostPlatform.isDarwin then "dylib" else "so";
  in [
    "-DCMAKE_CXX_FLAGS=-std=c++14"
    "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
    "-DBLAS_FOUND:BOOL=TRUE"
    "-DBLAS_LIBRARIES:STRING=${blas}/lib/libblas.${libExt}"
    "-DLAPACK_FOUND:BOOL=TRUE"
    "-DLAPACK_LIBRARIES:STRING=${liblapack}/lib/liblapack.${libExt}"
    # "-DGTEST_DIR:PATH=${gtest.src}/googletest"
  ];

  doCheck = false;

  # checkPhase = ''
  #   ./gtests/itpp_gtests
  # '';

  meta = with lib; {
    description = "IT++ is a C++ library of mathematical, signal processing and communication classes and functions";
    mainProgram = "itpp-config";
    homepage = "https://itpp.sourceforge.net/";
    license = licenses.gpl3;
    platforms = platforms.unix;
    maintainers = [ ];
    # broken = stdenv.hostPlatform.isDarwin; # never built on Hydra https://hydra.nixos.org/job/nixpkgs/trunk/itpp.x86_64-darwin
  };
}
