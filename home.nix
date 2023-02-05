{ config, pkgs, ... }:

{
  home.username = "home";
  home.homeDirectory = "/Users/home";
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
      vim-devicons # icons!!
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
    plugins = with pkgs; [
      {
        name = "agkozak-zsh-prompt";
        src = fetchFromGitHub {
          owner = "agkozak";
          repo = "agkozak-zsh-prompt";
          rev = "v3.11.1";
          sha256 = "1rl0bqmflz7c1n6j6n4677x6kscc160s6zd5his8bf1m3idw1rsc";
        };
        file = "agkozak-zsh-prompt.plugin.zsh";
      }
    ];
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    historySubstringSearch = {
      enable = true;
    };
    shellAliases = {
      ll = "ls -la";
      gst = "git status";
      ga = "git add";
      gco = "git checkout";
      gfo = "git fetch origin";
      gfu = "git fetch upstream";
      gd = "git diff";
      gdc = "git diff --cached";
      gdca = "git diff --cached";
      gcmsg = "git commit -m";
      glo = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      ggp = "git push origin";
      ggl = "git pull origin";
    };
  };

  home.packages = with pkgs; [ tree fzf bat neovim-remote ];
}
