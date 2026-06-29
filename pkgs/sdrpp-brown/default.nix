{
  stdenv,
  lib,
  fetchFromGitHub,
  cmake,
  pkg-config,
  libx11,
  libpulseaudio,
  glfw,
  glew,
  fftwFloat,
  volk,
  zstd,
  fftw,
  blas,

  # Sources
  airspy_source ? true,
  airspy,
  airspyhf_source ? true,
  airspyhf,
  audio_source ? true,
  badgesdr_source ? false,
  bladerf_source ? stdenv.hostPlatform.isLinux,
  libbladeRF,
  dragonlabs_source ? true,
  libdlcr,
  file_source ? true,
  fobossdr_source ? false,
  hackrf_source ? true,
  hackrf,
  harogic_source ? false,
  hermes_source ? false,
  hydrasdr_source ? false,
  kcsdr_source ? false,
  limesdr_source ? true,
  limesuite,
  network_source ? true,
  # needs libperseus-sdr, not yet available in nixpks
  perseus_source ? false,
  plutosdr_source ? stdenv.hostPlatform.isLinux,
  rfnm_source ? false,
  libiio,
  libad9361,
  rfspace_source ? true,
  rtl_sdr_source ? true,
  rtl-sdr-osmocom,
  libusb1,
  # osmocom better w/ rtlsdr v4
  rtl_tcp_source ? true,
  sdrplay_source ? false,
  sdrplay,
  sdrpp_server_source ? true,
  soapy_source ? true,
  soapysdr-with-plugins,
  spectran_source ? false,
  spectran_http_source ? true,
  spyserver_source ? true,
  hl2_source ? false,
  usrp_source ? false,
  uhd,
  boost,
  kiwisdr_source ? true,

  # Sinks
  android_audio_sink ? false,
  audio_sink ? true,
  rtaudio,
  network_sink ? true,
  mpeg_adts_sink ? false,
  portaudio_sink ? false,
  portaudio,
  legacy_portaudio_sink ? false,

  # Decoders
  atv_decoder ? true,
  dab_decoder ? false,
  falcon9_decoder ? false,
  kg_sstv_decoder ? false,
  m17_decoder ? false,
  codec2,
  # The CH decoders are not supported on Linux due to missing dependencies.
  ch_extravhf_decoder ? !stdenv.hostPlatform.isLinux,
  ch_tetra_demodulator ? !stdenv.hostPlatform.isLinux,
  ft8_decoder ? false,
  dsdcc_decoder ? false,
  meteor_demodulator ? true,
  pager_decoder ? true,
  radio ? true,
  ryfi_decoder ? false,
  vor_receiver ? false,
  weather_sat_decoder ? false,

  # Misc
  discord_presence ? true,
  frequency_manager ? true,
  iq_exporter ? true,
  recorder ? true,
  rigctl_client ? true,
  rigctl_server ? true,
  tci_server ? true,
  scanner ? true,
  scheduler ? false,
  noise_reduction_logmmse ? true,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "sdrpp-brown";

  upstreamVersion = "1.2.1";
  version = "${finalAttrs.upstreamVersion}-2026-05-08";

  src = fetchFromGitHub {
    owner = "sannysanoff";
    repo = "SDRPlusPlusBrown";
    rev = "6f4cb5c530d935741bbfdbb1d0cd54e7507e7b2a";
    hash = "sha256-Iio3A5i8HQu0da/iA1d2MgYJyYteDn9Lf4+/OQB+Tp4=";
  };

  patches = [
    ./0001-Allow-management-of-resources-and-modules-paths.patch
    ./0002-audio-sinks-patch.patch
  ];

  postPatch = ''
    substituteInPlace decoder_modules/m17_decoder/src/m17dsp.h \
      --replace-fail "codec2.h" "codec2/codec2.h"

    substituteInPlace core/src/version.h \
      --replace-fail "${finalAttrs.upstreamVersion}" "${finalAttrs.version}"
  '';

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    glfw
    glew
    fftwFloat
    volk
    zstd
    fftw
    libpulseaudio
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [
    blas
    libx11
  ]
  ++ lib.optional airspy_source airspy
  ++ lib.optional airspyhf_source airspyhf
  ++ lib.optional bladerf_source libbladeRF
  ++ lib.optional dragonlabs_source libdlcr
  ++ lib.optional hackrf_source hackrf
  ++ lib.optional limesdr_source limesuite
  ++ lib.optionals rtl_sdr_source [
    rtl-sdr-osmocom
    libusb1
  ]
  ++ lib.optional sdrplay_source sdrplay
  ++ lib.optional soapy_source soapysdr-with-plugins
  ++ lib.optionals plutosdr_source [
    libiio
    libad9361
  ]
  ++ lib.optionals usrp_source [
    uhd
    boost
  ]
  ++ lib.optional (audio_source || audio_sink) rtaudio
  ++ lib.optional portaudio_sink portaudio
  ++ lib.optional (dab_decoder || m17_decoder) codec2;

  cmakeFlags = [
    "-DCMAKE_CXX_FLAGS=-std=c++14"

    # Sources
    (lib.cmakeBool "OPT_BUILD_AIRSPYHF_SOURCE" airspyhf_source)
    (lib.cmakeBool "OPT_BUILD_AIRSPY_SOURCE" airspy_source)
    (lib.cmakeBool "OPT_BUILD_AUDIO_SOURCE" audio_source)
    (lib.cmakeBool "OPT_BUILD_BADGESDR_SOURCE" badgesdr_source)
    (lib.cmakeBool "OPT_BUILD_BLADERF_SOURCE" bladerf_source)
    (lib.cmakeBool "OPT_BUILD_DRAGONLABS_SOURCE" dragonlabs_source)
    (lib.cmakeBool "OPT_BUILD_FILE_SOURCE" file_source)
    (lib.cmakeBool "OPT_BUILD_FOBOSSDR_SOURCE" fobossdr_source)
    (lib.cmakeBool "OPT_BUILD_HACKRF_SOURCE" hackrf_source)
    (lib.cmakeBool "OPT_BUILD_HAROGIC_SOURCE" harogic_source)
    (lib.cmakeBool "OPT_BUILD_HERMES_SOURCE" hermes_source)
    (lib.cmakeBool "OPT_BUILD_HYDRASDR_SOURCE" hydrasdr_source)
    (lib.cmakeBool "OPT_BUILD_KCSDR_SOURCE" kcsdr_source)
    (lib.cmakeBool "OPT_BUILD_LIMESDR_SOURCE" limesdr_source)
    (lib.cmakeBool "OPT_BUILD_NETWORK_SOURCE" network_source)
    (lib.cmakeBool "OPT_BUILD_PERSEUS_SOURCE" perseus_source)
    (lib.cmakeBool "OPT_BUILD_PLUTOSDR_SOURCE" plutosdr_source)
    (lib.cmakeBool "OPT_BUILD_RFNM_SOURCE" rfnm_source)
    (lib.cmakeBool "OPT_BUILD_RFSPACE_SOURCE" rfspace_source)
    (lib.cmakeBool "OPT_BUILD_RTL_SDR_SOURCE" rtl_sdr_source)
    (lib.cmakeBool "OPT_BUILD_RTL_TCP_SOURCE" rtl_tcp_source)
    (lib.cmakeBool "OPT_BUILD_SDRPLAY_SOURCE" sdrplay_source)
    (lib.cmakeBool "OPT_BUILD_SDRPP_SERVER_SOURCE" sdrpp_server_source)
    (lib.cmakeBool "OPT_BUILD_SOAPY_SOURCE" soapy_source)
    (lib.cmakeBool "OPT_BUILD_SPECTRAN_SOURCE" spectran_source)
    (lib.cmakeBool "OPT_BUILD_SPECTRAN_HTTP_SOURCE" spectran_http_source)
    (lib.cmakeBool "OPT_BUILD_SPYSERVER_SOURCE" spyserver_source)
    (lib.cmakeBool "OPT_BUILD_HL2_SOURCE" hl2_source)
    (lib.cmakeBool "OPT_BUILD_USRP_SOURCE" usrp_source)
    (lib.cmakeBool "OPT_BUILD_KIWISDR_SOURCE" kiwisdr_source)

    # Sinks
    (lib.cmakeBool "OPT_BUILD_ANDROID_AUDIO_SINK" android_audio_sink)
    (lib.cmakeBool "OPT_BUILD_AUDIO_SINK" audio_sink)
    (lib.cmakeBool "OPT_BUILD_NETWORK_SINK" network_sink)
    (lib.cmakeBool "OPT_BUILD_MPEG_ADTS_SINK" mpeg_adts_sink)
    (lib.cmakeBool "OPT_BUILD_NEW_PORTAUDIO_SINK" portaudio_sink)
    (lib.cmakeBool "OPT_BUILD_PORTAUDIO_SINK" legacy_portaudio_sink)

    # Decoders
    (lib.cmakeBool "OPT_BUILD_ATV_DECODER" atv_decoder)
    (lib.cmakeBool "OPT_BUILD_DAB_DECODER" dab_decoder)
    (lib.cmakeBool "OPT_BUILD_FALCON9_DECODER" falcon9_decoder)
    (lib.cmakeBool "OPT_BUILD_KG_SSTV_DECODER" kg_sstv_decoder)
    (lib.cmakeBool "OPT_BUILD_M17_DECODER" m17_decoder)
    (lib.cmakeBool "OPT_BUILD_CH_EXTRAVHF_DECODER" ch_extravhf_decoder)
    (lib.cmakeBool "OPT_BUILD_CH_TETRA_DEMODULATOR" ch_tetra_demodulator)
    (lib.cmakeBool "OPT_BUILD_FT8_DECODER" ft8_decoder)
    (lib.cmakeBool "OPT_BUILD_DSDCC_DECODER" dsdcc_decoder)
    (lib.cmakeBool "OPT_BUILD_METEOR_DEMODULATOR" meteor_demodulator)
    (lib.cmakeBool "OPT_BUILD_PAGER_DECODER" pager_decoder)
    (lib.cmakeBool "OPT_BUILD_RADIO" radio)
    (lib.cmakeBool "OPT_BUILD_RYFI_DECODER" ryfi_decoder)
    (lib.cmakeBool "OPT_BUILD_VOR_RECEIVER" vor_receiver)
    (lib.cmakeBool "OPT_BUILD_WEATHER_SAT_DECODER" weather_sat_decoder)

    # Misc
    (lib.cmakeBool "OPT_BUILD_DISCORD_PRESENCE" discord_presence)
    (lib.cmakeBool "OPT_BUILD_FREQUENCY_MANAGER" frequency_manager)
    (lib.cmakeBool "OPT_BUILD_IQ_EXPORTER" iq_exporter)
    (lib.cmakeBool "OPT_BUILD_RECORDER" recorder)
    (lib.cmakeBool "OPT_BUILD_RIGCTL_CLIENT" rigctl_client)
    (lib.cmakeBool "OPT_BUILD_RIGCTL_SERVER" rigctl_server)
    (lib.cmakeBool "OPT_BUILD_TCI_SERVER" tci_server)
    (lib.cmakeBool "OPT_BUILD_SCANNER" scanner)
    (lib.cmakeBool "OPT_BUILD_SCHEDULER" scheduler)
    (lib.cmakeBool "OPT_BUILD_NOISE_REDUCTION_LOGMMSE" noise_reduction_logmmse)

    # Other options
    (lib.cmakeBool "USE_INTERNAL_LIBCORRECT" true)
    (lib.cmakeBool "USE_BUNDLE_DEFAULTS" false)
    (lib.cmakeBool "COPY_MSVC_REDISTRIBUTABLES" false)
  ];

  CMAKE_TLS_VERIFY = 0;
  env.NIX_CFLAGS_COMPILE = "-fpermissive";

  hardeningDisable = lib.optional stdenv.cc.isClang "format";

  meta = {
    description = "Cross-Platform SDR Software";
    homepage = "https://github.com/sannysanoff/SDRPlusPlusBrown";
    license = lib.licenses.gpl3Only;
    # The DAB decoder is broken upstream. See: https://github.com/AlexandreRouma/SDRPlusPlus/issues/1511
    broken = dab_decoder;
    maintainers = with lib.maintainers; [
      sikmir
      zaninime
    ];
    mainProgram = "sdrpp";
  };
})
