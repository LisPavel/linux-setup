{ config, pkgs, lib, ... }:

{
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
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # Allow unfree packages
#   nixpkgs.config.allowUnfree = true;

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
    brave
    obsidian
    vscodium
    neovim
    vial
    flameshot
    keepassxc

    # --- nerdfonts ---
    (nerdfonts.override { fonts = [ "Meslo" "FiraCode" ]; })
    # === nerdfonts ===

    # --- lazyvim ---
    lazygit
    gcc
    ripgrep
    fd
    tree-sitter
    # === lazyvim ===
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
      core = {
        editor = "codium --wait";
      };
      init = {
        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
      };
    };
  };
  # === git ===

  # --- ZSH ---
  programs.zsh = {
    enable = true;

    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting = { enable = true; };

    # needed for powerlevel10k theme
    initExtraBeforeCompInit = ''
      # p10k instant prompt
      local P10K_INSTANT_PROMPT="${config.xdg.cacheHome}/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"
    '';

    plugins = with pkgs; [
      {
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        name = "powerlevel10k";
        src = zsh-powerlevel10k;
      }
#       {
#         file = "p10k.zsh";
#         name = "powerlevel10k-config";
#         src = "$HOME/Documents/System/zsh"; # Some directory containing your p10k.zsh file
#       }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "command-not-found"
        "git"
        "history"
        "sudo"
        "nvm"
      ];
    };

    shellAliases = {
        "use-node-shell" = "nix develop ~/Documents/System/Nix/DevShells --command zsh";
        "use-node18-shell" = "nix develop ~/Documents/System/Nix/DevShells#node18 --command zsh";
        "use-node14-shell" = "nix develop ~/Documents/System/Nix/DevShells#node14 --command zsh";
        "protontricks" = "flatpak run com.github.Matoking.protontricks";
        "protontricks-launch" = "flatpak run --command=protontricks-launch com.github.Matoking.protontricks";
    };

    initExtra = ''
      POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
      source ~/Documents/System/zsh/p10k.zsh
    '';
  };
  # === ZSH ===

  # --- FISH ---
  programs.fish = {
    enable = true;
    shellAliases = {
        "use-node-shell" = "nix develop ~/Documents/System/Nix/DevShells --command fish";
        "use-node18-shell" = "nix develop ~/Documents/System/Nix/DevShells#node18 --command fish";
        "use-node14-shell" = "nix develop ~/Documents/System/Nix/DevShells#node14 --command fish";
        "protontricks" = "flatpak run com.github.Matoking.protontricks";
        "protontricks-launch" = "flatpak run --command=protontricks-launch com.github.Matoking.protontricks";
    };
  };
  # === FISH ===
  services.ssh-agent.enable = true;
}
