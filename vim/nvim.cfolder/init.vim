"""""""""""""""""
"  nvim config  "
"""""""""""""""""

" {{{ vim-plug
call plug#begin('~/.config/nvim/plugged')
" {{{ plugins
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } |
  \ Plug 'junegunn/fzf.vim'

if has('nvim')
  function! DoRemote(arg)
    UpdateRemotePlugins
  endfunction
  Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
endif
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdcommenter'
Plug 'Lokaltog/vim-easymotion'
"Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'neomake/neomake'
Plug 'Konfekt/FastFold'
Plug 'lervag/vimtex'

Plug 'chriskempson/base16-vim'
Plug 'junegunn/seoul256.vim', { 'on': 'Goyo' }
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Goyo' }
Plug 'itchyny/lightline.vim'

" {{{ unused
"Plug 'bling/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

" install cmake & python3
"Plug 'Valloric/YouCompleteMe', { 'do': 'python ./install.py' }
" }}}
" }}}
call plug#end()
" }}}

" {{{ settings

" {{{ plugins

" {{{ fzf

  if has('nvim')
    let $FZF_DEFAULT_OPTS .= ' --inline-info'
    " let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
  endif

  command! FZFMru call fzf#run({
        \ 'source':  reverse(s:all_files()),
        \ 'sink':  'edit',
        \ 'options': '-m -x +s',
        \ 'down':  '40%' })

  function! s:all_files()
    return extend(
    \ filter(copy(v:oldfiles),
    \    "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
    \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
  endfunction

  "let g:fzf_layout = { 'window': 'enew' }

  "function! s:fzf_statusline()
    "" Override statusline as you like
    "highlight fzf1 ctermfg=161 ctermbg=251
    "highlight fzf1 ctermfg=23 ctermbg=251
    "highlight fzf3 ctermfg=237 ctermbg=251
    "setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
  "endfunction
  "autocmd! User FzfStatusLine call <SID>fzf_statusline()
"}}}

" {{{ vim-signify
  let g:signify = [ 'git' ]
  let g:signify_sign_change = '~'
" }}}

" {{{ colorscheme: base16-dark
  let base16colorspace=256
  colorscheme base16-default-dark
" }}}

" {{{ goyo

  function! s:goyo_enter()
    set noshowcmd
    set nocursorline
    set scrolloff=999
    Limelight
    colorscheme seoul256
  endfunction

  function! s:goyo_leave()
    set showcmd
    set cursorline
    set scrolloff=5
    Limelight!
    colorscheme base16-default-dark
  endfunction

  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()

" }}}

" {{{ lightline

  let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \       [ 'fugitive', 'filename' ] ],
        \   'right': [ [ 'lineinfo' ],
        \        [ 'percent' ],
        \        [ 'fileformat', 'fileencoding', 'filetype', 'neomake' ] ],
        \ },
        \ 'component_function': {
        \   'fugitive': 'LightLineFugitive',
        \   'filename': 'LightLineFilename',
        \   'fileformat': 'LightLineFileformat',
        \   'filetype': 'LightLineFiletype',
        \   'fileencoding': 'LightLineFileencoding',
        \   'mode': 'LightLineMode',
        \ },
        \ 'component_expand': {
        \   'neomake': 'LightlineNeomake',
        \ },
        \ 'component_type': {
        \   'neomake': 'error',
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
    return &ft == 'fzf' ? '' :
      \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
      \ ('' != fname ? fname : '[No Name]') .
      \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
  endfunction

  function! LightLineFugitive()
    try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD'
          \ && &ft !~? 'vimfiler'
          \ && exists('*fugitive#head')
      let mark = ' '
      let branch = fugitive#head()
      return branch !=# '' ? mark.branch : ''
    endif
    catch
    endtry
    return ''
  endfunction

  function! LightLineFileformat()
    if winwidth(0) > 70
          \ && &ft != 'fzf'
          \ && ( &ff != 'unix' && has('unix') )
          \ && ( &ff != 'dos' && has('win32') )
          \ && ( &ff != 'mac' && has('mac') )
      return &fileformat
    endif
    return ''
  endfunction

  function! LightLineFiletype()
    return winwidth(0) > 70
          \ && &ft != 'fzf'
          \ ? (&filetype !=# '' ? &filetype : 'no ft') : ''
  endfunction

  function! LightLineFileencoding()
    return winwidth(0) > 70
          \ && &ft != 'fzf'
          \ ? (&fenc !=# '' ? &fenc : &enc) : ''
  endfunction

  function! LightLineMode()
    return &ft == 'fzf' ? 'FZF' :
          \ winwidth(0) > 60 ? lightline#mode() : ''
  endfunction

  function! LightlineNeomake()
    return '%{neomake#statusline#LoclistStatus()}'
  endfunction
" }}}

" {{{ vim-airline
  "let g:airline#extensions#tabline#enabled = 1
  "let g:airline#extensions#tabline#fnameod = ':t'
" }}}

" {{{ deoplete
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
    \ . ')'
" }}}

" {{{ UltiSnips
  let g:UltiSnipsEditSplit="vertical"
  let g:UltiSnipsUsePythonVersion=3
" }}}

" {{{ vimtex
  let g:vimtex_fold_enabled=1
  let g:vimtex_format_enabled=1
  let g:vimtex_quickfix_ignored_warnings = [
    \ 'Underfull',
    \ 'Overfull',
    \ 'specifier changed to',
    \ 'Using preliminary'
    \ ]
  let g:tex_flavor='latex'
  let g:vimtex_view_method='zathura'
  let g:vimtex_view_use_temp_files=1
  let g:vimtex_latexmk_progname='nvr'
  " temporary fix for missing --remote support in neovim
  " install neovm-remote from AUR
" }}}

" }}}

" {{{ general settings
  if has('nvim')
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    "let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  else
    if empty($TMUX)
      let &t_SI = "\<Esc>]50;CursorShape=1\x7"
      let &t_EI = "\<Esc>]50;CursorShape=0\x7"
      let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    else
      let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
      let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
      let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    endif
    set encoding=utf-8
  endif

  set autowrite autoread autochdir
  set backspace=indent,eol,start
  set hidden
  set lazyredraw
  "set termguicolors
  set ttimeoutlen=10
  set foldmethod=manual foldlevelstart=2
  set clipboard^=unnamedplus
  set mouse=a
  set hlsearch
  set ignorecase smartcase incsearch

  set number
  set relativenumber
  set laststatus=2
  set noshowmode
  set showcmd
  set visualbell
  set cursorline

  set omnifunc=syntaxcomplete#Complete
  set spell spelllang=de,en
  "set display+=lastline

  set backup backupdir=~/.config/nvim/backupdir
  set undofile undodir=~/.config/nvim/undodir
  set undolevels=1000
  set undoreload=10000

  set textwidth=80
  set scrolloff=5 sidescrolloff=5
  set expandtab
  set tabstop=2 softtabstop=2 shiftwidth=2
  set smarttab

  " }}}

  " {{{  vim keybindings
  let mapleader=","
  let maplocalleader=","

  " {{{ fzf
  nnoremap <silent> <Leader><Leader>o :FZF! ~<CR>
  nnoremap <silent> <Leader><Leader>b :Buffers<CR>
  nnoremap <silent> <Leader><Leader>c :Commands!<CR>
  nnoremap <silent> <Leader><Leader>h :History!<CR>
  nnoremap <silent> <Leader><Leader><F8> :BTags!<CR>
" }}}

" {{{ goyo
  nnoremap <silent> <leader>g :Goyo<CR>
" }}}

" {{{ vim-easymotion
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
" }}}

" {{{ UltiSnips
  let g:UltiSnipsExpandTrigger="<c-b>"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-y>"
" }}}

" {{{ general
  map j gj
  map k gk
  nnoremap <space> za
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
  nnoremap <tab>   <c-w>w
  nnoremap <S-tab> <c-w>W
  nnoremap ]b :bnext<cr>
  nnoremap [b :bprev<cr>
  nnoremap ]t :tabn<cr>
  nnoremap [t :tabp<cr>

  " qwertz
  map ü /
  map ö [
  map ä ]
  map Ö {
  map Ä }
  map ß <C-]>

  xnoremap <  <gv
  xnoremap >  >gv

  cmap ## w !sudo tee > /dev/null %
  noremap <Leader>#  :w !sudo tee > /dev/null %
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

  nnoremap <silent> <Leader>ev :vsp ~/.config/nvim/init.vim<CR>
  nnoremap <silent> <Leader>ez :vsp ~/.zshrc<CR>
  nnoremap <silent> <leader>sv :source ~/.config/nvim/init.vim<CR>

  nmap <silent> <ESC><ESC> :nohlsearch<CR>
  nmap <silent> <leader><CR> i<CR><ESC>
  map <leader>rt :retab<CR> :w<CR>
" }}}

" }}}

" {{{ autocommands
  augroup reload_vimrc
    au!
    au BufWritePost init.vim,.vimrc nested if expand('%') !~ 'fugitive' | source % | endif
  augroup END

  augroup AutoNeomake
    au!
    au BufWritePost * Neomake
  augroup END

  au BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif
  au BufRead * normal zz

  au BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
  au VimEnter * if argc()==0 | History! | endif
" }}}
" }}}

" vim: foldlevel=1 foldmethod=marker:
