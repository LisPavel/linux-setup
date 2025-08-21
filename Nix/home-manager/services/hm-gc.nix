{ config, lib, ... }:
let
  hmGC = {
    Unit = { Description = "Home Manager garbage collection"; };
    Service = {
      Type = "oneshot";
      ExecStart =
        "${config.home.homeDirectory}/.nix-profile/bin/home-manager expire-generations -15days";
      ExecStartPost =
        "${config.home.homeDirectory}/.nix-profile/bin/nix-store --gc";
    };
  };
in {
  systemd.user.services."hm-gc" = hmGC;

  systemd.user.timers."hm-gc" = {
    Unit.Description = "Timer for Home Manager garbage collection";
    Timer = {
      OnCalendar = "weekly";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
