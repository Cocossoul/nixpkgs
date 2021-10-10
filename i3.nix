{ config, lib, pkgs, ... }:

let 
  mod = "Mod4";
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      fonts = ["FontAwesome 12"];

      keybindings = lib.mkOptionDefault {
        # DMenu
        "${mod}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";

        # Print screen maim
        "${mod}+Shift+p" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";

        # i3lock with lockscreen
        "${mod}+Shift+i" = "exec sh -c \"${pkgs.i3lock}/bin/i3lock --image=$HOME/Wallpapers/lockscreen.png\"";

        # Open terminal
        "${mod}+Return" = "exec i3-sensible-terminal";

        # Close window
        "${mod}+Shift+a" = "kill";

        # Shortcut mode
        "${mod}+Shift+d" = "mode shortcut";

        # Logout -> does not prompt ?
        "${mod}+Shift+e" = "exec \"i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'\"";

        # Screen brightness controls
        "XF86MonBrightnessUp" = "exec sh -c \"${pkgs.light}/bin/light -A 5\""; # increase screen brightness
        "XF86MonBrightnessDown" = "exec sh -c \"${pkgs.light}/bin/light -U 5\""; # decrease screen brightness
      };

      # Set gaps
      gaps = {
        inner = 15;
        outer = 1;
      };

      # Set shortcuts
      modes.shortcut = {
        "s" = "exec \"google-chrome-stable --app='https://open.spotify.com/'\"";
        "d" = "exec \"google-chrome-stable --app='https://discord.com/app'\"";
        "f" = "exec nautilus";
        "p" = "exec 'google-chrome-stable -incognito'";
        "i" = "exec google-chrome-stable";
        "o" = "exec firefox";
        "t" = "exec thunderbird";

        # back to normal: Enter or Escape
        "Return" = "mode default";
        "Escape" = "mode default";
      };

      # i3bar config
      bars = [
        {
          position = "top";
        }
      ];
      startup = [
        {
          command = "systemctl --user restart polybar";
          always = true;
          notification = false;
        }
      ];
    };
  };

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      iwSupport = true;
      githubSupport = true;
    };
    config = {
      "bar/top" = {
        monitor = "eDP-1";
        width = "100%";
        height = "3%";
        radius = 0;
        # Just sticking them together in the center for now
        modules-center = "date i3";
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%Y-%m-%d";
        time = "%H:%M";
        label = "%date% %time%";
      };
      "module/i3" = {
        type = "internal/i3";
        scroll-up = "i3wm-wsnext";
        scroll-down = "i3wm-wsprev";
      };
    };
    script = ''
    polybar top &
    '';
  };
}
