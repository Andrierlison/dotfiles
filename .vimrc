"sheerun/vim-polyglot
let g:polyglot_disabled = ['markdown', 'markdown.plugin', 'autoindent']

call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'

call plug#end()

colorscheme gruvbox
filetype plugin on
syntax enable

set signcolumn=number
set number
set encoding=UTF-8 
set updatetime=50
set scrolloff=10
set background=dark
set path+=**
set wildignore+=**/node_modules/**
set winwidth=80
set hlsearch
set incsearch
set cursorline
set expandtab
set smartcase
set smartindent
set confirm
set title
set hidden
set wildmenu
set nocompatible
set noswapfile
set nobackup
set nowritebackup
set t_Co=256
set shortmess-=S
set cmdheight=2

"Status-line
set laststatus=2
set statusline=
set statusline+=%#IncSearch#
set statusline+=\ %y
set statusline+=\ %r
set statusline+=%#CursorLineNr#
set statusline+=\ %t
set statusline+=%= "Right side settings
set statusline+=%#Search#
set statusline+=\ Line\ %l/%L
set statusline+=\ [Column\ %c]

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

"Move between windowns with leader key 
noremap <silent> <leader>l <C-w>l 
noremap <silent> <leader>k <C-w>k 
noremap <silent> <leader>j <C-w>j 
noremap <silent> <leader>h <C-w>h 

"Close buffer 
noremap <leader>q <ESC>:bd<CR>

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

augroup AutoDeleteNetrwHiddenBuffers
  au!
  au FileType netrw setlocal bufhidden=wipe
augroup end

"ToggleNetrw
nmap <SPACE>b <ESC>:call ToggleNetrw()<CR>

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

let g:coc_user_config = {
      \"coc.preferences.formatOnSaveFiletypes": [
        \"dart",
        \"python",
        \"css",
        \"scss",
        \"json",
        \"html",
        \"yaml",
        \"javascript",
        \"typescript",
        \"javascriptreact",
        \"typescriptreact"
        \],
        \"coc.global.extensions": [
          \"coc-css",
          \"coc-emmet",
          \"coc-flutter",
          \"coc-highlight",
          \"coc-html",
          \"coc-json",
          \"coc-prettier",
          \"coc-pyright",
          \"coc-snippets",
          \"coc-svg",
          \"coc-tsserver",
          \"coc-yaml"
          \],
          \"flutter.lsp.initialization.closingLabels": "true",
          \"python.linting.pylintEnabled": "true",
          \}
