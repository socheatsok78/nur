{
  lib,
  stdenv,
  pulseaudio,
  orc,
  glib,

  jackaudioSupport ? false,
  airtunesSupport ? false,
  bluetoothSupport ? stdenv.hostPlatform.isLinux,
  advancedBluetoothCodecs ? false,
  remoteControlSupport ? false,
  zeroconfSupport ? false,

  libOnly ? false,
}:
(pulseaudio.override {
  jackaudioSupport = jackaudioSupport;
  airtunesSupport = airtunesSupport;
  bluetoothSupport = bluetoothSupport;
  advancedBluetoothCodecs = advancedBluetoothCodecs;
  remoteControlSupport = remoteControlSupport;
  zeroconfSupport = zeroconfSupport;

  libOnly = libOnly;
}).overrideAttrs
  (
    finalAttrs: previousAttrs: {
      nativeBuildInputs = previousAttrs.nativeBuildInputs ++ [ glib ];

      buildInputs =
        previousAttrs.buildInputs
        ++ lib.optionals (stdenv.hostPlatform.isDarwin) [
          orc
        ];

      preConfigure = lib.optionalString stdenv.hostPlatform.isDarwin ''
        # Restore coreaudio module as default on macOS
        sed -i "s/cdata.set('HAVE_COREAUDIO', 0)/cdata.set('HAVE_COREAUDIO', 1)/" meson.build
      '';

      mesonFlags =
        previousAttrs.mesonFlags
        ++ [
          (lib.mesonEnable "orc" stdenv.hostPlatform.isDarwin) # required on macOS
        ]
        ++ lib.optionals (!stdenv.hostPlatform.isDarwin) [
          (lib.mesonEnable "dbus" true)
        ]
        ++ lib.optionals stdenv.hostPlatform.isDarwin [
          (lib.mesonEnable "glib" true)
          (lib.mesonEnable "soxr" true)
          (lib.mesonEnable "speex" true)
          "-Dstream-restore-clear-old-devices=true"
        ];

      doInstallCheck = false;
    }
  )
