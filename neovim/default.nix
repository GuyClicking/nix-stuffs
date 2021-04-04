{ pkgs, ... }:

{
  enable = true;
  package = pkgs.neovim-nightly;
  extraConfig = ''
    lua << EOF
      ${builtins.readFile ./init.lua}

      function c()
        ${builtins.readFile ./c.lua}
      end
      function cpp()
        ${builtins.readFile ./cpp.lua}
      end
      function lua()
        ${builtins.readFile ./lua.lua}
      end
    EOF
    au BufEnter *.c lua c()
    au BufEnter *.cpp lua cpp()
    au BufEnter *.lua lua lua()
  '';
#      ${builtins.readFile ./settings.vim}
  plugins = with pkgs.vimPlugins; [
    { plugin = vim-nix; }
    { plugin = idris2-vim; }
    { plugin = gruvbox; config = "colorscheme gruvbox"; }
    { plugin = nvim-lspconfig; config = "lua require'lspconfig'.ccls.setup{}"; }
    # ill fix tree sitter when i switch to nixos
    #{ plugin = nvim-treesitter; config = "lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}"; }
  ];
}
