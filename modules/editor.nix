{pkgs, ...}:

{
  # enable neovim and set it as the default editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      "Split to right/below instead of left/up by default
      set splitright
      set splitbelow

      "Hybrid line numbers and ruler
      set number
      set relativenumber
      set ruler

      "Activate automatic indentation
      filetype off
      filetype plugin indent on
      set smartindent
      set autoindent

      "Non-expanded, 4-wide tabulations
      set tabstop=4
      set shiftwidth=4
      set noexpandtab

      "Real-world encoding
      set encoding=utf-8

      "Interpret modelines in files
      set modelines=1

      "Do not abandon buffers
      set hidden

      "More useful backspace behavior
      set backspace=indent,eol,start

      "Use statusbar on all windows
      set laststatus=2

      "Better search
      set ignorecase
      set smartcase
      set incsearch
      set showmatch
      set hlsearch

      "Break at word instead of character
      set linebreak

      "Save undo history to file
      set undofile
      set undodir=$HOME/.config/nvim/undo
      set undolevels=1000
      set undoreload=10000
    '';
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nerdtree;
        config = ''
          " Start NERDTree. If a file is specified, move the cursor to its window.
          autocmd StdinReadPre * let s:std_in=1
          autocmd VimEnter * NERDTree | if argc() > 0 && !isdirectory(argv()[0]) || exists("s:std_in") | wincmd p | endif
          " Start NERDTree when Vim starts with a directory argument.
          autocmd StdinReadPre * let s:std_in=1
          autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
          " Exit Vim if NERDTree is the only window remaining in the only tab.
          autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
          " Close the tab if NERDTree is the only window remaining in it.
          autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
        '';
      }
      nerdtree-git-plugin
      vim-nerdtree-syntax-highlight
      vim-nerdtree-tabs
      vim-nix
    ];
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  programs.helix.enable = true;
}
