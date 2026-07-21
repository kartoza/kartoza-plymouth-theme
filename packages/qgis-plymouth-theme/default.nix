{
  pkgs ? import <nixpkgs> { },
}:
pkgs.stdenv.mkDerivation rec {
  pname = "qgis-plymouth";
  version = "0.0.1";

  src = ./src;

  buildInputs = [ pkgs.git ];

  # Nothing to compile — the raster assets are pre-generated and
  # committed (see src/qgis/generate-assets.sh).  We only stage the
  # runtime files (images, script, .plymouth) into the theme path and
  # rewrite the hard-coded /usr prefix in the .plymouth manifest to the
  # Nix store output.
  unpackPhase = ''
    cp -r ${src}/* .
  '';

  configurePhase = ''
    mkdir -p $out/share/plymouth/themes/qgis
  '';

  buildPhase = "";

  installPhase = ''
    cp -r qgis/images $out/share/plymouth/themes/qgis
    cp qgis/qgis.script $out/share/plymouth/themes/qgis
    cat qgis/qgis.plymouth | sed "s@\/usr\/@$out\/@" > $out/share/plymouth/themes/qgis/qgis.plymouth
  '';

  shellHook = ''
    export SRC_DIR=$src
    echo "Source directory is set to: $SRC_DIR"
  '';

  meta.description = "QGIS 'Spatial without Compromise' Plymouth boot theme";
}
