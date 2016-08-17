" {{{ vimtex

  let g:vimtex_imaps_leader="<F16>"
  nmap öö <Plug>(vimtex-[[)
  omap öö <Plug>(vimtex-[[)
  xmap öö <Plug>(vimtex-[[)

  nmap öä <Plug>(vimtex-[])
  omap öä <Plug>(vimtex-[])
  xmap öä <Plug>(vimtex-[])

  nmap ää <Plug>(vimtex-]])
  omap ää <Plug>(vimtex-]])
  xmap ää <Plug>(vimtex-]])
  imap ää <Plug>(vimtex-delim-close)

  nmap äö <Plug>(vimtex-][)
  omap äö <Plug>(vimtex-][)
  xmap äö <Plug>(vimtex-][)

  augroup vimtex
    au!
    au User VimtexEventQuit     VimtexClean
    au User VimtexEventInitPost VimtexCompile
  augroup END


" }}}

" {{{ keymaps
  imap üü \
" }}}
