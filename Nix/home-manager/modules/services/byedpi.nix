{ config, lib, pkgs, ... }:

let
  cfg = config.services.byedpi;
  byedpiOptions = "-Ku -a3 -An -Kt,h -s0 -o1 -Ar -o1 -At -f-1 -r1+s -As -An";
in {
  options.services.byedpi = {
    enable = lib.mkEnableOption "ByeDPI service for bypassing restrictions";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.byedpi;
      defaultText = "pkgs.byedpi";
      description = "ByeDPI package to use";
    };

    options = lib.mkOption {
      type = lib.types.str;
      default = byedpiOptions;
      description = "Command line options for ByeDPI";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.byedpi = {
      Unit = {
        Description = "ByeDPI";
        Documentation = "https://github.com/hufrea/byedpi";
        Wants = [ "network-online.target" ];
        After = [ "network-online.target" "nss-lookup.target" "nix.mount" ];
      };

      Service = {
        NoNewPrivileges = true;
        StandardOutput = "null";
        StandardError = "journal";
        ExecStart = "${cfg.package}/bin/ciadpi ${cfg.options}";
        Restart = "on-failure";
        RestartSec = "5s";
        PrivateTmp = true;
        ProtectSystem = "full";
      };

      Install = { WantedBy = [ "default.target" ]; };
    };

    home.packages = [ cfg.package ];
  };
}
