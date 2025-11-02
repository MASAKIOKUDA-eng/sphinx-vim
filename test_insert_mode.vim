" Test INSERT mode completion
" This simulates real user interaction
set nocompatible
filetype off

" Setup plugin path
let s:plugin_dir = expand('<sfile>:p:h')
execute 'set runtimepath+=' . s:plugin_dir

" Enable filetype detection and plugins
filetype plugin indent on

" Better visibility
set showmode
set showcmd
syntax on

function! TestInsertCompletion()
  echo "=========================================="
  echo "INSERT Mode Completion Test"
  echo "=========================================="
  echo ""

  " Open test file
  edit test.rst

  " Force filetype detection
  doautocmd BufRead

  " Check settings
  echo "1. Checking environment..."
  echo "   Filetype: " . &filetype
  echo "   Omnifunc: " . &omnifunc
  echo ""

  if &filetype != 'rst'
    echo "ERROR: Filetype is not 'rst'"
    echo "Forcing filetype..."
    setfiletype rst
    echo "   New filetype: " . &filetype
    echo ""
  endif

  if &omnifunc != 'sphinx#completion#complete'
    echo "ERROR: Omnifunc is not set correctly"
    echo "Current: '" . &omnifunc . "'"
    return
  endif

  " Move to completion line
  call cursor(6, 1)
  normal! $

  echo "2. Testing INSERT mode completion..."
  echo "   Current line: '" . getline('.') . "'"
  echo "   Cursor at: Line " . line('.') . ", Col " . col('.')
  echo ""

  " Enter INSERT mode and trigger completion
  echo "3. Simulating: A (enter INSERT mode at end)"
  echo "   Then: Ctrl-X Ctrl-O (trigger omni-completion)"
  echo ""

  " Programmatically test completion
  startinsert!

  " Wait a moment
  sleep 100m

  " Trigger completion
  call feedkeys("\<C-X>\<C-O>", 'n')

  " Wait for completion
  sleep 500m

  " Check if completion menu appeared
  echo "4. Checking completion result..."

  " Get completion info
  let matches = sphinx#completion#complete(0, '')
  echo "   Available matches: " . len(matches)

  if len(matches) > 0
    echo ""
    echo "   ✓ SUCCESS! Completion is working!"
    echo ""
    echo "   First 10 matches:"
    for i in range(min([10, len(matches)]))
      echo "     " . (i+1) . ". " . matches[i].word
    endfor
  else
    echo ""
    echo "   ✗ FAILED: No matches found"
  endif

  echo ""
  echo "=========================================="
  echo ""
  echo "Manual test instructions:"
  echo "1. Press Esc to exit INSERT mode"
  echo "2. Press 'A' to enter INSERT mode at end of line 6"
  echo "3. Press Ctrl-X, then Ctrl-O"
  echo "4. You should see a completion menu!"
  echo ""
  echo "Navigate with:"
  echo "  - Ctrl-N (next)"
  echo "  - Ctrl-P (previous)"
  echo "  - Enter (select)"
  echo "  - Esc (cancel)"
  echo ""
  echo "Type ':q!' and Enter to quit without saving"
  echo "=========================================="

  " Exit insert mode for user to see message
  stopinsert
endfunction

" Run test on startup
autocmd VimEnter * call TestInsertCompletion()

" Set useful statusline
set laststatus=2
set statusline=%F\ [FT:%{&ft}]\ [OF:%{&omnifunc}]\ [%{mode()}]\ [L%l\ C%c]
