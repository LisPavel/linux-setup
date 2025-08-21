{ pkgs, ... }: {
  home.packages = with pkgs; [
    obsidian
    vscodium
    neovim
    flameshot
    vivaldi
    fastfetch
    bat
    nodejs_20

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
  ];
}
