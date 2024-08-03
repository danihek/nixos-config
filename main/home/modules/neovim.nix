{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
     #codeium
      coc-nvim
      mini-nvim
      plenary-nvim
      vim-polyglot
      vim-css-color
      nvim-autopairs
      nvim-lspconfig
      vim-unimpaired
      tailwindcss-colors-nvim
      nvim-treesitter.withAllGrammars
    ];

  extraConfig =  ''
    syntax on
    filetype plugin indent on
    set ts=3 sts=2 sw=2 et ai si
    set incsearch
    set ignorecase
    set wildmenu
    set wildmode=list:longest
    set number relativenumber
    set nu rnu
    noremap <C-s> :e#<CR>
    '';
  };
}
