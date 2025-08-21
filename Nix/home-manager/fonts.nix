{ pkgs, ... }: {
  # Enable fonts
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    # --- nerdfonts ---
    nerd-fonts.fira-code
    nerd-fonts.meslo-lg
    # === nerdfonts ===
  ];
}
