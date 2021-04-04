{ pkgs, ... }:

{
  home.packages = [
    # packages
    pkgs.starship
    pkgs.neovim-nightly
    pkgs.tree-sitter
  ];

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  programs = {
    zsh = import ./zsh.nix { inherit pkgs; };

    neovim = import ./neovim { inherit pkgs; };

    starship = {
      enable = true;

      settings = {
          add_newline = false;
      };
    };
  };
}
