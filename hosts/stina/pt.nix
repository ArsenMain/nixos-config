{
  lib,
  stdenvNoCC,
  autoPatchelfHook,
  dpkg,
  makeWrapper,
  alsa-lib,
  dbus,
  expat,
  fontconfig,
  glib,
  libdrm,
  libglvnd,
  libpulseaudio,
  libudev0-shim,
  libxkbcommon,
  libxml2_13,
  libxslt,
  nspr,
  nss,
  wayland,
  buildFHSEnv,
  copyDesktopItems,
  makeDesktopItem,
  version ? "8.2.2",
  fetchurl,
  libice,
  libsm,
  libx11,
  libxscrnsaver,
  libxcomposite,
  libxcursor,
  libxdamage,
  libxext,
  libxfixes,
  libxi,
  libxrandr,
  libxrender,
  libxtst,
  libxcb,
  libxcb-image,
  libxcb-keysyms,
  libxcb-render-util,
  libxcb-wm
}:

let
  # stdenvNoCC as opposed to stdenv will not pull in any C compilation dependencies (as they are not needed)
  unwrapped = stdenvNoCC.mkDerivation {
    name = "ciscoPacketTracer8-unwrapped";
    inherit version;

    src = fetchurl {
      url = "https://www.netacad.com/authoring-resources/courses/ff9e491c-49be-4734-803e-a79e6e83dab1/c3636211-1ce6-4f92-8a22-ccddf902dd72/en-US/assets/PacketTracer822_amd64_signed_en-US_35234a27-3127-49bc-91ce-2926af76f07a.deb";
      sha256 = "bNK4iR35LSyti2/cR0gPwIneCFxPP+leuA1UUKKn9y0=";
  };


    nativeBuildInputs = [
      autoPatchelfHook
      dpkg
      makeWrapper
    ];

    buildInputs = [
      alsa-lib
      dbus
      expat
      fontconfig
      glib
      libdrm
      libglvnd
      libpulseaudio
      libudev0-shim
      libxkbcommon
      libxml2_13
      libxslt
      nspr
      nss
      wayland
      libice
      libsm
      libx11
      libxscrnsaver
      libxcomposite
      libxcursor
      libxdamage
      libxext
      libxfixes
      libxi
      libxrandr
      libxrender
      libxtst
      libxcb
      libxcb-image
      libxcb-keysyms
      libxcb-render-util
      libxcb-wm
    ];

    unpackPhase = ''
      runHook preUnpack

      dpkg-deb -x $src $out
      chmod 755 "$out"

      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall

      makeWrapper "$out/opt/pt/bin/PacketTracer" "$out/bin/packettracer8" \
        --set QT_QPA_PLATFORM xcb \
        --prefix LD_LIBRARY_PATH : "$out/opt/pt/bin"

      runHook postInstall
    '';
  };

  fhs-env = buildFHSEnv {
    name = "ciscoPacketTracer8-fhs-env";
    runScript = lib.getExe' unwrapped "packettracer8";
    targetPkgs = _: [ libudev0-shim ];
  };
in

stdenvNoCC.mkDerivation {
  pname = "ciscoPacketTracer8";
  inherit version;

  dontUnpack = true;

  nativeBuildInputs = [
    copyDesktopItems
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    ln -s ${fhs-env}/bin/${fhs-env.name} $out/bin/packettracer8

    mkdir -p $out/share/icons/hicolor/48x48/apps
    ln -s ${unwrapped}/opt/pt/art/app.png $out/share/icons/hicolor/48x48/apps/cisco-packet-tracer-8.png
    ln -s ${unwrapped}/usr/share/icons/gnome/48x48/mimetypes $out/share/icons/hicolor/48x48/mimetypes
    ln -s ${unwrapped}/usr/share/mime $out/share/mime

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "cisco-pt8.desktop";
      desktopName = "Cisco Packet Tracer 8";
      icon = "cisco-packet-tracer-8";
      exec = "packettracer8 %f";
      mimeTypes = [
        "application/x-pkt"
        "application/x-pka"
        "application/x-pkz"
        "application/x-pksz"
        "application/x-pks"
      ];
    })
  ];

  meta = {
    description = "Network simulation tool from Cisco";
    homepage = "https://www.netacad.com/courses/packet-tracer";
    license = lib.licenses.unfree;
    mainProgram = "packettracer8";
    maintainers = with lib.maintainers; [
      gepbird
    ];
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
}
