{pkgs, ...}: let
  desktopItem = pkgs.makeDesktopItem {
    name = "[PACKAGE NAME]";
    exec = "[PACAKAGE NAME]"; # Replace with whatever script must be executed
    icon = "[PACKAGE NAME]";
    desktopName = "[PACKAGE NAME]";
    comment = "[PACKAGE DESCRIPTION]";
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
    pname = "[PACKAGE NAME]";
    version = "1.0.0";

    src = ./.;

    buildInputs = [
      pkgs.makeWrapper
    ];

    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/share/[PACKAGE NAME]
      mkdir -p $out/share/applications
      mkdir -p $out/share/icons/hicolor/256x256/apps

      # Copy the main script
      cp utils.sh $out/bin/[PACKAGE NAME]
      chmod +x $out/bin/PACKAGE_NAME

      # Copy the img folder and its contents
      cp -r img $out/share/PACKAGE_NAME

      # Install desktop file
      cp ${desktopItem}/share/applications/* $out/share/applications/

      # Install icon (PNG should go in 256x256 directory, not scalable)
      cp img/icon.png $out/share/icons/hicolor/256x256/apps/[PACKAGE NAME].png

      # Wrap the script with runtime dependencies
      wrapProgram $out/bin/PACKAGE_NAME \
        --prefix PATH : ${pkgs.lib.makeBinPath runtimeInputs} \
        --set UTILS_SHARE_DIR $out/share/PACKAGE_NAME
    '';

    meta = with pkgs.lib; {
      description = "[PACKAGE DESCRIPTION]";
      license = licenses.mit;
      platforms = platforms.linux;
    };
  }
