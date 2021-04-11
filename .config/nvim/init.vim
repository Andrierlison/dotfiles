call plug#begin('~/.vim/plugged')

Plug 'liuchengxu/vim-which-key'
Plug 'mhinz/vim-signify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'voldikss/fzf-floaterm'
Plug 'voldikss/vim-floaterm'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'simeji/winresizer'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'thosakwe/vim-flutter'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'

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
set mouse=a
set updatetime=50 
set number 
set encoding=UTF-8
set noswapfile
set nobackup
set nowritebackup
set scrolloff=10

abbr imr import React from 'react';
abbr ims import styled from 'styled-components';
abbr edf export default function
abbr ec export const

"Keys Maps

nnoremap <SPACE> <Nop>
let mapleader=" "

"select all
nmap <leader>a <esc> gg v G $

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
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' ' 
let g:airline#extensions#tabline#left_alt_sep = '>'
let g:airline#extensions#tabline#formatter = 'jsformatter'

" preservim/nerdcommenter
map <leader>c <Plug>NERDCommenterInvert

"voldikss/vim-floaterm 
nnoremap <leader>r <ESC>:FloatermNew ranger<CR>

command! Ranger FloatermNew ranger
command! FZF FloatermNew fzf

let g:floaterm_keymap_new    = '<leader>n'
let g:floaterm_keymap_prev   = '>'
let g:floaterm_keymap_next   = '<'
let g:floaterm_keymap_toggle = '<leader>t'

" voldikss/fzf-floaterm
noremap <leader>f <ESC>:FZF<CR>

"neoclide/coc.nvim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"Coc extensions
let g:coc_global_extensions = [
      \  'coc-html',
      \  'coc-css',
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

let g:coc_user_config = {
      \  "eslint.executeAutoFix": "true",
      \  'coc.preferences.formatOnSaveFiletypes': [
      \     'html',
      \     'dart',
      \     'css', 
      \     'scss',
      \     'json',
      \     'javascript', 
      \     'typescript', 
      \     'javascriptreact', 
      \     'typescriptreact',
      \     ],
      \}

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

"preservim/nerdtree
nmap <leader>b :NERDTreeToggle<CR>

let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

"Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

"tiagofumo/vim-nerdtree-syntax-highlight
let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 
let g:NERDTreeHighlightFoldersFullName = 1 

" mbbill/undotree
nmap <F7> <ESC>:UndotreeToggle<CR>

" sheerun/vim-polyglot
let g:polyglot_disabled = ['markdown']
let g:polyglot_disabled = ['markdown.plugin']

