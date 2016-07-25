""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  nvimrc                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""
"  vim-plug  "
""""""""""""""

call plug#begin('~/.config/nvim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'
Plug 'scrooloose/syntastic'
Plug 'majutsushi/tagbar'
Plug 'LaTeX-Box-Team/LaTeX-Box', { 'for': ['tex', 'bib'] }
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Lokaltog/vim-easymotion'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'

" install cmake & python2

Plug 'Valloric/YouCompleteMe', { 'do': 'python ./install.py' }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

call plug#end()



"""""""""""""""""""
"  vim variables  "
"""""""""""""""""""

let mapleader=","

"""""""""""""
"  options  "
"""""""""""""

set autowrite			" Autosave on buffer switch
set autoread
set backspace=indent,eol,start	" allow backspacing over everything in insert mode
set backup			" enable backup
set backupdir=~/.config/nvim/backupdir
set clipboard=unnamedplus
set foldlevelstart=99
set hidden			" allow buffer switch without closing
set hlsearch			" Search highlights
set ignorecase
set incsearch			" search while typing
set laststatus=2		" tells if last window has statusline
set mouse=a
set number			" Linenumbers
set relativenumber
set scrolloff=5
set sidescrolloff=5
"set display+=lastline
set smartcase
set spell spelllang=de
set textwidth=80
set ttimeoutlen=50
set undodir=~/.config/nvim/tmp/undo
set undofile
set undolevels=1000
set undoreload=10000
set visualbell			" Flash instead of beep
set expandtab
set tabstop=8
set softtabstop=0
set shiftwidth=4
set smarttab

"""""""""""""""""""""
"  vim keybindings  "
"""""""""""""""""""""

map j gj
map k gk
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap g* g*zzzv
nnoremap g# g#zzzv
nnoremap g; g;zz
nnoremap g, g,zz
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nmap <silent> <leader>/ :nohlsearch<CR>
cmap ## w !sudo tee > /dev/null %
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.config/nvim/init.vim<CR>
nnoremap <space> za
nmap <silent> <leader><CR> i<CR><ESC>


""""""""""""""""""
"  autocommands  "
""""""""""""""""""

autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
autocmd VimEnter * if argc()==0|CtrlPMRUFiles|endif

"""""""""""""""""
"  vim-airline  "
"""""""""""""""""

set noshowmode
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnameod = ':t'

"""""""""""
"  Ctrlp  "
"""""""""""

let g:ctrlp_show_hidden=1
let g:ctrlp_cmd='CtrlPMRUFiles'

"""""""""""""""
"  ultisnips  "
"""""""""""""""

let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-y>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsUsePythonVersion=3

""""""""""""
"  base16  "
""""""""""""

let base16colorspace=256
colorscheme base16-default-dark

"""""""""""""""
"  Latex-Box  "
"""""""""""""""

let g:LatexBox_ignore_warnings=['Underfull', 'Overfull', 'specifier changed to', 'Using preliminary']
let g:tex_flavor='latex'
let g:LatexBox_cite_pattern='\C\\\(auto\|foot\|footfull\|full\|paren\|text\|smart\|super\)\?cite\(p\|t\|author\|year\|yearpart\|title\|date\|url\)\=\*\=\(\[[^\]]*\]\)*\_\s*{'
let g:LatexBox_Folding=1

nnoremap <F6> :call CompileTex()<CR>
autocmd FileType tex setlocal omnifunc=LatexBox_Complete
autocmd FileType tex command -buffer W write | call CompileTex()<CR>

function! CompileTex()
	silent write!
	call setqflist([])
	echon "compiling with arara ..."
	exec "lcd %:h"
	setlocal makeprg=arara\ --verbose\ --log\ %
	silent make!

	if !empty(getqflist())
		copen
		wincmd J
		redraw!
	else
		cclose
		redraw!
		echon "successfully compiled"
	endif
endfunction

""""""""""""
"  tagbar  "
""""""""""""

nmap <F8> :TagbarToggle<CR>

autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

"""""""""""""""""""
"  YouCompleteMe  "
"""""""""""""""""""

let g:ycm_min_num_of_chars_for_completion=2
