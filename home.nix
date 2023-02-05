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

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      gruvbox
      nerdtree

      # LSP
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp_luasnip
      luasnip

      # Treesitter
      (nvim-treesitter.withPlugins (p: [ 
        p.go
        p.haskell
      ]))

      vim-unimpaired # Helpful keybindings
      fzf-vim # For fzf search
      vim-airline
      pear-tree # Automatic pairing of brackets
      vim-gitgutter # For git
      vim-surround # Surround text with stuff
      tokyonight-nvim # Theme
      editorconfig-vim # editorconfig
      vim-obsession # For tracking vim sessions
      vim-commentary # For commenting code
    ];
  };

  xdg.configFile."nvim".source = ./config/neovim;

  programs.git = {
    enable = true;
    userName = "Amogh Rathore";
    userEmail = "amoghdroid09@gmail.com";
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    initExtra = ''
    . $HOME/.nix-profile/etc/profile.d/nix.sh
    '';
    # plugins = with pkgs; [
    #   {
    #     name = "agkozak-zsh-prompt";
    #     src = fetchFromGitHub {
    #       owner = "agkozak";
    #       repo = "agkozak-zsh-prompt";
    #       rev = "v3.11.1";
    #       sha256 = "0000000000000000000000000000000000000000000000000000";
    #     };
    #     file = "agkozak-zsh-prompt.plugin.zsh";
    #   }
    # ];
  };

  home.packages = with pkgs; [ tree fzf bat ];
}
