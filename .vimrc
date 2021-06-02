"sheerun/vim-polyglot
let g:polyglot_disabled = ['markdown', 'markdown.plugin', 'autoindent']

call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-signify' 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

colorscheme gruvbox
filetype plugin on
syntax enable

set encoding=UTF-8 updatetime=50 scrolloff=10 background=dark path+=** wildignore+=**/node_modules/** 
set hls cursorline expandtab incsearch smartcase smartindent confirm title hidden wildmenu number nocompatible
set noswapfile nobackup nowritebackup noshowmode

"Netrw
let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_browse_split=3
let g:netrw_liststyle=3
let g:netrw_preview=1
let g:netrw_winsize=0

"Change Vim cursor in different modes
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\" 
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"

"Keys Maps

nnoremap <SPACE> <Nop>
let mapleader=" "

imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
imap <up> <nop>
nmap <down> <nop>
nmap <left> <nop>
nmap <right> <nop>
nmap <up> <nop>

"Open find command
noremap <leader>f <ESC>:find 

"Open ranger
noremap <leader>r <ESC>:vertical terminal ranger<CR>

"Open git command option 
noremap <leader>g <ESC>:vertical terminal git 

"Go to terminal
noremap <leader>t <ESC>:vertical terminal 

"Move the lines up and down
nmap <leader><Down> ddp
nmap <leader><Up> ddkP

"Place date like Ter 26/Out/2004 hs 10:53
iab ,d <C-R>=strftime("%a %d/%b/%Y hs %H:%M")<CR>

"Plugins configs

"vim-airline/vim-airline
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#hunks#coc_git = 1
let g:airline_powerline_fonts = 1
let g:airline_theme="gruvbox"
set t_Co=256

"mbbill/undotree
nmap <F7> <ESC>:UndotreeToggle<CR>

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
      \   "coc-css",
      \   "coc-emmet",
      \   "coc-flutter",
      \   "coc-highlight",
      \   "coc-html",
      \   "coc-json",
      \   "coc-prettier",
      \   "coc-pyright",
      \   "coc-snippets",
      \   "coc-svg",
      \   "coc-tsserver",
      \   "coc-yaml"
      \ ]
