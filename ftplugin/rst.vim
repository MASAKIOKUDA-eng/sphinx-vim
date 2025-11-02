" rst.vim - reStructuredText filetype plugin with Sphinx support
" Maintainer: sphinx-vim
" Version: 0.1.0

" Only load this plugin once per buffer
if exists('b:did_ftplugin_sphinx')
  finish
endif
let b:did_ftplugin_sphinx = 1

" Save cpoptions and set to vim defaults
let s:save_cpo = &cpoptions
set cpoptions&vim

" ============================================================================
" Completion Settings
" ============================================================================

" Set omnifunc to use Sphinx completion
setlocal omnifunc=sphinx#completion#complete

" Set completion options for better UX
" - menuone: show menu even if there's only one match
" - noinsert: don't insert text until user selects
" - noselect: don't auto-select first item
if has('patch-7.4.775')
  setlocal completeopt+=menuone,noinsert,noselect
endif

" ============================================================================
" Buffer-local Settings
" ============================================================================

" Set comment string for reStructuredText
setlocal commentstring=..\ %s

" Set format options
" - t: Auto-wrap text using textwidth
" - c: Auto-wrap comments using textwidth
" - r: Auto-insert comment leader after <Enter> in Insert mode
" - o: Auto-insert comment leader after 'o' or 'O' in Normal mode
" - q: Allow formatting of comments with 'gq'
" - l: Long lines are not broken in insert mode
setlocal formatoptions=tcroql

" Set text width for automatic wrapping
if &textwidth == 0
  setlocal textwidth=79
endif

" ============================================================================
" Buffer-local Mappings (Optional)
" ============================================================================

" Example: Map <C-X><C-O> for manual completion (already works by default)
" This is just a reminder that users can trigger completion with Ctrl-X Ctrl-O

" ============================================================================
" Undo Settings
" ============================================================================

" Allow undoing of ftplugin settings
let b:undo_ftplugin = get(b:, 'undo_ftplugin', 'execute')
let b:undo_ftplugin .= '| setlocal omnifunc< commentstring< formatoptions< textwidth<'
let b:undo_ftplugin .= '| setlocal completeopt<'

" ============================================================================
" Restore cpoptions
" ============================================================================
let &cpoptions = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker:
