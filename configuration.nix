{ pkgs, ... }:

let
  USER = "raf";
  DARWIN_STATE_VERSION = 5;
in
{
  imports = [
    ./src/aerospace.nix
    ./src/brew.nix
    ./src/environment.nix
    ./src/fonts.nix
    ./src/system.nix
  ];

  networking.hostName = "RAM";

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

  system = {
    stateVersion = DARWIN_STATE_VERSION;
    primaryUser = USER;
  };

  programs.fish.enable = true;
  users = {
    knownUsers = [
      USER
      "root"
    ];
    users = {
      root = {
        shell = pkgs.fish;
        uid = 0;
      };
      ${USER} = {
        name = USER;
        home = "/Users/${USER}";
        shell = pkgs.fish;
        uid = 502;
        packages = with pkgs; [
          (writeShellScriptBin "su" ''
            #!${stdenv.shell}
            /usr/bin/sudo /usr/bin/su "$@"
          '')
          adbfs-rootless
          android-tools
          bandwhich
          hyperfine
          kitty
          sacad
          spotdl
          sptlrx
          substudy
          yt-dlp-light
          zathura

          nodePackages_latest.nodejs
        ];
      };
    };
  };

  homebrew = {
    enable = true;
    onActivation.upgrade = true;
    casks = [
      "docker-desktop"
      "google-chrome"
      "intellij-idea"
      "microsoft-teams"
      "postman"
    ];
  };
}
