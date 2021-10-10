{ config, lib, pkgs, ... }:

let 
  mod = "Mod4";
  colors = {
    background = "#222";
    background-alt = "#444";
    foreground = "#dfdfdf";
    foreground-alt = "#555";
    primary = "#ffb52a";
    secondary = "#e60053";
    alert = "#bd2c40";
  };
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      fonts = [ "pango 12" "FontAwesome 12"];

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
          statusCommand = "${pkgs.polybar}/bin/polybar top";
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
        height = "2%";
	offset-y = "4%";
        radius = 6;
        fixed-center = true;
        # Just sticking them together in the center for now
        background = "${colors.background}";
        foreground = "${colors.foreground}";

        line-size = 3;
        line-color = "#f00";

        border-size = 4;
        border-color = "#00000000";

        padding-left = 0;
        padding-right = 2;

        module-margin-left = 1;
        module-margin-right = 2;

        font-0 = "Font Awesome 5 Free,Font Awesome 5 Free Regular:style=Regular";
        font-1 = "Font Awesome 5 Free,Font Awesome 5 Free Solid:style=Solid";
        font-2 = "Font Awesome 5 Brands,Font Awesome 5 Brands Regular:style=Regular";
        font-3 = "fixed:pixelsize=13;1";
        font-4 = "unifont:fontformat=truetype:size=8:antialias=false;0";
        font-5 = "siji:pixelsize=13;1";

        modules-left = "bspwm i3";
        modules-center = "xwindow";
        modules-right = "filesystem pulseaudio xkeyboard memory cpu wlan eth battery temperature date powermenu";

        tray-position = "center";
        tray-padding = 0;
        tray-detached = false;

        wm-restack = "i3";

        scroll-up = "i3wm-wsnext";
        scroll-down = "i3wm-wsprev";

        cursor-click = "pointer";
        cursor-scroll = "ns-resize";
      };
      "module/xwindow" = {
        type = "internal/xwindow";
        label = "%title:0:50:...%";
      };

      "module/xkeyboard" = {
        type = "internal/xkeyboard";
        blacklist-0 = "num lock";
        format-prefix = " ";
        format-prefix-foreground = "${colors.foreground-alt}";
        format-prefix-underline = "${colors.secondary}";
        label-layout = "%layout%";
        label-layout-underline = "${colors.secondary}";

        label-indicator-padding = 2;
        label-indicator-margin = 1;
        label-indicator-background = "${colors.secondary}";
        label-indicator-underline = "${colors.secondary}";
      };
      "module/filesystem" = {
        type = "internal/fs";
        interval = 25;

        mount-0 = "/";

        label-mounted = "%{F#0a81f5}%mountpoint%%{F-}: %percentage_used%%";
        label-unmounted = "%mountpoint% not mounted";
        label-unmounted-foreground = "${colors.foreground-alt}";
      };
      "module/bspwm" = {
        type = "internal/bspwm";

        label-focused = "%index%";
        label-focused-background = "${colors.background-alt}";
        label-focused-underline= "${colors.primary}";
        label-focused-padding = 2;

        label-occupied = "%index%";
        label-occupied-padding = 2;

        label-urgent = "%index%!";
        label-urgent-background = "${colors.alert}";
        label-urgent-padding = 2;

        label-empty = "%index%";
        label-empty-foreground = "${colors.foreground-alt}";
        label-empty-padding = 2;
      };

      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";
        index-sort = true;
        wrapping-scroll = false;

        label-mode-padding = 2;
        label-mode-foreground = "#000";
        label-mode-background = "${colors.primary}";

        label-focused = "%index%";
        label-focused-background = "${colors.background-alt}";
        label-focused-underline= "${colors.primary}";
        label-focused-padding = 2;

        label-unfocused = "%index%";
        label-unfocused-padding = 2;

        label-visible = "%index%";
        label-visible-background = "${colors.background-alt}";
        label-visible-underline = "${colors.primary}";
        label-visible-padding = 2;

        label-urgent = "%index%";
        label-urgent-background = "${colors.alert}";
        label-urgent-padding = "2";
      };

      "module/mpd" = {
        type = "internal/mpd";
        format-online = "<label-song>  <icon-prev> <icon-stop> <toggle> <icon-next>";

        icon-prev = "";
        icon-stop = "";
        icon-play = "";
        icon-pause = "";
        icon-next = "";

        label-song-maxlen = 25;
        label-song-ellipsis = true;
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 5;
        format-prefix = " ";
        format-prefix-foreground = "${colors.foreground-alt}";
        format-underline = "#f90000";
        label = "%percentage:2%%";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 5;
        format-prefix = " ";
        format-prefix-foreground = "${colors.foreground-alt}";
        format-underline = "#4bffdc";
        label = "%percentage_used%%";
      };

      "module/wlan" = {
        type = "internal/network";
        interface = "net1";
        interval = 3;

        format-connected = "<ramp-signal> <label-connected>";
        format-connected-underline = "#9f78e1";
        label-connected = "%essid%";

        ramp-signal-0 = "";
        ramp-signal-1 = "";
        ramp-signal-2 = "";
        ramp-signal-3 = "";
        ramp-signal-4 = "";
        ramp-signal-foreground = "${colors.foreground-alt}";

      };

      "module/eth" = {
        type = "internal/network";
        interface = "eno1";
        interval = 3;

        format-connected-underline = "#55aa55";
        format-connected-prefix = " ";
        format-connected-prefix-foreground = "${colors.foreground-alt}";
        label-connected = "%local_ip%";
      };

      "module/date" = {
        type = "internal/date";
        interval = 5;

        date-alt = "%Y-%m-%d";

        time = "%H:%M";
        time-alt = "%H:%M:%S";

        format-prefix = "";
        format-prefix-foreground = "${colors.foreground-alt}";
        format-underline = "#0a6cf5";

        label = "%date% %time%";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";

        format-volume = "<label-volume> <bar-volume>";
        label-volume = "VOL %percentage%%";
        label-volume-foreground = "${colors.foreground}";

        label-muted = "🔇 muted";
        label-muted-foreground = "#666";

        bar-volume-width = 7;
        bar-volume-foreground-0 = "#55aa55";
        bar-volume-foreground-1 = "#55aa55";
        bar-volume-foreground-2 = "#55aa55";
        bar-volume-foreground-3 = "#55aa55";
        bar-volume-foreground-4 = "#55aa55";
        bar-volume-foreground-5 = "#f5a70a";
        bar-volume-foreground-6 = "#ff5555";
        bar-volume-gradient = "false";
        bar-volume-indicator = "|";
        bar-volume-indicator-font = "2";
        bar-volume-fill = "─";
        bar-volume-fill-font = "2";
        bar-volume-empty = "─";
        bar-volume-empty-font = "2";
        bar-volume-empty-foreground = "${colors.foreground-alt}";
      };

      "module/battery" = {
        type = "internal/battery";
        battery = "BAT1";
        adapter = "ADP1";
        full-at = 98;

        format-charging = "<animation-charging> <label-charging>";
        format-charging-underline = "#ffb52a";

        format-discharging = "<ramp-capacity> <label-discharging>";
        format-discharging-underline = "#ffb52a";

        format-full-prefix = "F ";
        format-full-prefix-foreground = "${colors.foreground-alt}";
        format-full-underline = "#ffb52a";

        ramp-capacity-0 = "";
        ramp-capacity-1 = "";
        ramp-capacity-2 = "";
        ramp-capacity-3 = "";
        ramp-capacity-4 = "";
        ramp-capacity-foreground = "${colors.foreground-alt}";

        animation-charging-0 = "";
        animation-charging-1 = "";
        animation-charging-2 = "";
        animation-charging-3 = "";
        animation-charging-4 = "";
        animation-charging-foreground = "${colors.foreground-alt}";
        animation-charging-framerate = 750;
      };

      "settings" = {
        screenchange-reload = true;
      };

      "global/wm" = {
        margin-top = 5;
        margin-bottom = 0;
      };
    };
    script = ''
    polybar top &
    '';
  };
}
