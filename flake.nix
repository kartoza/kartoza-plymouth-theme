{
  description = "kartoza-plymouth-theme";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = {
    self,
    nixpkgs,
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowInsecure = true;
        permittedInsecurePackages = [
          # Add other insecure packages as needed
        ];
      };
    };
  in {
    packages.x86_64-linux = {
      default = pkgs.callPackage ./packages/kartoza-plymouth-theme {};
    };

    ######################################################
    ##
    ## Development Shells
    ##
    ######################################################

    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        vscode
        git
        gum
        pre-commit
      ];

      shellHook = ''
        echo "kartoza-plymouth-theme"
        echo "_________________________________________________________"
        echo "Command : Description"
        echo "_________________________________________________________"
        echo "🚀 nix run          : Open the management utilities menu"
        echo "👀 nix flake show . : Show all the flake details"
        echo "🔍 nix flake update  : Update the flake"
        echo "🩻 nix flake check   : Check the flake"
        echo "🧪 nix flake test    : Run the tests for this flake"
        echo "🔧 nix build .#packages.x86_64-linux.iso : Build the ISO image"

        echo "🆚 ./vscode         : Open VSCode ready to work on this flake"
        echo "_________________________________________________________"
        echo "Tim Sutton, 2025   https://github.com/timlinux/"
      '';
    };
  };
}
