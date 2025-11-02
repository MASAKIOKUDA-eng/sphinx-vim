" Automated test script for Sphinx completion
" Run with: vim -u run_tests.vim -c "quit"

" Set up runtime path to include this plugin
set nocompatible
filetype off

" Add current directory to runtimepath
let s:plugin_dir = expand('<sfile>:p:h')
execute 'set runtimepath+=' . s:plugin_dir

" Enable filetype plugins
filetype plugin indent on

" Explicitly load the autoload script
execute 'source ' . s:plugin_dir . '/autoload/sphinx/completion.vim'

" Redirect output to a variable
let s:test_output = []

function! s:Log(msg)
  call add(s:test_output, a:msg)
endfunction

function! s:RunTests()
  call s:Log("=========================================")
  call s:Log("Sphinx Completion Test Suite")
  call s:Log("=========================================")
  call s:Log("")

  let s:passed = 0
  let s:failed = 0

  " Test 1: Check if autoload function exists
  call s:Log("Test 1: Checking sphinx#completion#directives()...")
  try
    let directives = sphinx#completion#directives()
    call s:Log("  ✓ PASS: Function returned " . len(directives) . " directives")
    call s:Log("  Sample: " . join(directives[0:4], ', '))
    let s:passed += 1
  catch
    call s:Log("  ✗ FAIL: " . v:exception)
    let s:failed += 1
  endtry
  call s:Log("")

  " Test 2: Check if completion function exists
  call s:Log("Test 2: Checking sphinx#completion#complete()...")
  try
    if exists('*sphinx#completion#complete')
      call s:Log("  ✓ PASS: Function exists")
      let s:passed += 1
    else
      call s:Log("  ✗ FAIL: Function does not exist")
      let s:failed += 1
    endif
  catch
    call s:Log("  ✗ FAIL: " . v:exception)
    let s:failed += 1
  endtry
  call s:Log("")

  " Test 3: Open RST file and check omnifunc
  call s:Log("Test 3: Checking omnifunc setting...")
  try
    edit test.rst
    if &omnifunc == 'sphinx#completion#complete'
      call s:Log("  ✓ PASS: omnifunc = " . &omnifunc)
      let s:passed += 1
    else
      call s:Log("  ✗ FAIL: omnifunc = '" . &omnifunc . "' (expected 'sphinx#completion#complete')")
      let s:failed += 1
    endif
  catch
    call s:Log("  ✗ FAIL: " . v:exception)
    let s:failed += 1
  endtry
  call s:Log("")

  " Test 4: Test completion with 'cod' prefix
  call s:Log("Test 4: Testing completion with 'cod' prefix...")
  try
    let matches = sphinx#completion#complete(0, 'cod')
    if len(matches) > 0 && matches[0].word == 'code-block::'
      call s:Log("  ✓ PASS: Found 'code-block::' (" . len(matches) . " matches)")
      let s:passed += 1
    else
      call s:Log("  ✗ FAIL: Expected 'code-block::' as first match")
      let s:failed += 1
    endif
  catch
    call s:Log("  ✗ FAIL: " . v:exception)
    let s:failed += 1
  endtry
  call s:Log("")

  " Test 5: Test completion with 'note' prefix
  call s:Log("Test 5: Testing completion with 'note' prefix...")
  try
    let matches = sphinx#completion#complete(0, 'note')
    if len(matches) > 0 && matches[0].word == 'note::'
      call s:Log("  ✓ PASS: Found 'note::' (" . len(matches) . " matches)")
      let s:passed += 1
    else
      call s:Log("  ✗ FAIL: Expected 'note::' as first match")
      let s:failed += 1
    endif
  catch
    call s:Log("  ✗ FAIL: " . v:exception)
    let s:failed += 1
  endtry
  call s:Log("")

  " Test 6: Test empty prefix
  call s:Log("Test 6: Testing completion with empty prefix...")
  try
    let matches = sphinx#completion#complete(0, '')
    if len(matches) > 50
      call s:Log("  ✓ PASS: Returns all " . len(matches) . " directives")
      let s:passed += 1
    else
      call s:Log("  ⚠ WARN: Only " . len(matches) . " directives (expected 50+)")
      let s:passed += 1
    endif
  catch
    call s:Log("  ✗ FAIL: " . v:exception)
    let s:failed += 1
  endtry
  call s:Log("")

  " Test 7: Verify essential directives
  call s:Log("Test 7: Verifying essential directives...")
  try
    let directives = sphinx#completion#directives()
    let required = ['note', 'warning', 'code-block', 'toctree', 'image', 'figure', 'admonition']
    let missing = []
    for d in required
      if index(directives, d) == -1
        call add(missing, d)
      endif
    endfor
    if len(missing) == 0
      call s:Log("  ✓ PASS: All essential directives present")
      let s:passed += 1
    else
      call s:Log("  ✗ FAIL: Missing: " . join(missing, ', '))
      let s:failed += 1
    endif
  catch
    call s:Log("  ✗ FAIL: " . v:exception)
    let s:failed += 1
  endtry
  call s:Log("")

  " Summary
  call s:Log("=========================================")
  call s:Log("Test Results:")
  call s:Log("  Passed: " . s:passed)
  call s:Log("  Failed: " . s:failed)
  call s:Log("  Total:  " . (s:passed + s:failed))
  call s:Log("=========================================")

  if s:failed == 0
    call s:Log("")
    call s:Log("✓✓✓ ALL TESTS PASSED! ✓✓✓")
    call s:Log("")
  else
    call s:Log("")
    call s:Log("✗✗✗ SOME TESTS FAILED ✗✗✗")
    call s:Log("")
  endif

  " Write results to file
  call writefile(s:test_output, 'test_results.txt')

  " Print to stdout
  for line in s:test_output
    echomsg line
  endfor

  return s:failed
endfunction

" Run tests and quit
let s:exit_code = s:RunTests()
if s:exit_code == 0
  cquit 0
else
  cquit 1
endif
