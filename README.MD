# CORPO

work macbook pro nix configuration

## Installation & Setup

### 1. clone the repository

Start by cloning the repository into your home directory:

```bash
git clone --recurse-submodules https://github.com/rraafays/CORPO ~/CORPO
```

### 2. create the symlink

Next, create a symlink from the cloned repository to `/etc/nix-darwin/CORPO`

```bash
sudo ln -s ~/CORPO /etc/nix-darwin/CORPO
```

### 3. modify `configuration.nix`

You will need to modify the existing configuration.nix located in `/etc/nix-darwin/`, 
to import the new configuration:

```nix
# /etc/nix-darwin/configuration.nix
{ config, pkgs, ... }:

{
  imports =
    [ 
      ./CORPO/configuration.nix
    ];

  # ... other configurations
}
```

### 4. apply the configuration

Finally, apply the configuration

```bash
sudo darwin-rebuild switch
```

### 5. switch user nixpkgs to unstable
```bash
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
```

## Managing Git Submodules

The repository uses Git submodules to manage external configurations and dependencies.
Below are some common operations for managing these submodules.

### 1. cloning modules

If you haven't already cloned the repository with submodules, you can initialise
and update them after cloning:

```bash
git submodule update --init --recursive
```

### 2. updating modules

To update all submodules to the latest commit on their respective branches:

```bash
git submodule update --remote --merge
```

### 3. adding modules

If you need to add a new module:

```bash
git submodule add <repository_url> modules/<module_name>
```

### 4. removing modules

To remove a module:

1. remove the relevant line from `.gitmodules`
2. remove the module's entry in .git/config
3. delete the module's directory
4. run `git rm --cached` on the submodule directory 

## Managing Nix Channels

Nix channels are collections of Nix packages that can be used to manage and update software. To work with nix-channel, you can use commands such as `nix-channel --add <url>` to add a channel and `nix-channel --update` to update the packages.

Having different Nix channels for the root user and a normal user is useful because it separates the system-wide configurations from user-specific ones. This ensures that system updates do not interfere with the user's development environment and vice versa, providing an extra layer of stability and security.
