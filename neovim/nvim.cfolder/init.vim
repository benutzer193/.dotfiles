""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  nvimrc                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""
"  vim-plug  "
""""""""""""""

call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } |
            \ Plug 'junegunn/fzf.vim'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'
Plug 'junegunn/goyo.vim'
Plug 'scrooloose/syntastic'
"Plug 'majutsushi/tagbar'
Plug 'lervag/vimtex'
Plug 'itchyny/lightline.vim'
"Plug 'bling/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'Lokaltog/vim-easymotion'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'Konfekt/FastFold'

" install cmake & python3

"Plug 'Valloric/YouCompleteMe', { 'do': 'python ./install.py' }
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

call plug#end()



"""""""""""""""""""
"  vim variables  "
"""""""""""""""""""

let mapleader=","
let maplocalleader=","

"""""""""""""
"  options  "
"""""""""""""

set autowrite			" Autosave on buffer switch
set autoread
set autochdir
set backspace=indent,eol,start	" allow backspacing over everything in insert mode
set backup			" enable backup
set backupdir=~/.config/nvim/backupdir
set clipboard=unnamedplus
set encoding=utf-8
set foldlevelstart=99
set hidden			" allow buffer switch without closing
set hlsearch			" Search highlights
set ignorecase
set incsearch			" search while typing
set laststatus=2		" tells if last window has statusline
set mouse=a
set number			" Linenumbers
set noshowmode
set omnifunc=syntaxcomplete#Complete
set relativenumber
set scrolloff=5
set sidescrolloff=5
"set display+=lastline
set smartcase
set spell spelllang=de
set textwidth=80
set ttimeoutlen=10
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
"autocmd VimEnter * if argc()==0|CtrlPMRUFiles|endif

""""""""""""""""
"  easymotion  "
""""""""""""""""

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map  <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

"""""""""""""""
"  lightline  "
"""""""""""""""

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ],
      \             [ 'ctrlpmark' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ],
      \              ['percent'],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

"""""""""""""""""
"  vim-airline  "
"""""""""""""""""

"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#fnameod = ':t'

"""""""""""
"  Ctrlp  "
"""""""""""

"let g:ctrlp_show_hidden=1
"let g:ctrlp_cmd='CtrlPMRUFiles'

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

"""""""""
"  fzf  "
"""""""""

map <Leader>o :FZF ~<CR>
map <Leader>b :Buffers<CR>
map <Leader>c :Commands<CR>
map <Leader><F8> :BTags<CR>


command! FZFMru call fzf#run({
\ 'source':  reverse(s:all_files()),
\ 'sink':    'edit',
\ 'options': '-m -x +s',
\ 'down':    '40%' })

function! s:all_files()
  return extend(
  \ filter(copy(v:oldfiles),
  \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
  \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
endfunction

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf1 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
let g:fzf_layout = { 'window': 'enew' }
"autocmd VimEnter * if argc()==0|FZF ~|endif
autocmd! User FzfStatusLine call <SID>fzf_statusline()

""""""""""""
"  vimtex  "
""""""""""""
let g:vimtex_fold_enabled=1
let g:vimtex_quickfix_ignored_warnings = [
            \ 'Underfull',
            \ 'Overfull',
            \ 'specifier changed to',
            \ 'Using preliminary'
            \ ]
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'

""""""""""""""
"  deoplete  "
""""""""""""""
let g:deoplete#enable_at_startup = 1

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = '\\(?:'
            \ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
            \ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
            \ . '|hyperref\s*\[[^]]*'
            \ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
            \ . '|(?:include(?:only)?|input)\s*\{[^}]*'
            \ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
            \ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
            \ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
            \ .')'
