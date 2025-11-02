" sphinx.vim - Sphinx documentation utilities for Vim
" Maintainer: sphinx-vim
" Version: 0.1.0

" Guard against multiple loads
if exists('g:loaded_sphinx_autoload')
  finish
endif
let g:loaded_sphinx_autoload = 1

" Save cpoptions and set to vim defaults
let s:save_cpo = &cpoptions
set cpoptions&vim

" ============================================================================
" Completion Functions
" ============================================================================

" sphinx#completion#directives() {{{
" Returns a list of common Sphinx directives for completion
function! sphinx#completion#directives() abort
  return [
        \ 'note',
        \ 'warning',
        \ 'tip',
        \ 'important',
        \ 'caution',
        \ 'danger',
        \ 'attention',
        \ 'error',
        \ 'hint',
        \ 'seealso',
        \ 'admonition',
        \ 'topic',
        \ 'sidebar',
        \ 'code-block',
        \ 'literalinclude',
        \ 'highlight',
        \ 'parsed-literal',
        \ 'image',
        \ 'figure',
        \ 'table',
        \ 'csv-table',
        \ 'list-table',
        \ 'contents',
        \ 'toctree',
        \ 'include',
        \ 'raw',
        \ 'class',
        \ 'container',
        \ 'rubric',
        \ 'epigraph',
        \ 'compound',
        \ 'highlights',
        \ 'pull-quote',
        \ 'index',
        \ 'only',
        \ 'versionadded',
        \ 'versionchanged',
        \ 'deprecated',
        \ 'glossary',
        \ 'productionlist',
        \ 'math',
        \ 'doctest',
        \ 'testcode',
        \ 'testoutput',
        \ 'testsetup',
        \ 'testcleanup',
        \ 'centered',
        \ 'hlist',
        \ 'ifconfig',
        \ 'sectionauthor',
        \ 'codeauthor',
        \ 'default-domain',
        \ 'default-role',
        \ 'title',
        \ 'meta',
        \ ]
endfunction
" }}}

" sphinx#completion#complete(findstart, base) {{{
" Omnifunc completion function for Sphinx directives
"
" This function provides intelligent completion for Sphinx directives
" in reStructuredText files.
"
" Args:
"   findstart: 1 to find start of completion, 0 to return matches
"   base: The text to match when findstart=0
"
" Returns:
"   When findstart=1: column number of completion start (or -1)
"   When findstart=0: list of completion matches
function! sphinx#completion#complete(findstart, base) abort
  if a:findstart
    " Find the start of the directive name
    let l:line = getline('.')
    let l:start = col('.') - 1

    " Check if we're on a directive line (starts with ..)
    if l:line !~# '^\s*\.\.\s'
      return -1
    endif

    " Find the start of the current word after '..'
    while l:start > 0
      let l:char = l:line[l:start - 1]
      " Stop at whitespace after '..'
      if l:char =~# '\s'
        " Check if we're after the '..'
        let l:prefix = strpart(l:line, 0, l:start)
        if l:prefix =~# '^\s*\.\.\s\+$'
          break
        endif
        return -1
      endif
      " Allow alphanumeric characters and hyphens in directive names
      if l:char !~# '[a-zA-Z0-9-]'
        break
      endif
      let l:start -= 1
    endwhile

    return l:start
  else
    " Return matching directives
    let l:matches = []
    let l:directives = sphinx#completion#directives()

    for l:directive in l:directives
      if l:directive =~# '^' . a:base
        call add(l:matches, {
              \ 'word': l:directive . '::',
              \ 'kind': 'd',
              \ 'menu': '[Sphinx]',
              \ 'info': 'Sphinx directive: ' . l:directive,
              \ })
      endif
    endfor

    return l:matches
  endif
endfunction
" }}}

" ============================================================================
" Restore cpoptions
" ============================================================================
let &cpoptions = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker:
