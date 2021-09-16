call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

set hidden
set autoindent autoread
set background=dark t_Co=256
set encoding=UTF-8 
set hlsearch incsearch
set noswapfile nobackup nowritebackup nocompatible
set number relativenumber signcolumn=number
set shiftwidth=2 tabstop=2 softtabstop=2 expandtab 
set smartcase smartindent smarttab
set title showcmd confirm
set updatetime=10 scrolloff=10 ttimeoutlen=10
set wildmenu path+=** 
set wildignore+=**/node_modules/**
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set winwidth=80

"Status-line
set laststatus=2
set statusline+=%#GitSignsAdd#
set statusline+=\ %t
set statusline+=%#GitSignsChange#
set statusline+=\ %{get(g:,'coc_git_status','')}
set statusline+=\ %{get(b:,'coc_git_status','')}
set statusline+=\ %{get(b:,'coc_git_blame','')}
set statusline+=%#GitSignsDelete#
set statusline+=\ %{StatusDiagnostic()}

colorscheme gruvbox
filetype plugin on
syntax enable

abbr pipe \|

nnoremap <SPACE> <Nop>
let mapleader=" "

noremap <leader>f :find 
noremap <leader>q :bd<CR> 
noremap <leader>t :vertical terminal 
noremap <leader>w :w<CR>h 

noremap <leader>h <c-w>h 
noremap <leader>j <c-w>j 
noremap <leader>k <c-w>k 
noremap <leader>l <c-w>l 

"Netrw
let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_browse_split=3
let g:netrw_liststyle=3
let g:netrw_preview=1
let g:netrw_winsize=30

"ToggleNetrw
let g:NetrwIsOpen=0

function! ToggleNetrw()
  if g:NetrwIsOpen
    let i = bufnr("$")
    while (i >= 1)
      if (getbufvar(i, "&filetype") == "netrw")
        silent exe "bwipeout " . i 
      endif
      let i-=1
    endwhile
    let g:NetrwIsOpen=0
  else
    let g:NetrwIsOpen=1
    silent Lexplore
  endif
endfunction

noremap <silent> <SPACE>b :call ToggleNetrw()<CR>

"neoclide/coc.nvim
nnoremap <leader>g :CocCommand git.chunkInfo<CR>
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)
nnoremap <silent> gt <Plug>(coc-type-definition)
nnoremap <silent><nowait> <leader>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <leader>d  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <leader>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>
nnoremap [g <Plug>(coc-git-prevchunk)
nnoremap ]g <Plug>(coc-git-nextchunk)

"Use <c-space> to trigger completion.
inoremap <silent><expr> <c-@> coc#refresh()

"Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"Make <CR> auto-select the first completion item and notify coc.nvim to format on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

let g:coc_global_extensions = [
      \"coc-css",
      \"coc-emmet",
      \"coc-flutter",
      \"coc-git",
      \"coc-go",
      \"coc-highlight",
      \"coc-html",
      \"coc-json",
      \"coc-lists",
      \"coc-phpls",
      \"coc-prettier",
      \"coc-pyright",
      \"coc-snippets",
      \"coc-sql",
      \"coc-tsserver",
      \"coc-vetur",
      \"coc-vimlsp",
      \]

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, ' Error: ' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, ' Warning: ' . info['warning'])
  endif
  return join(msgs, ' ')
endfunction

