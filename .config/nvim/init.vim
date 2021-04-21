"sheerun/vim-polyglot
let g:polyglot_disabled = ['markdown']
let g:polyglot_disabled = ['markdown.plugin']

call plug#begin('~/.vim/plugged')

Plug 'liuchengxu/vim-which-key'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mbbill/undotree'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdcommenter'
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

syntax on 
filetype plugin on
colorscheme dracula

set cmdheight=2
set smartcase
set expandtab
set smartindent
set tabstop=2
set shiftwidth=2
set confirm
set title
set noshowmode
set termguicolors
set winwidth=79
set updatetime=50 
set number 
set encoding=UTF-8
set noswapfile
set nobackup
set nowritebackup
set scrolloff=10

"Keys Maps

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

nnoremap <SPACE> <Nop>
let mapleader=" "

"Navigate buffer
noremap <F5> <ESC>:bprevious<CR>
noremap <F6> <ESC>:bnext<CR>

"Close buffer
nmap <leader>q <ESC>:bd<CR>

"Save w --- Exit q
nmap w <ESC>:w<CR>
nmap q <ESC>:q<CR>

"Move the lines up and down
nmap <leader><Down> ddp
nmap <leader><Up> ddkP

"Place date like Ter 26/Out/2004 hs 10:53
iab ,d <C-R>=strftime("%a %d/%b/%Y hs %H:%M")<CR>

"use alt+hjkl para mover entre split/vsplit paineis
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>l <C-w>l

"Plugins configs

" liuchengxu/vim-which-key
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

"vim-airline/vim-airline
set t_Co=256
let g:airline_theme="dracula"
let g:airline_powerline_fonts = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#hunks#coc_git = 1

" preservim/nerdcommenter
map cc <Plug>NERDCommenterInvert

" mbbill/undotree
nmap <F7> <ESC>:UndotreeToggle<CR>

"neoclide/coc.nvim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"Coc extensions
let g:coc_global_extensions = [
      \  'coc-html',
      \  'coc-css',
      \  'coc-snippets',
      \  'coc-git',
      \  'coc-svg',
      \  'coc-explorer',
      \  'coc-flutter',
      \  'coc-json', 
      \  'coc-tsserver', 
      \  'coc-flutter',
      \  'coc-styled-components',
      \  'coc-highlight',
      \  'coc-pairs',
      \  'coc-eslint',
      \  'coc-prettier',
      \  'coc-emmet',
      \   ]

"Toggle explorer
nnoremap <space>b :CocCommand explorer<CR>

"Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

"Use <Tab> and <S-Tab> to navigate the completion list:

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

"Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

"Make <CR> auto-select the first completion item and notify coc.nvim to
"format on enter, <cr> could be remapped by other vim plugin
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

