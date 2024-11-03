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
      pywal-nvim
      coc-clangd
      vim-polyglot
      vim-dispatch
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
      set tabstop=4
      set shiftwidth=4
      set expandtab
      set cursorline
      highlight CursorLine cterm=NONE ctermbg=238

      colorscheme pywal
      
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

     " set statusline=

     " " Status line left side.
     " set statusline+=\ %F\ %M\ %Y\ %R
     " 
     " " Use a divider to separate the left side from the right side.
     " set statusline+=%=
     " 
     " " Status line right side.
     " "set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
     " 
     " " Show the status on the second to last line.
     " set laststatus=2

      "Compile Mode | Something like emacs I guess???
      nnoremap <silent> <M-m> :Make<CR>


      " Status Bar
      set laststatus=2  " Always show the status line
      set statusline=%f                   " Filename
      set statusline+=\ [%{&filetype}]    " Filetype
      set statusline+=\ [%{&ff}]          " File format
      set statusline+=\ [%{&encoding}]    " Encoding
      set statusline+=\ %m                " Modified flag
      set statusline+=\ %r                " Readonly flag
      set statusline+=\ %y                " File type name
      set statusline+=\ %{getfsize("%") > 0 ? '✔️' : '❌'} " File exists check
      set statusline+=\ %{line('.')}:%{line('$')} " Line number
      set statusline+=\ %p%%              " Percentage through file
      set statusline+=\ \ %l/%L           " Current line / total lines
      set statusline+=\ %a                " Current mode (insert, normal, etc.)
      
      " Make the status line more visible
      highlight StatusLine cterm=bold ctermfg=White ctermbg=DarkBlue
      highlight StatusLineNC ctermfg=Gray ctermbg=Black
      
      " Optional: Show the ruler and set ruler format
      set ruler
      set rulerformat=%l:%c
      '';
    };

    xdg.configFile."nvim/coc-settings.json".text = ''
      {
        "inlayHint.enable": false,
      }
    '';
}
