{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "home";
  home.homeDirectory = "/Users/home";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      gruvbox
      nerdtree

      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp_luasnip
      luasnip

      (nvim-treesitter.withPlugins (p: [ 
        p.go
        p.haskell
      ]))

      vim-unimpaired
      fzf-vim
      vim-airline
      pear-tree
      vim-gitgutter
      vim-surround
      tokyonight-nvim
      editorconfig-vim
      vim-obsession
    ];
  };

  xdg.configFile."nvim".source = ./config/neovim;

  home.packages = with pkgs; [ tree fzf ];
}
