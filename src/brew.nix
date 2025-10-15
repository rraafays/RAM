{ pkgs, ... }:

{
  homebrew = {
    enable = true;
    onActivation.upgrade = true;
    casks = [
      "betterdisplay"
      "cog-app"
      "cursorcerer"
      "homerow"
      "jordanbaird-ice"
      "karabiner-elements"
      "movist-pro"
      "showmeyourhotkeys"
      "wine-stable"
      "zen"
    ];
    brews = [
      "detox"
    ];
  };

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "betterdisplay" ''
      #!${stdenv.shell}
      open -a "BetterDisplay" "$@"
    '')
    (writeShellScriptBin "homerow" ''
      #!${stdenv.shell}
      open -a "Homerow" "$@"
    '')
    (writeShellScriptBin "ice" ''
      #!${stdenv.shell}
      open -a "Ice" "$@"
    '')
    (writeShellScriptBin "showmeyourhotkeys" ''
      #!${stdenv.shell}
      open -a "ShowMeYourHotKeys" "$@"
    '')
    (writeShellScriptBin "karabiner" ''
      #!${stdenv.shell}
      open -a "Karabiner-Elements" "$@"
    '')
    (writeShellScriptBin "movist" ''
      #!${stdenv.shell}
      open -a "Movist Pro" "$@"
    '')
    (writeShellScriptBin "zen" ''
      #!${stdenv.shell}
      open -a "Zen" "$@"
    '')
  ];

  launchd.daemons = {
    showmeyourhotkeys = {
      script = "open -ga ShowMeYourHotKeys";
      serviceConfig = {
        KeepAlive = false;
        RunAtLoad = true;
      };
    };
    ice = {
      script = "open -ga Ice";
      serviceConfig = {
        KeepAlive = false;
        RunAtLoad = true;
      };
    };
    betterdisplay = {
      script = "open -ga BetterDisplay";
      serviceConfig = {
        KeepAlive = false;
        RunAtLoad = true;
      };
    };
  };
}
