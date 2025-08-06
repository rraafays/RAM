{ pkgs, ... }:

let
  USER = "raf";
  DARWIN_STATE_VERSION = 5;
in
{
  imports = [
    ./modules/aerospace
    ./modules/darwin
    ./modules/brew
    ./modules/environment
    ./modules/fonts
    ./modules/neovim
    ./modules/work
  ];

  networking.hostName = "CORPO";

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
    knownUsers = [ USER "root" ];
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
          mpv
          sacad
          spotdl
          sptlrx
          substudy
          yt-dlp-light
          zathura
          awscli2
          jira-cli-go
        ];
      };
    };
  };
}
