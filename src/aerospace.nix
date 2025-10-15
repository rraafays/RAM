{ pkgs, ... }:

{
  homebrew.taps = ["FelixKratz/formulae"];
  homebrew = {
    enable = true;
    onActivation.upgrade = true;
    brews = [ "borders" ];
  };

  services = {
    aerospace = {
      enable = true;
      settings = {
        default-root-container-layout = "tiles";
        gaps = {
          inner.horizontal = 20;
          inner.vertical = 20;
          outer.top = 10;
          outer.right = 20;
          outer.bottom = 20;
          outer.left = 20;
        };

        mode.main.binding = {
          alt-cmd-ctrl-enter = "exec-and-forget ${pkgs.kitty}/bin/kitty -1 ${pkgs.tmux}/bin/tmux new-session -A -c ~/ -s main >/dev/null 2>&1";
          alt-cmd-ctrl-m = "macos-native-fullscreen";
          alt-cmd-ctrl-q = "close";

          alt-cmd-ctrl-semicolon = "layout tiles";
          alt-cmd-ctrl-quote = "layout accordion";

          alt-cmd-ctrl-left = "focus left";
          alt-cmd-ctrl-down = "focus down";
          alt-cmd-ctrl-up = "focus up";
          alt-cmd-ctrl-right = "focus right";

          shift-alt-cmd-ctrl-left = "move left";
          shift-alt-cmd-ctrl-down = "move down";
          shift-alt-cmd-ctrl-up = "move up";
          shift-alt-cmd-ctrl-right = "move right";

          alt-cmd-ctrl-1 = "workspace 1";
          alt-cmd-ctrl-2 = "workspace 2";
          alt-cmd-ctrl-3 = "workspace 3";
          alt-cmd-ctrl-4 = "workspace 4";
          alt-cmd-ctrl-5 = "workspace 5";
          alt-cmd-ctrl-6 = "workspace 6";
          alt-cmd-ctrl-7 = "workspace 7";
          alt-cmd-ctrl-8 = "workspace 8";
          alt-cmd-ctrl-9 = "workspace 9";
          alt-cmd-ctrl-0 = "workspace 10";

          shift-alt-cmd-ctrl-1 = "move-node-to-workspace 1";
          shift-alt-cmd-ctrl-2 = "move-node-to-workspace 2";
          shift-alt-cmd-ctrl-3 = "move-node-to-workspace 3";
          shift-alt-cmd-ctrl-4 = "move-node-to-workspace 4";
          shift-alt-cmd-ctrl-5 = "move-node-to-workspace 5";
          shift-alt-cmd-ctrl-6 = "move-node-to-workspace 6";
          shift-alt-cmd-ctrl-7 = "move-node-to-workspace 7";
          shift-alt-cmd-ctrl-8 = "move-node-to-workspace 8";
          shift-alt-cmd-ctrl-9 = "move-node-to-workspace 9";
          shift-alt-cmd-ctrl-0 = "move-node-to-workspace 10";

          alt-cmd-ctrl-f1 = "focus-monitor 1";
          alt-cmd-ctrl-f2 = "focus-monitor 2";
          alt-cmd-ctrl-f3 = "focus-monitor 3";
          alt-cmd-ctrl-f4 = "focus-monitor 4";
          alt-cmd-ctrl-f5 = "focus-monitor 5";
          alt-cmd-ctrl-f6 = "focus-monitor 6";
          alt-cmd-ctrl-f7 = "focus-monitor 7";
          alt-cmd-ctrl-f8 = "focus-monitor 8";
          alt-cmd-ctrl-f9 = "focus-monitor 9";
          alt-cmd-ctrl-f10 = "focus-monitor 10";

          shift-alt-cmd-ctrl-f1 = "move-node-to-monitor 1";
          shift-alt-cmd-ctrl-f2 = "move-node-to-monitor 2";
          shift-alt-cmd-ctrl-f3 = "move-node-to-monitor 3";
          shift-alt-cmd-ctrl-f4 = "move-node-to-monitor 4";
          shift-alt-cmd-ctrl-f5 = "move-node-to-monitor 5";
          shift-alt-cmd-ctrl-f6 = "move-node-to-monitor 6";
          shift-alt-cmd-ctrl-f7 = "move-node-to-monitor 7";
          shift-alt-cmd-ctrl-f8 = "move-node-to-monitor 8";
          shift-alt-cmd-ctrl-f9 = "move-node-to-monitor 9";
          shift-alt-cmd-ctrl-f10 = "move-node-to-monitor 10";
        };
      };
    };
  };

  launchd.daemons = {
    borders = {
      script = ''
        exec /opt/homebrew/bin/borders order=above active_color=0xFFFFFFFF inactive_color=0xFF262626 width=3.0
      '';
      serviceConfig = {
        KeepAlive = true;
        RunAtLoad = true;
      };
    };
    wallpaper = {
      script = ''
        exec osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"/System/Library/Desktop Pictures/Solid Colors/Black.png\" as POSIX file"
      '';
      serviceConfig = {
        KeepAlive = true;
        RunAtLoad = true;
      };
    };
  };
}
