{
  inputs,
  system,
  pkgs,
  ...
}:
pkgs.mkShell {
  packages = [
    pkgs.rage
    # Development
    pkgs.gum # UX for TUIs
    pkgs.gource # Software version control visualization
    pkgs.ffmpeg # Convert gource videos to gifs
    pkgs.chafa # Image to ASCII converter
    pkgs.pre-commit # for formatting commits
    pkgs.nixfmt-rfc-style # formatting compliance with nix standards
    pkgs.bearer
    pkgs.shfmt
    pkgs.markdownlint-cli
    pkgs.actionlint
    pkgs.shellcheck
    pkgs.nodePackages.cspell
  ];

  shellHook = ''
    # Run the welcome prompt
    ./utils/prompt.sh
  '';
}
