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
    eachSystem [ system.x86_64-linux ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        packages = {
          asusctl = pkgs.callPackage ./pkgs/asusctl { };
          supergfxctl = pkgs.callPackage ./pkgs/supergfxctl { };
          gnome-text-editor = pkgs.callPackage ./pkgs/gnome-text-editor { };
        };
        overlays = final: prev: {
          # Inherit the packages into the overlay
          inherit (self.packages.${system})
            asusctl supergfxctl gnome-text-editor;
        };
      }
    );
}
