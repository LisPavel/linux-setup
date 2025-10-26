{ ... }: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Pavel Lisitsyn";
        email = "43790794+LisPavel@users.noreply.github.com";
      };
      core = { editor = "codium --wait"; };
      init = { defaultBranch = "main"; };
      push = { autoSetupRemote = true; };
    };
  };
}
