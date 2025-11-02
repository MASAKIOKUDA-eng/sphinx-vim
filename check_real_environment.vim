" Check real environment for omnifunc issue
" Run this with: vim test.rst
" Then in Vim, run :source check_real_environment.vim

function! CheckEnvironment()
  echo "========================================"
  echo "Environment Check"
  echo "========================================"
  echo ""

  " Check current file
  echo "Current file: " . expand('%')
  echo "File exists: " . filereadable(expand('%'))
  echo ""

  " Check filetype
  echo "Filetype: '" . &filetype . "'"
  if &filetype == 'rst'
    echo "  ✓ Filetype is correct"
  else
    echo "  ✗ Filetype is WRONG (should be 'rst')"
    echo "  → This is the problem!"
    echo ""
    echo "Solution: Run this command:"
    echo "  :set filetype=rst"
  endif
  echo ""

  " Check omnifunc
  echo "Omnifunc: '" . &omnifunc . "'"
  if &omnifunc == 'sphinx#completion#complete'
    echo "  ✓ Omnifunc is correct"
  elseif &omnifunc == ''
    echo "  ✗ Omnifunc is NOT SET"
    echo "  → This is why you get the error!"
  else
    echo "  ⚠ Omnifunc is set to something else"
  endif
  echo ""

  " Check if ftplugin loaded
  if exists('b:did_ftplugin_sphinx')
    echo "Plugin loaded: YES"
    echo "  ✓ ftplugin/rst.vim was executed"
  else
    echo "Plugin loaded: NO"
    echo "  ✗ ftplugin/rst.vim was NOT executed"
    echo "  → This explains why omnifunc is not set"
  endif
  echo ""

  " Check runtimepath
  echo "Checking runtimepath..."
  let found_plugin = 0
  for path in split(&runtimepath, ',')
    if path =~ 'sphinx-vim'
      echo "  ✓ Found: " . path
      let found_plugin = 1
    endif
  endfor

  if !found_plugin
    echo "  ✗ sphinx-vim NOT in runtimepath!"
    echo "  → You need to install the plugin properly"
    echo ""
    echo "Installation methods:"
    echo "1. Using vim-plug: Add to .vimrc"
    echo "   Plug 'path/to/sphinx-vim'"
    echo ""
    echo "2. Manual: Add to .vimrc"
    echo "   set runtimepath+=" . expand('<sfile>:p:h')
  endif
  echo ""

  " Check if autoload file exists
  let autoload_file = expand('<sfile>:p:h') . '/autoload/sphinx/completion.vim'
  echo "Autoload file: " . autoload_file
  if filereadable(autoload_file)
    echo "  ✓ File exists"
  else
    echo "  ✗ File NOT found"
  endif
  echo ""

  " Check if ftdetect file exists
  let ftdetect_file = expand('<sfile>:p:h') . '/ftdetect/rst.vim'
  echo "Ftdetect file: " . ftdetect_file
  if filereadable(ftdetect_file)
    echo "  ✓ File exists"
  else
    echo "  ✗ File NOT found"
  endif
  echo ""

  " Check if ftplugin file exists
  let ftplugin_file = expand('<sfile>:p:h') . '/ftplugin/rst.vim'
  echo "Ftplugin file: " . ftplugin_file
  if filereadable(ftplugin_file)
    echo "  ✓ File exists"
  else
    echo "  ✗ File NOT found"
  endif
  echo ""

  " Check filetype plugin setting
  echo "Filetype plugin enabled: " . (&filetype == '' ? 'Unknown' : (exists('b:did_ftplugin') || exists('b:did_ftplugin_sphinx') ? 'YES' : 'NO'))
  echo ""

  " Recommendations
  echo "========================================"
  echo "RECOMMENDATIONS"
  echo "========================================"
  echo ""

  if &filetype != 'rst'
    echo "1. Set filetype manually:"
    echo "   :set filetype=rst"
    echo ""
  endif

  if !found_plugin
    echo "2. Add to your .vimrc or init.vim:"
    echo "   filetype plugin on"
    echo "   set runtimepath+=" . expand('<sfile>:p:h')
    echo ""
  endif

  echo "3. After fixing, reload the file:"
  echo "   :edit"
  echo ""

  echo "4. Verify omnifunc is set:"
  echo "   :set omnifunc?"
  echo ""

  echo "========================================"
endfunction

" Auto-run on load
call CheckEnvironment()
