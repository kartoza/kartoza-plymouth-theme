{pkgs, ...}: let
  desktopItem = pkgs.makeDesktopItem {
    name = "kartoza-plymouth-theme";
    exec = "kartoza-plymouth-theme"; # Replace with whatever script must be executed
    icon = "kartoza-plymouth-theme";
    desktopName = "kartoza-plymouth-theme";
    comment = "A plymouth theme for Kartoza";
    categories = ["System" "Utility"];
    keywords = ["nixos" "system" "management" "utilities" "terminal"];
    terminal = true;
    startupNotify = false;
  };

  runtimeInputs = with pkgs; [
    # foo
  ];
in
  pkgs.stdenv.mkDerivation {
    pname = "kartoza-plymouth-theme";
    version = "1.0.0";

    src = ./.;

    buildInputs = [
      pkgs.makeWrapper
    ];

    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/share/kartoza-plymouth-theme
      mkdir -p $out/share/applications
      mkdir -p $out/share/icons/hicolor/256x256/apps

      # Copy the main script
      cp utils.sh $out/bin/kartoza-plymouth-theme
      chmod +x $out/bin/kartoza-plymouth-theme

      # Copy the img folder and its contents
      cp -r img $out/share/kartoza-plymouth-theme

      # Install desktop file
      cp ${desktopItem}/share/applications/* $out/share/applications/

      # Install icon (PNG should go in 256x256 directory, not scalable)
      cp img/icon.png $out/share/icons/hicolor/256x256/apps/kartoza-plymouth-theme.png

      # Wrap the script with runtime dependencies
      wrapProgram $out/bin/kartoza-plymouth-theme \
        --prefix PATH : ${pkgs.lib.makeBinPath runtimeInputs} \
        --set UTILS_SHARE_DIR $out/share/kartoza-plymouth-theme
    '';

    meta = with pkgs.lib; {
      description = "A plymouth theme for Kartoza";
      license = licenses.mit;
      platforms = platforms.linux;
    };
  }
