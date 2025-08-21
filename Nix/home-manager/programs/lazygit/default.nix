{ ... }: {
  programs.lazygit = {
    enable = true;
    configFile = ./config.yml;
  };
}
