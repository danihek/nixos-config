{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      codeium-vim
      coc-nvim
      mini-nvim
      coc-clangd
      plenary-nvim
      vim-polyglot
      vim-css-color
      nvim-autopairs
      nvim-lspconfig
      vim-unimpaired
      tailwindcss-colors-nvim
      nvim-treesitter.withAllGrammars
    ];

  extraConfig = ''
    syntax on
    filetype plugin indent on
    set ts=3 sts=2 sw=2 et ai si
    set incsearch
    set ignorecase
    set wildmenu
    set wildmode=list:longest
    set number relativenumber
    set nu rnu

    colorscheme retrobox
    
    <script><silent><nowait><expr> codeium#Disable()
    vim.g.codeium_disable_bindings = 1
    imap <script><silent><nowait><expr> <C-g> codeium#Accept()
    imap <C-;>   <Cmd>call codeium#CycleCompletions(1)<CR>
    imap <C-,>   <Cmd>call codeium#CycleCompletions(-1)<CR>
    imap <C-x>   <Cmd>call codeium#Clear()<CR>

    inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<C-n>"
    inoremap <silent><expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<C-p>"
    inoremap <silent><expr> <down> coc#pum#visible() ? coc#pum#next(0) : "\<down>"
    inoremap <silent><expr> <up> coc#pum#visible() ? coc#pum#prev(0) : "\<up>"

    inoremap <silent><expr> <PageDown> coc#pum#visible() ? coc#pum#scroll(1) : "\<PageDown>"
    inoremap <silent><expr> <PageUp> coc#pum#visible() ? coc#pum#scroll(0) : "\<PageUp>"

    inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : "\<C-e>"
    inoremap <silent><expr> <C-y> coc#pum#visible() ? coc#pum#confirm() : "\<C-y>"

    inoremap <silent><expr> <cr> "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    inoremap <silent><expr> <tab> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<tab>"

    set cursorline
    highlight CursorLine cterm=NONE ctermbg=238
    '';
  };

  xdg.configFile."nvim/coc-settings.json".text = ''
    {
      "inlayHint.enable": false,
    }
  '';
}
