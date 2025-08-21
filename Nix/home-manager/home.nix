{ config, pkgs, lib, ... }:

{
  imports = [ ./modules ];
  xdg.autostart.enable = true;
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "pl";
  home.homeDirectory = "/home/pl";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  # Enable fonts
  fonts.fontconfig.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    obsidian
    vscodium
    neovim
    flameshot
    vivaldi
    fastfetch

    # --- nerdfonts ---
    nerd-fonts.fira-code
    nerd-fonts.meslo-lg
    # === nerdfonts ===

    # --- lazyvim ---
    gcc
    ripgrep
    fd
    tree-sitter
    fzf
    viu
    chafa
    ueberzugpp
    ast-grep
    # === lazyvim ===

    bat
    nodejs_20
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/pl/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # --- git ---
  programs.git = {
    enable = true;
    userName = "Pavel Lisitsyn";
    userEmail = "43790794+LisPavel@users.noreply.github.com";
    extraConfig = {
      core = { editor = "codium --wait"; };
      init = { defaultBranch = "main"; };
      push = { autoSetupRemote = true; };
    };
  };
  # === git ===

  # --- FISH ---
  programs.fish = {
    enable = true;
    shellAliases = {
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
      "protontricks" = "flatpak run com.github.Matoking.protontricks";
      "protontricks-launch" =
        "flatpak run --command=protontricks-launch com.github.Matoking.protontricks";
      "hm-switch" =
        "home-manager switch --flake ~/Documents/System/Nix/home-manager";
      "hm-update" =
        "nix flake update --flake ~/Documents/System/Nix/home-manager/";
      "hm-upgrade" = "hm-update && hm-switch";
      "hm-cleanup" = ''
        home-manager expire-generations "-15days" && nix-collect-garbage --delete-older-than 15d'';
      "sys-backup" = ''snapper -c root create -t single -d "before upgrade"'';
    };
  };
  # === FISH ===

  # --- yazi ---
  programs.yazi = {
    enable = true;
    package =
      pkgs.yazi.override { _7zz = (pkgs._7zz.override { useUasm = true; }); };
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  # === yazi ===

  # --- lazygit ---
  programs.lazygit = {
    enable = true;
    configFile = ./config/lazygit/config.yml;
  };
  # === lazygit ===

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  # +++ services +++
  services.ssh-agent.enable = true;
  services.byedpi.enable = true;
  services.keepassxc.enable = true;
  services.flatpak = {
    enable = true;
    remotes = [{
      name = "flathub";
      location = "https://flathub.org/repo/flathub.flatpakrepo";
    }];
    packages = [ "com.logseq.Logseq" ];
  };
}
