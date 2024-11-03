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


      " Status Line
      set laststatus=2    " Always show status line
      set statusline=
      
      let g:light_sep = '➤'
      let g:dark_sep = '⮚'
      
      let g:status_file = '📄'   " General file icon
      let g:status_code = '💻'   " Code icon
      
      " Statusline elements
      set statusline+=%#StatusLine#                 " Highlight group for regular text
      set statusline+=%{g:status_file}              " File icon at start
      set statusline+=\ %{expand('%:t')}\           " Filename
      set statusline+=%m                             " Modified flag
      set statusline+=%=%{g:dark_sep}               " Right-align separator
      
      set statusline+=%#StatusLineAccent#           " Custom highlight group
      set statusline+=\ %{g:light_sep}\             " Separator with arrow
      set statusline+=%{strftime("📅 %Y年%m月%d日")} " Date with Japanese year/month/day symbols
      set statusline+=\ %{strftime("🕒 %H:%M")}\    " Time
      set statusline+=%{g:dark_sep}                 " Separator with accent
      
      " Add filetype and cursor position
      set statusline+=%#StatusLineFileType#         " Highlight group for filetype
      set statusline+=%{g:status_code}\ %Y          " Filetype icon and filetype
      set statusline+=%#StatusLine#\                " Switch back to normal
      set statusline+=%l:%c                         " Line and column numbers
    
      " Statusline colors
      highlight StatusLine guifg=#D0D0D0 guibg=#3C3836
      highlight StatusLineAccent guifg=#FFFFFF guibg=#505050
      highlight StatusLineFileType guifg=#EAD0A6 guibg=#3C3836
      highlight StatusLineModified guifg=#FF5F5F guibg=#3C3836
      '';
    };

    xdg.configFile."nvim/coc-settings.json".text = ''
      {
        "inlayHint.enable": false,
      }
    '';
}
