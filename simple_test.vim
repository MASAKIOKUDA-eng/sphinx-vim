" Simple test without user interaction
set nocompatible
filetype off

let s:plugin_dir = expand('<sfile>:p:h')
execute 'set runtimepath+=' . s:plugin_dir

filetype plugin indent on

" Load the autoload file explicitly
execute 'source ' . s:plugin_dir . '/autoload/sphinx/completion.vim'

" Create a test buffer
enew
setfiletype rst

" Write test lines
call setline(1, '.. cod')
call setline(2, '.. ')
call setline(3, 'not a directive')

" Move to first test line
call cursor(1, 6)

echo "=== DIAGNOSTIC OUTPUT ==="
echo ""
echo "1. Filetype: " . &filetype
echo "2. Omnifunc: " . &omnifunc
echo "3. Function exists: " . exists('*sphinx#completion#complete')
echo ""

echo "4. Testing line '.. cod' (cursor at column 6):"
call cursor(1, 6)
let start1 = sphinx#completion#complete(1, '')
echo "   - findstart result: " . start1
if start1 >= 0
  let base1 = strpart(getline('.'), start1, col('.') - start1 - 1)
  echo "   - base string: '" . base1 . "'"
  let matches1 = sphinx#completion#complete(0, 'cod')
  echo "   - matches: " . len(matches1)
  if len(matches1) > 0
    echo "   - first match: " . matches1[0].word
  endif
else
  echo "   - ERROR: findstart returned -1 (no completion)"
endif
echo ""

echo "5. Testing line '.. ' (cursor at column 3):"
call cursor(2, 3)
let start2 = sphinx#completion#complete(1, '')
echo "   - findstart result: " . start2
if start2 >= 0
  let matches2 = sphinx#completion#complete(0, '')
  echo "   - matches: " . len(matches2)
else
  echo "   - ERROR: findstart returned -1"
endif
echo ""

echo "6. Testing line 'not a directive' (should fail):"
call cursor(3, 5)
let start3 = sphinx#completion#complete(1, '')
echo "   - findstart result: " . start3
echo "   - Expected: -1 (not a directive line)"
echo ""

echo "7. Checking completion logic details:"
echo "   Line 1: '" . getline(1) . "'"
echo "   Does it match '^\\s*\\.\\.\\s': " . (getline(1) =~ '^\s*\.\.\s')
echo ""

echo "=== END DIAGNOSTIC ==="
echo ""

" Don't quit automatically - let user review
echo "Review the output above. Press :q to quit."
