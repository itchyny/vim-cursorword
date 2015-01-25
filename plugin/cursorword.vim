" =============================================================================
" Filename: plugin/cursorword.vim
" Author: itchyny
" License: MIT License
" Last Change: 2015/01/24 13:02:48.
" =============================================================================

if exists('g:loaded_cursorword') || v:version < 703
  finish
endif
let g:loaded_cursorword = 1

let s:save_cpo = &cpo
set cpo&vim

augroup cursorword
  autocmd!
  autocmd VimEnter,ColorScheme * call cursorword#highlight()
  autocmd VimEnter,WinEnter,BufEnter,CursorMoved,CursorMovedI * call cursorword#matchadd()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
