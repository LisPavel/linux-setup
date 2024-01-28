{
  description = "Home Manager configuration of pl";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Specify nixpkgs deprecated (for nodejs 14 )
    # nixpkgs-deprecated.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

#   outputs = { nixpkgs, home-manager, nixpkgs-deprecated, ... }:
  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        # setup nixpkgs
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "electron-25.9.0"
          ];
        };
      };

      # set deprecated srcs
  #       pkgs-dep = import nixpkgs-deprecated {
  #         inherit system;
  #         config = {
  #           permittedInsecurePackages = [
  #             "nodejs-14.21.3"
  #             "openssl-1.1.1w"
  #           ];
  #         };
  #       };

    in {
      home-manager.useUserPackages = true;
      home-manager.useGlobalPkgs = true;
      homeConfigurations."pfox" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # pass extra args to home manager
#         extraSpecialArgs = {
#           inherit pkgs-dep;
#         };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
