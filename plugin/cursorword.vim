" =============================================================================
" Filename: plugin/cursorword.vim
" Author: itchyny
" License: MIT License
" Last Change: 2017/05/26 00:47:31.
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
  autocmd InsertEnter * call cursorword#matchadd(1)
  autocmd InsertLeave * call cursorword#matchadd(0)
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
