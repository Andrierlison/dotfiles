call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

colorscheme gruvbox
filetype plugin on
syntax enable

if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

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
set statusline+=%#ErrorMsg#\%{StatusDiagnostic()}\%#Statusline#\ %t\  

"Help files always open in a vertical split on the right
augroup helpfiles
  au!
  au BufRead,BufEnter */doc/* wincmd L
augroup END

"Change Vim cursor in different modes
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\" 
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"

"Keys Maps

nnoremap <SPACE> <Nop>
let mapleader=" "

"Disable arrow keys
for key in ['<Up>', '<Down>', '<Left>', '<Right>']
  exec 'noremap' key '<Nop>'
  exec 'inoremap' key '<Nop>'
  exec 'vnoremap' key '<Nop>'
endfor

"Open find command
noremap <leader>f <ESC>:find 

"Open ranger
noremap <leader>r <ESC>:vertical terminal ranger<CR>

"Open git command option 
noremap <leader>g <ESC>:vertical terminal git 

"Go to terminal
noremap <leader>t <ESC>:vertical terminal 

"Move the lines up and down
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

"Place date like Ter 26/Out/2004 hs 10:53
iab ,d <C-R>=strftime("%a %d/%b/%Y hs %H:%M")<CR>

"Netrw
let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_browse_split=3
let g:netrw_liststyle=3
let g:netrw_preview=1
let g:netrw_winsize=16

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

"Plugins configs

"neoclide/coc.nvim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gt <Plug>(coc-type-definition)

"Use <C-l> for trigger snippet expand.
imap <C-l>  <Plug>(coc-snippets-expand)

"Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

"Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

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

let g:coc_global_extensions = [
      \"coc-css",
      \"coc-flutter",
      \"coc-highlight",
      \"coc-html",
      \"coc-json",
      \"coc-phpls",
      \"coc-prettier",
      \"coc-snippets",
      \"coc-tsserver",
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

