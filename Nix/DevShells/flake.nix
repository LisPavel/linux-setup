{
  description = "Dev shells";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    deprecated.url = "github:nixos/nixpkgs/nixos-23.05";
  };

  outputs = { self, nixpkgs, deprecated, ... }:
    let
      allSystems = [ "x86_64-linux" ];

      forAllSystems = fn :
        nixpkgs.lib.genAttrs allSystems
        (system: fn {
          pkgs = import nixpkgs {
            inherit system;
          };

          pkgs-dep = import deprecated {
            inherit system;
            config = {
              permittedInsecurePackages = [
                "nodejs-14.21.3"
                "openssl-1.1.1w"
              ];
            };
          };
        });
    in
    {
      devShells = forAllSystems
      ({pkgs, pkgs-dep}:
        let
          shells = import ./shells.nix { inherit pkgs; inherit pkgs-dep; };
        in
        {
          inherit (shells) default node14 node18;
        }
      );
    };
}
