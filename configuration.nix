{ pkgs, lib, ... }:

let
  STATE_VERSION = "24.11";
  USER = "raf";
  DARWIN_STATE_VERSION = 5;

  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${STATE_VERSION}.tar.gz";
in
{
  home-manager.users.${USER}.home.stateVersion = "${STATE_VERSION}";

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      nur = import (fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
      unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {
        inherit pkgs;
      };
    };
  };

  imports = [
    "${home-manager}/nix-darwin"
    ./modules/brew
    ./modules/darwin
    ./modules/environment
    ./modules/fonts
    ./modules/home
    ./modules/work
    ./modules/neovim
  ];

  networking.hostName = "CORPO";
  programs.fish = {
    enable = true;
    shellInit = ''set -x LIBRARY_PATH (string join ' ' $LIBRARY_PATH ${
      lib.makeLibraryPath [ pkgs.libiconv ]
    })'';
  };
  environment = {
    darwinConfig = "/etc/nix-darwin/configuration.nix";
    shells = [ pkgs.fish ];
  };

  users = {
    knownUsers = [ USER ];
    users.${USER} = {
      name = USER;
      home = "/Users/${USER}";
      shell = pkgs.fish;
      uid = 502;
    };
  };

  system = {
    stateVersion = DARWIN_STATE_VERSION;
    activationScripts = {
      postUserActivation.text = ''
        /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
      '';
      dotfiles.text = ''
        if [ -L /root/.config ]; then
            rm /root/.config
        elif [ -d /root/.config ]; then
            rm -rf /root/.config
        fi
        ln -s /home/${USER}/.config /root/.config
        chown -R ${USER} /home/${USER}/.config
      '';
    };
  };
}
