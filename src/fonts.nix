{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      (iosevka-bin.override { variant = "SGr-IosevkaTermCurly"; })
      (iosevka-bin.override { variant = "Aile"; })
      (iosevka-bin.override { variant = "Etoile"; })
      nerd-fonts.symbols-only
      noto-fonts-emoji
      sarabun-font
      sarasa-gothic
    ];
  };
}
