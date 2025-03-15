# CORPO

work macbook pro nix configuration

## setup

### 1. install nix & brew

```bash
curl -sSf -L https://install.lix.systems/lix | sh -s -- install
```
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. clone this config

```bash
git clone --recurse-submodules https://github.com/rraafays/CORPO ~/CORPO
```

### 2. link to `/etc`

```bash
sudo ln -s ~/CORPO /etc/nix-darwin/CORPO
```

### 3. copy `configuration.nix`

```bash
sudo cp ./etc/configuration.nix /etc/nix-darwin/configuration.nix
```

### 4. switch channels to unstable

```bash
sudo nix-channel --add https://github.com/LnL7/nix-darwin/archive/master.tar.gz darwin
sudo nix-channel --update
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
```

### 5. run first install

```bash
nix-build '<darwin>' -A darwin-rebuild
./result/bin/darwin-rebuild switch -I darwin-config=/etc/nix-darwin/configuration.nix
```
