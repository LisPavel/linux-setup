{ ... }:
let packages = [ ];
in {
  # imports = [ ./logseq.nix ];
  services.flatpak.packages = packages;
}
