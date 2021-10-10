{ config, lib, pkgs, ... }:

let 
  mod = "Mod4";
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      fonts = ["DejaVu Sans Mono, FontAwesome 12"];

      keybindings = lib.mkOptionDefault {
        "${mod}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        "${mod}+Shift+p" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
        "${mod}+Shift+i" = "exec sh -c \"${pkgs.i3lock}/bin/i3lock --image=$HOME/Wallpapers/lockscreen.png\"";
      };

      bars = [
        {
          position = "top";
        }
      ];
    };
  };
}
