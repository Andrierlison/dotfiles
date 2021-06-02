let g:polyglot_disabled = ['markdown', 'markdown.plugin', 'autoindent']

call plug#begin('~/.vim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'mbbill/undotree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

colorscheme dracula
filetype plugin on
syntax enable

set hls cursorline expandtab incsearch smartcase smartindent confirm title hidden wildmenu number nocompatible
set noswapfile nobackup nowritebackup noshowmode
set encoding=UTF-8 updatetime=50 scrolloff=10

let g:netrw_liststyle = 3
let g:netrw_wiw = 30

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

"Move the lines up and down
nmap <leader><Down> ddp
nmap <leader><Up> ddkP

"Place date like Ter 26/Out/2004 hs 10:53
iab ,d <C-R>=strftime("%a %d/%b/%Y hs %H:%M")<CR>

"Plugins configs

"vim-airline/vim-airline
set t_Co=256
let g:airline_theme="dracula"
let g:airline_powerline_fonts = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#hunks#coc_git = 1

" mbbill/undotree
nmap <F7> <ESC>:UndotreeToggle<CR>

" neoclide/coc.nvim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

let g:coc_global_extensions = [
                  \  'coc-css',
                  \  'coc-emmet',
                  \  'coc-eslint',
                  \  'coc-flutter',
                  \  'coc-git',
                  \  'coc-highlight',
                  \  'coc-html',
                  \  'coc-json', 
                  \  'coc-pairs',
                  \  'coc-prettier',
                  \  'coc-snippets',
                  \  'coc-styled-components',
                  \  'coc-svg',
                  \  'coc-tsserver', 
                  \]

"Use <C-l> for trigger snippet expand.
imap <C-l>  <Plug>(coc-snippets-expand)

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

" Make <CR> auto-select the first completion item and notify coc.nvim to format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)"]`
