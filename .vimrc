"Disable netrw plugin
let loaded_netrwPlugin = 1

call plug#begin('~/.vim/plugged')
Plug 'dracula/vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

set autoindent 
set autoread
set background=dark 
set cmdheight=2
set confirm
set cursorline
set encoding=UTF-8 
set expandtab 
set hidden
set hlsearch 
set incsearch
set mouse=a
set nobackup 
set nocompatible
set noswapfile 
set nowrap
set nowritebackup 
set number 
set path+=** 
set relativenumber
set scrolloff=10 
set shiftwidth=2 
set shortmess+=c
set showcmd 
set showmatch
set signcolumn=number
set smartcase 
set smartindent 
set smarttab
set softtabstop=2 
set t_Co=256
set tabstop=2 
set termguicolors
set title 
set ttimeoutlen=10
set updatetime=10 
set wildignore+=*.docx,*.jpeg,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set wildignore+=*/node_modules/*
set wildmenu 
set winwidth=80

"Status-line
set laststatus=1
set statusline=
set statusline+=%#Function#
set statusline+=\ %t
set statusline+=%#Conceal#
set statusline+=\ %{get(g:,'coc_git_status','')}
set statusline+=\ %{get(b:,'coc_git_status','')}
set statusline+=\ %{get(b:,'coc_git_blame','')}
set statusline+=%#Error#
set statusline+=\ %{StatusDiagnostic()}

colorscheme dracula
filetype plugin on
syntax on 
syntax enable 

"Open helpfiles in vertical split
augroup helpfiles
  au!
  au BufRead,BufEnter */doc/* wincmd L
augroup END

"Set cursor to pipe
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

"Define leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

"Navigation with leader key
noremap <leader>h <c-w>h 
noremap <leader>j <c-w>j 
noremap <leader>k <c-w>k 
noremap <leader>l <c-w>l 

noremap <leader>f :find 
noremap <leader>q :bd<CR> 
noremap <leader>t :vertical terminal 
noremap <leader>w :w<CR>h 

"neoclide/coc.nvim
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)
nnoremap <silent> gt <Plug>(coc-type-definition)

nnoremap <silent><nowait> <leader>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <leader>d  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <leader>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>

nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)

nmap <leader>g :CocCommand git.chunkInfo<CR>
nmap <c-g> :CocCommand git.showCommit<CR>

"Do NOT use `nore` mappings
nmap <c-t> <Plug>(coc-translator-p)
vmap <c-t> <Plug>(coc-translator-pv)
nmap <c-r> <Plug>(coc-translator-r)
vmap <c-r> <Plug>(coc-translator-rv)

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
      \"coc-browser",
      \"coc-clangd",
      \"coc-css",
      \"coc-diagnostic",
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
      \"coc-rls",
      \"coc-sh",
      \"coc-snippets",
      \"coc-sql",
      \"coc-svg",
      \"coc-translator",
      \"coc-tsserver",
      \"coc-vetur",
      \"coc-vimlsp",
      \"coc-yaml",
      \]

"LSP status diagnostic to statusline
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

