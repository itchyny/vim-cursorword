" =============================================================================
" Filename: plugin/cursorword.vim
" Author: itchyny
" License: MIT License
" Last Change: 2020/04/26 00:33:47.
" =============================================================================

if exists('g:loaded_cursorword') || v:version < 703
  finish
endif
let g:loaded_cursorword = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:cursorword_highlights() abort
  if !get(g:, 'cursorword_highlight', 1) | return | endif
  highlight CursorWord0 term=underline cterm=underline gui=underline
  redir => out
    silent! highlight CursorLine
  redir END
  let highlight = 'highlight CursorWord1 term=underline cterm=underline gui=underline'
  execute highlight matchstr(out, 'ctermbg=#\?\w\+') matchstr(out, 'guibg=#\?\w\+')
endfunction

call s:cursorword_highlights()

augroup cursorword
  autocmd!
  autocmd ColorScheme * call s:cursorword_highlights()
  autocmd CursorMoved,CursorMovedI * call cursorword#cursormoved()
  autocmd InsertEnter * call cursorword#matchadd(1)
  autocmd InsertLeave * call cursorword#matchadd(0)
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
