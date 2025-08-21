{
  description = "Home Manager configuration of pl";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nix-flatpak, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        # setup nixpkgs
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [ "electron-25.9.0" ];
        };
      };

    in {
      nix.extraOptions = ''
        experimental-features = nix-command flakes
        keep-outputs = true
        keep-derivations = true
      '';
      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
      home-manager.useUserPackages = true;
      home-manager.useGlobalPkgs = true;
      homeConfigurations."pl" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # extraSpecialArgs = { inherit nix-flatpak; };
        # pass extra args to home manager
        #         extraSpecialArgs = {
        #           inherit pkgs-dep;
        #         };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ nix-flatpak.homeManagerModules.nix-flatpak ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
