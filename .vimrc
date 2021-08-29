call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
call plug#end()

let loaded_netrwPlugin = 1

set lazyredraw
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
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"Help files always open in a vertical split on the right
augroup helpfiles
  au!
  au BufRead,BufEnter */doc/* wincmd L
augroup END

"Change Vim cursor in different modes
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\" 
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"

nnoremap <SPACE> <Nop>
let mapleader=" "

for key in ['<Up>', '<Down>', '<Left>', '<Right>']
  exec 'noremap' key '<Nop>'
  exec 'inoremap' key '<Nop>'
  exec 'vnoremap' key '<Nop>'
endfor

noremap <leader>f <ESC>:find 
noremap <leader>r <ESC>:vertical terminal ranger<CR>
noremap <leader>t <ESC>:vertical terminal 

noremap <leader>q <ESC>:bd<CR> 
noremap <leader>w <ESC>:w<CR> 

noremap <leader>h <ESC><c-w>h 
noremap <leader>j <ESC><c-w>j 
noremap <leader>k <ESC><c-w>k 
noremap <leader>l <ESC><c-w>l 

"Move the lines up and down
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

"neoclide/coc.nvim
nmap <C-g> <esc>:CocCommand git.chunkInfo<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gt <Plug>(coc-type-definition)
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
nnoremap <silent> <SPACE>b :CocCommand explorer<CR>
nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>
nnoremap <silent><nowait> <leader>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <leader>d  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <leader>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>

"Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-leader> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

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

"Make <CR> auto-select the first completion item and notify coc.nvim to format on enter, <cr> could be remapped by other vim plugin
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

"For scss files, you may need use
autocmd FileType scss setl iskeyword+=@-@

let g:coc_global_extensions = [
      \"coc-css",
      \"coc-emmet",
      \"coc-explorer",
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
      \"coc-vimlsp",
      \"coc-yank",
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

