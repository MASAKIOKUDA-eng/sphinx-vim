" Debug script to identify completion issues
" Run with: vim -u debug.vim

set nocompatible
filetype off

let s:plugin_dir = expand('<sfile>:p:h')
execute 'set runtimepath+=' . s:plugin_dir

filetype plugin indent on

" Enable verbose logging
set verbose=1

function! DebugInfo()
  echo "=========================================="
  echo "Sphinx Completion Debug Information"
  echo "=========================================="
  echo ""

  " Check filetype
  echo "1. Filetype check:"
  echo "   Current filetype: " . &filetype
  if &filetype == 'rst'
    echo "   ✓ Filetype is correct (rst)"
  else
    echo "   ✗ Filetype is WRONG (should be 'rst')"
  endif
  echo ""

  " Check omnifunc
  echo "2. Omnifunc check:"
  echo "   Current omnifunc: " . &omnifunc
  if &omnifunc == 'sphinx#completion#complete'
    echo "   ✓ Omnifunc is set correctly"
  else
    echo "   ✗ Omnifunc is WRONG (should be 'sphinx#completion#complete')"
  endif
  echo ""

  " Check if function exists
  echo "3. Function existence check:"
  if exists('*sphinx#completion#complete')
    echo "   ✓ sphinx#completion#complete exists"
  else
    echo "   ✗ sphinx#completion#complete does NOT exist"
  endif

  if exists('*sphinx#completion#directives')
    echo "   ✓ sphinx#completion#directives exists"
  else
    echo "   ✗ sphinx#completion#directives does NOT exist"
  endif
  echo ""

  " Check runtimepath
  echo "4. Runtime path check:"
  let rtps = split(&runtimepath, ',')
  let found = 0
  for rtp in rtps
    if rtp =~ 'sphinx-vim'
      echo "   ✓ Found sphinx-vim in runtimepath: " . rtp
      let found = 1
    endif
  endfor
  if !found
    echo "   ✗ sphinx-vim NOT in runtimepath"
  endif
  echo ""

  " Check current line
  echo "5. Current line check:"
  let line = getline('.')
  echo "   Line content: '" . line . "'"
  if line =~ '^\s*\.\.\s'
    echo "   ✓ Line starts with '.. '"
  else
    echo "   ✗ Line does NOT start with '.. '"
  endif
  echo ""

  " Check cursor position
  echo "6. Cursor position:"
  echo "   Line: " . line('.') . ", Column: " . col('.')
  echo ""

  " Try to call the function directly
  echo "7. Direct function test:"
  try
    let directives = sphinx#completion#directives()
    echo "   ✓ sphinx#completion#directives() works"
    echo "   Number of directives: " . len(directives)
    echo "   First 5: " . join(directives[0:4], ', ')
  catch
    echo "   ✗ ERROR calling sphinx#completion#directives():"
    echo "   " . v:exception
  endtry
  echo ""

  " Test completion function with findstart
  echo "8. Testing completion function (findstart):"
  try
    let start = sphinx#completion#complete(1, '')
    echo "   Completion start position: " . start
    if start >= 0
      echo "   ✓ Findstart returned valid position"
    else
      echo "   ✗ Findstart returned -1 (no completion)"
      echo "   This usually means the line doesn't start with '.. '"
    endif
  catch
    echo "   ✗ ERROR calling completion function:"
    echo "   " . v:exception
  endtry
  echo ""

  " Test completion with empty base
  echo "9. Testing completion (getting matches):"
  try
    let matches = sphinx#completion#complete(0, '')
    echo "   Number of matches: " . len(matches)
    if len(matches) > 0
      echo "   ✓ Got completion matches"
      echo "   First match: " . matches[0].word
    else
      echo "   ⚠ No matches returned"
    endif
  catch
    echo "   ✗ ERROR getting matches:"
    echo "   " . v:exception
  endtry
  echo ""

  " Test with 'cod' prefix
  echo "10. Testing completion with 'cod' prefix:"
  try
    let matches = sphinx#completion#complete(0, 'cod')
    echo "   Number of matches: " . len(matches)
    if len(matches) > 0
      echo "   ✓ Got matches for 'cod'"
      for match in matches
        echo "   - " . match.word
      endfor
    else
      echo "   ⚠ No matches for 'cod'"
    endif
  catch
    echo "   ✗ ERROR:"
    echo "   " . v:exception
  endtry
  echo ""

  echo "=========================================="
  echo "Debug Complete"
  echo "=========================================="
  echo ""
  echo "Press any key to try manual completion..."
  echo "Then press Ctrl-X Ctrl-O in insert mode"
  echo ""
endfunction

" Create test content
function! SetupDebugFile()
  call setline(1, 'Debug Test File')
  call setline(2, '===============')
  call setline(3, '')
  call setline(4, 'Try completion on these lines:')
  call setline(5, '')
  call setline(6, '.. cod')
  call setline(7, '')
  call setline(8, '.. ')

  setfiletype rst

  " Move to test line
  call cursor(6, 6)

  " Show useful info in statusline
  set showmode
  set ruler
  set laststatus=2
  set statusline=%F\ [%{&filetype}]\ [omnifunc=%{&omnifunc}]\ [L%l,C%c]
endfunction

" Auto-run on start
autocmd VimEnter * call SetupDebugFile() | call DebugInfo() | call inputsave() | call input('') | call inputrestore()

" Add command to re-run debug
command! Debug call DebugInfo()

" Add mapping for easy debug
nnoremap <F5> :call DebugInfo()<CR>

echo "Debug mode loaded. Press F5 to run debug info again."
