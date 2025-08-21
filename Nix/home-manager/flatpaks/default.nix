{ ... }:
let packages = [ "com.logseq.Logseq" "org.gimp.GIMP" ];
in { services.flatpak.packages = packages; }
