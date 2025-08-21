{ ... }: {
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
}
