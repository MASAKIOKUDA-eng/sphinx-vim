" Test script for Sphinx completion functionality
" Run with: vim -u test_completion.vim

" Set up runtime path to include this plugin
set nocompatible
filetype off

" Add current directory to runtimepath
let s:plugin_dir = expand('<sfile>:p:h')
execute 'set runtimepath+=' . s:plugin_dir

" Enable filetype plugins
filetype plugin indent on

" Function to run tests
function! RunTests()
  echo "========================================="
  echo "Sphinx Completion Test Suite"
  echo "========================================="
  echo ""

  " Test 1: Check if autoload function exists
  echo "Test 1: Checking if sphinx#completion#directives() exists..."
  try
    let directives = sphinx#completion#directives()
    echo "  ✓ Function exists and returned " . len(directives) . " directives"
    echo "  Sample directives: " . join(directives[0:4], ', ')
  catch
    echo "  ✗ FAILED: " . v:exception
    return
  endtry
  echo ""

  " Test 2: Check if completion function exists
  echo "Test 2: Checking if sphinx#completion#complete() exists..."
  try
    " This should return -1 for non-directive lines
    let result = sphinx#completion#complete(1, '')
    echo "  ✓ Function exists"
  catch
    echo "  ✗ FAILED: " . v:exception
    return
  endtry
  echo ""

  " Test 3: Open an RST file and check omnifunc
  echo "Test 3: Opening test.rst and checking omnifunc..."
  try
    edit test.rst
    if &omnifunc == 'sphinx#completion#complete'
      echo "  ✓ omnifunc is correctly set to sphinx#completion#complete"
    else
      echo "  ✗ FAILED: omnifunc is '" . &omnifunc . "' (expected 'sphinx#completion#complete')"
      return
    endif
  catch
    echo "  ✗ FAILED: " . v:exception
    return
  endtry
  echo ""

  " Test 4: Test directive completion
  echo "Test 4: Testing directive completion..."
  try
    " Move to last line (the .. line)
    normal! G$

    " Test findstart - should find the position after '..'
    let start = sphinx#completion#complete(1, '')
    echo "  - Completion start position: " . start

    " Test with 'cod' prefix
    let matches = sphinx#completion#complete(0, 'cod')
    echo "  - Matches for 'cod': " . len(matches) . " found"
    if len(matches) > 0
      echo "    First match: " . matches[0].word
      if matches[0].word == 'code-block::'
        echo "  ✓ Completion working correctly"
      else
        echo "  ✗ FAILED: Expected 'code-block::' but got '" . matches[0].word . "'"
        return
      endif
    else
      echo "  ✗ FAILED: No matches found for 'cod'"
      return
    endif
  catch
    echo "  ✗ FAILED: " . v:exception
    return
  endtry
  echo ""

  " Test 5: Test empty prefix completion
  echo "Test 5: Testing completion with empty prefix..."
  try
    let matches = sphinx#completion#complete(0, '')
    echo "  - Total directives available: " . len(matches)
    if len(matches) > 50
      echo "  ✓ All directives returned for empty search"
    else
      echo "  ⚠ WARNING: Only " . len(matches) . " directives found (expected 50+)"
    endif
  catch
    echo "  ✗ FAILED: " . v:exception
    return
  endtry
  echo ""

  " Test 6: Verify some common directives
  echo "Test 6: Verifying common Sphinx directives..."
  let required_directives = ['note', 'warning', 'code-block', 'toctree', 'image']
  let all_directives = sphinx#completion#directives()
  let missing = []

  for directive in required_directives
    if index(all_directives, directive) == -1
      call add(missing, directive)
    endif
  endfor

  if len(missing) == 0
    echo "  ✓ All common directives found: " . join(required_directives, ', ')
  else
    echo "  ✗ FAILED: Missing directives: " . join(missing, ', ')
    return
  endif
  echo ""

  " All tests passed
  echo "========================================="
  echo "✓ All tests passed!"
  echo "========================================="
  echo ""
  echo "Manual test instructions:"
  echo "1. Type '.. cod' on a new line"
  echo "2. Press Ctrl-X Ctrl-O in insert mode"
  echo "3. You should see 'code-block::' in the completion menu"
  echo ""
  echo "Press any key to continue editing, or :q to quit"
endfunction

" Run tests after Vim starts
autocmd VimEnter * call RunTests()
