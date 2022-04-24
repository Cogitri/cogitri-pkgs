{
  description = "derivations by Cogitri";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    let
      inherit (flake-utils.lib) eachSystem system;
    in
    eachSystem [ system.x86_64-linux ]
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
          };
        in
        {
          packages = {
            inherit (pkgs)
              asusctl
              supergfxctl
              gnome-text-editor;
          };
        }
      ) //
    {
      nixosModules = {
        asusd = import ./modules/asusd.nix;
        supergfxd = import ./modules/supergfxd.nix;
      };
      overlays.default = final: prev: {
        asusctl = final.callPackage ./pkgs/asusctl { };
        supergfxctl = final.callPackage ./pkgs/supergfxctl { };
        gnome-text-editor = final.callPackage ./pkgs/gnome-text-editor { };
      };
    };
}
