" Test that writes output to a file
set nocompatible
filetype off

let s:plugin_dir = expand('<sfile>:p:h')
execute 'set runtimepath+=' . s:plugin_dir

filetype plugin indent on

" Load autoload file
execute 'source ' . s:plugin_dir . '/autoload/sphinx/completion.vim'

let s:output = []

function! Log(msg)
  call add(s:output, a:msg)
endfunction

" Test
enew
setfiletype rst
call setline(1, '.. cod')
call cursor(1, 6)

call Log("=== DIAGNOSTIC ===")
call Log("")
call Log("Filetype: " . &filetype)
call Log("Omnifunc: " . &omnifunc)
call Log("Function exists: " . string(exists('*sphinx#completion#complete')))
call Log("")

call Log("Current line: '" . getline('.') . "'")
call Log("Cursor position: line=" . line('.') . " col=" . col('.'))
call Log("")

try
  let start = sphinx#completion#complete(1, '')
  call Log("findstart result: " . start)

  if start >= 0
    call Log("✓ findstart OK")
    let matches = sphinx#completion#complete(0, 'cod')
    call Log("matches for 'cod': " . len(matches))
    if len(matches) > 0
      call Log("✓ Got matches!")
      for m in matches
        call Log("  - " . m.word)
      endfor
    else
      call Log("✗ No matches returned")
    endif
  else
    call Log("✗ findstart returned -1 - THIS IS THE PROBLEM")
    call Log("Line does not start with '.. ' or regex failed")
  endif
catch
  call Log("✗ ERROR: " . v:exception)
endtry

call writefile(s:output, 'diagnostic_output.txt')
qall!
