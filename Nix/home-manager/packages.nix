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
