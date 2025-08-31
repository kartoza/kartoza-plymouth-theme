self: super: {
  nixos-utils = super.callPackage ./utils/default.nix {};
}
