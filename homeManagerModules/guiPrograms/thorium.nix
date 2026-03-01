{ lib, config, pkgs, ... }:

let
  cfg = config.thorium;

  thorium-avx = pkgs.stdenv.mkDerivation rec {
    pname = "thorium-browser";
    version = "130.0.7204.303";

    src = pkgs.fetchurl {
      url = "https://github.com/Alex313031/thorium/releases/download/M${version}/thorium-browser_${version}_AVX_amd64.deb";
      # Get the hash by running:
      #   nix-prefetch-url 'https://github.com/Alex313031/thorium/releases/download/M130.0.7204.303/thorium-browser_130.0.7204.303_AVX_amd64.deb'
      # Then: nix hash convert --hash-algo sha256 --to sri <output>
      hash = lib.fakeHash;
    };

    nativeBuildInputs = with pkgs; [ dpkg autoPatchelfHook wrapGAppsHook3 ];

    buildInputs = with pkgs; [
      glib nss nspr atk at-spi2-atk cups dbus expat libdrm gtk3 pango cairo
      xorg.libX11 xorg.libxcb xorg.libXcomposite xorg.libXcursor xorg.libXdamage
      xorg.libXext xorg.libXfixes xorg.libXi xorg.libXrandr xorg.libXrender
      xorg.libXtst mesa alsa-lib libxkbcommon
    ];

    unpackPhase = ''dpkg-deb --fsys-tarfile "$src" | tar xf -'';

    installPhase = ''
      runHook preInstall
      mkdir -p $out/lib $out/bin $out/share
      cp -r usr/lib/thorium-browser $out/lib/
      ln -sf $out/lib/thorium-browser/thorium-browser $out/bin/thorium-browser
      cp -r usr/share/. $out/share/
      substituteInPlace $out/share/applications/thorium-browser.desktop \
        --replace-fail /usr/lib/thorium-browser/thorium-browser $out/bin/thorium-browser
      runHook postInstall
    '';

    meta = with lib; {
      description = "Chromium fork with AVX compiler optimizations";
      homepage = "https://thorium.rocks";
      license = licenses.bsd3;
      platforms = [ "x86_64-linux" ];
      sourceProvenance = [ sourceTypes.binaryNativeCode ];
    };
  };
in

{
  options.thorium.enable = lib.mkEnableOption "Thorium browser (AVX build)";

  config = lib.mkIf cfg.enable {
    home.packages = [ thorium-avx ];
  };
}
