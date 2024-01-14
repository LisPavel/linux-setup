{ pkgs , pkgs-dep }:

{
  node14 = pkgs.mkShell {
#     name = "nodejs 14 version";

    packages = with pkgs-dep; [
      nodejs_14
    ];

    shellHook = ''
      echo "Entered node js 14 dev shell"
    '';
  };

  node18 = pkgs.mkShell {
#     name = "nodejs 18 version";

    packages = with pkgs; [
      nodejs_18
      nodePackages.typescript
    ];

    shellHook = ''
      echo "Entered node js 18 dev shell"
    '';
  };

  default = pkgs.mkShell {
#     name = "nodejs 20 version";

    packages = with pkgs; [
      nodejs_20
      nodePackages.typescript
    ];

    shellHook = ''
      echo "Entered node js 20 dev shell"
    '';
  };
}
