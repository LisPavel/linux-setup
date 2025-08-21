{ config, lib, pkgs, ... }:

let
  cfg = config.programs.lazygit;
  yamlFormat = config.lib.formats.yaml { };
in {
  options.programs.lazygit = {
    configFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to external lazygit config.yml file";
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."lazygit/config.yml" = if cfg.configFile != null then {
      source = cfg.configFile;
    } else {
      source = yamlFormat.generate "lazygit-config" cfg.settings;
    };
  };
}
