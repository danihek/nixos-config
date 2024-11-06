{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      sonokai
      pywal-nvim
      dracula-vim
      iceberg-vim
      tokyonight-nvim
      papercolor-theme
      gruvbox-material gruvbox
      gruvbox-light

      coc-nvim
      mini-nvim
      coc-clangd
      vim-polyglot
      vim-dispatch
      vim-css-color
      nvim-autopairs
      nvim-lspconfig
      vim-unimpaired
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
      set tabstop=4
      set shiftwidth=4
      set expandtab
      set cursorline

      colorscheme pywal
      "colorscheme peachpuff
      "colorscheme gruvbox

      highlight StatusLine    guifg=#ffcc00 guibg=#1c1c1c
      highlight StatusLineNC  guifg=#666666 guibg=#1c1c1c
      highlight StatusAccent  guifg=#fcc6f9 guibg=#1c1c1c
      highlight StatusAccent2 guifg=#cfff99 guibg=#1c1c1c
      highlight StatusAccent3 guifg=#81f787 guibg=#1c1c1c

      set list
      set listchars=space:·,tab:→\ ,trail:·

      "While searching and go C-d C-u its centred
      nnoremap n nzz
      nnoremap N Nzz
      nnoremap <C-d> <C-d>zz
      nnoremap <C-u> <C-u>zz
      
     "Compile Mode | Something like emacs I guess???
      nnoremap <silent> <M-m> :Make<CR>

      " Status Line
      set laststatus=2

      if has('termguicolors')
        set termguicolors
      endif 
      
      function! JapaneseDate()
        return strftime("%H:%M | %d日%m月%Y年")
      endfunction
      
      set statusline=
      set statusline+=%#StatusAccent3#
      set statusline+=\ %y                   " File type
      set statusline+=%#StatusAccent2#
      set statusline+=\ [
      set statusline+=%#StatusLine#
      set statusline+=\ %f
      set statusline+=%#StatusAccent2#
      set statusline+=\ ]

      set statusline+=%#StatusLineNC#
      set statusline+=%m
      set statusline+=%r

      set statusline+=%#StatusLine#
      set statusline+=\ %l:%c
      set statusline+=\ %p%%                 " Percentage through file

      set statusline+=%=                     " Right-align section starts here
      set statusline+=%#StatusAccent#
      set statusline+=\ %{JapaneseDate()}
      
      "Conquer of Completion
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

      " Codeuim
      let g:codeium_enabled = v:false
      let g:codeium_disable_bindings = 1
      let g:vim_markdown_folding_disabled = 1
      imap <script><silent><nowait><expr> <C-j> codeium#Accept()
      imap <C-;>   <Cmd>call codeium#CycleCompletions(1)<CR>
      imap <C-,>   <Cmd>call codeium#CycleCompletions(-1)<CR>
      imap <C-x>   <Cmd>call codeium#Clear()<CR>
'';
    };

    xdg.configFile."nvim/coc-settings.json".text = ''
      {
        "inlayHint.enable": false,
      }
    '';
}
