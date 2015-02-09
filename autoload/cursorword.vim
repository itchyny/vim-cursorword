" =============================================================================
" Filename: autoload/cursorword.vim
" Author: itchyny
" License: MIT License
" Last Change: 2015/02/07 08:24:44.
" =============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! cursorword#highlight() abort
  if !get(g:, 'cursorword_highlight', 1) | return | endif
  highlight CursorWord0 term=underline cterm=underline gui=underline
  redir => out
    silent! highlight CursorLine
  redir END
  let highlight = 'highlight CursorWord1 term=underline cterm=underline gui=underline'
  execute highlight matchstr(out, 'ctermbg=#\?\w\+') matchstr(out, 'guibg=#\?\w\+')
endfunction

function! cursorword#matchadd() abort
  let enable = get(b:, 'cursorword', get(g:, 'cursorword', 1)) && !has('vim_starting')
  if !enable && !get(w:, 'cursorword_match') | return | endif
  let line = getline('.')
  let linenr = line('.')
  let word = matchstr(line[:(col('.')-1)], '\k*$')[:-2] . matchstr(line[(col('.')-1):], '^\k*')
  if get(w:, 'cursorword_state', []) ==# [ linenr, word, enable ] | return | endif
  let w:cursorword_state = [ linenr, word, enable ]
  silent! call matchdelete(w:cursorword_id0)
  silent! call matchdelete(w:cursorword_id1)
  let w:cursorword_match = 0
  if !enable || !len(word) || len(word) !=# strchars(word) | return | endif
  let pattern = '\<' . escape(word, '~"\.^$[]*') . '\>'
  let w:cursorword_id0 = matchadd('CursorWord0', pattern, -1)
  let w:cursorword_id1 = matchadd('CursorWord' . &l:cursorline, '\%' . line('.') . 'l' . pattern, -1)
  let w:cursorword_match = 1
endfunction

if !has('vim_starting')
  call cursorword#highlight()
endif

let &cpo = s:save_cpo
unlet s:save_cpo
