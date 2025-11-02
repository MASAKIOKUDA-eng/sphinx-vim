" Interactive diagnostic tool
" Run with: vim -u diagnose.vim

set nocompatible
filetype off

let s:plugin_dir = expand('<sfile>:p:h')
execute 'set runtimepath+=' . s:plugin_dir

filetype plugin indent on

" Important: show completion messages
set shortmess-=c

" Better completion experience
set completeopt=menuone,noinsert,noselect,preview
set showmode
set ruler
set laststatus=2

function! ShowDiagnostic()
  echo "============================================"
  echo "Press SPACE to continue..."
  call getchar()

  echohl WarningMsg
  echo "\n=== CURRENT STATUS ==="
  echohl None

  echo "Filetype: " . &filetype
  if &filetype == 'rst'
    echohl Green
    echo "✓ Filetype is correct"
    echohl None
  else
    echohl ErrorMsg
    echo "✗ Filetype is WRONG (should be rst)"
    echohl None
  endif

  echo "\nOmnifunc: " . &omnifunc
  if &omnifunc == 'sphinx#completion#complete'
    echohl Green
    echo "✓ Omnifunc is set"
    echohl None
  else
    echohl ErrorMsg
    echo "✗ Omnifunc not set properly"
    echohl None
  endif

  echo "\nFunction exists: " . exists('*sphinx#completion#complete')

  echo "\nCurrent line: '" . getline('.') . "'"
  echo "Cursor: L" . line('.') . " C" . col('.')

  echo "\n============================================"
  echo "Press SPACE to continue..."
  call getchar()
endfunction

function! TryCompletion()
  echohl Title
  echo "\n=== ATTEMPTING COMPLETION ==="
  echohl None

  let line = getline('.')
  echo "Line: '" . line . "'"
  echo "Column: " . col('.')

  " Test findstart
  let start = sphinx#completion#complete(1, '')
  echo "Findstart returned: " . start

  if start < 0
    echohl ErrorMsg
    echo "✗ Findstart failed (returned -1)"
    echo "This means the line doesn't match the pattern"
    echo "Line should start with '.. '"
    echohl None
    return
  endif

  " Get the base
  let base = strpart(line, start, col('.') - start - 1)
  echo "Base for completion: '" . base . "'"

  " Get matches
  let matches = sphinx#completion#complete(0, base)
  echo "Number of matches: " . len(matches)

  if len(matches) > 0
    echohl Green
    echo "✓ Got " . len(matches) . " matches:"
    echohl None
    for m in matches[0:4]
      echo "  - " . m.word
    endfor
    if len(matches) > 5
      echo "  ... and " . (len(matches) - 5) . " more"
    endif
  else
    echohl WarningMsg
    echo "⚠ No matches found for '" . base . "'"
    echohl None
  endif

  echo "\n============================================"
endfunction

" Setup file
enew
setfiletype rst

call append(0, [
      \ 'Diagnostic Mode - Try Completion Here',
      \ '===================================',
      \ '',
      \ 'Instructions:',
      \ '1. Press F3 to see diagnostic info',
      \ '2. Move cursor to a line below starting with ".."',
      \ '3. Press "A" to enter INSERT mode at end of line',
      \ '4. Press Ctrl-X Ctrl-O to complete',
      \ '5. If nothing happens, press F4 to test manually',
      \ '',
      \ 'Test lines (move cursor here and try):',
      \ '',
      \ '.. cod',
      \ '',
      \ '.. not',
      \ '',
      \ '.. ',
      \ ])

" Remove empty first line
1delete

" Move to first test line
call cursor(11, 6)

" Key mappings
nnoremap <F3> :call ShowDiagnostic()<CR>
nnoremap <F4> :call TryCompletion()<CR>
inoremap <F3> <C-O>:call ShowDiagnostic()<CR>

" Enhanced statusline
set statusline=%F\ [FT:%{&filetype}]\ [OF:%{&omnifunc}]\ [L%l\ C%c]

" Show initial message
autocmd VimEnter * call timer_start(100, {-> execute('call ShowInitialHelp()', '')})

function! ShowInitialHelp()
  echohl Title
  echo "=========================================="
  echo "SPHINX COMPLETION DIAGNOSTIC MODE"
  echo "=========================================="
  echohl None
  echo ""
  echo "Your current settings:"
  echo "  Filetype: " . &filetype
  echo "  Omnifunc: " . &omnifunc
  echo ""
  echohl WarningMsg
  echo "IMPORTANT:"
  echohl None
  echo "1. Move cursor to line 11 (.. cod)"
  echo "2. Press 'A' to go to end and enter INSERT"
  echo "3. Watch bottom of screen for '-- INSERT --'"
  echo "4. Press Ctrl-X Ctrl-O"
  echo ""
  echo "Troubleshooting keys:"
  echo "  F3 = Show diagnostic info"
  echo "  F4 = Manual completion test (NORMAL mode)"
  echo ""
  echo "If you see a menu, IT WORKS!"
  echo "If not, press F3 and F4 for debug info"
  echo ""
endfunction
