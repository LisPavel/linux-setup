{ ... }: {
  programs.fish = {
    enable = true;
    shellAliases = {
      # devshells aliases
      "use-node-shell" =
        "nix develop ~/Documents/System/Nix/DevShells --command fish";
      "use-ostree-node-shell" =
        "nix develop /var/home/pl/Documents/System/Nix/DevShells --command fish";
      "use-node18-shell" =
        "nix develop ~/Documents/System/Nix/DevShells#node18 --command fish";
      "use-ostree-node18-shell" =
        "nix develop /var/home/pl/Documents/System/Nix/DevShells#node18 --command fish";
      "use-node14-shell" =
        "nix develop ~/Documents/System/Nix/DevShells#node14 --command fish";
      "use-ostree-node14-shell" =
        "nix develop /var/home/pl/Documents/System/Nix/DevShells#node14 --command fish";
      # protontricks flatpak aliases 
      "protontricks" = "flatpak run com.github.Matoking.protontricks";
      "protontricks-launch" =
        "flatpak run --command=protontricks-launch com.github.Matoking.protontricks";
      # home manager shortcuts
      "hm-switch" =
        "home-manager switch --flake ~/Documents/System/Nix/home-manager";
      "hm-update" =
        "nix flake update --flake ~/Documents/System/Nix/home-manager/";
      "hm-upgrade" = "hm-update && hm-switch";
      "hm-cleanup" = ''
        home-manager expire-generations "-15days" && nix-collect-garbage --delete-older-than 15d'';
      "hm-gens" = "home-manager generations";
      # system bakcup shortcut
      "sys-backup" = ''snapper -c root create -t single -d "before upgrade"'';
    };
  };
}
