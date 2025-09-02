{
  description = "kartoza-plymouth-theme";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs =
    {
      self,
      nixpkgs,
    }@inputs:
    let
      # Flake system
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
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
    in
    {
      packages.x86_64-linux = rec {
        # recursive so default alias can refer to kartoza-plymouth
        kartoza-plymouth = pkgs.callPackage ./packages/kartoza-plymouth-theme { };
        default = kartoza-plymouth;
      };

      ######################################################
      ##
      ## Development Shells
      ##
      ######################################################

      # SHELLS
      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfreePredicate =
              pkg:
              builtins.elem (nixpkgs.lib.getName pkg) [
                "bearer"
              ];
          };
        in
        {
          default = import ./utils/develop.nix {
            inherit
              inputs
              system
              pkgs
              ;
          };
        }
      );
    };
}
