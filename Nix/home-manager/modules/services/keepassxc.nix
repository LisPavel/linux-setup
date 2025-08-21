{ config, lib, pkgs, ... }:

let cfg = config.services.keepassxc;
in {
  options.services.keepassxc = {
    enable = lib.mkEnableOption "Keepassxc autostart service";
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.keepassxc = {
      Unit = {
        Description = "KeePassXC Password Manager";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.keepassxc}/bin/keepassxc --minimized";
        Restart = "on-failure";
        # For Wayland, we need to set different environment variables
        Environment = [
          "XDG_CURRENT_DESKTOP=KDE"
          "QT_QPA_PLATFORM=wayland"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION=1"
        ];
        # Import user environment variables
        EnvironmentFile = "%h/.config/environment.d/*.conf";
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };
    };

    home.packages = [ pkgs.keepassxc ];
  };
}
