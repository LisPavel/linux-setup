{ ... }:
let pckg = "com.logseq.Logseq";
in {
  services.flatpak = {
    packages = [ pckg ];
    overrides.${pckg}.Context = { filesystems = [ "$HOME" ]; };
  };
}
