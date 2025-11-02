" Interactive Demo Script for Sphinx Completion
" Run with: vim -u demo.vim

" Set up runtime path
set nocompatible
filetype off

let s:plugin_dir = expand('<sfile>:p:h')
execute 'set runtimepath+=' . s:plugin_dir

filetype plugin indent on

" Display instructions
function! ShowInstructions()
  echo "=========================================="
  echo "Sphinx Completion Interactive Demo"
  echo "=========================================="
  echo ""
  echo "This demo will show you how to use the completion."
  echo ""
  echo "Instructions:"
  echo "1. You are now in NORMAL mode (bottom shows line/col)"
  echo "2. Press 'i' to enter INSERT mode (bottom shows -- INSERT --)"
  echo "3. Press Ctrl-X Ctrl-O to trigger completion"
  echo "4. Use arrow keys or Ctrl-N/Ctrl-P to select"
  echo "5. Press Enter to confirm selection"
  echo "6. Press Esc to return to NORMAL mode"
  echo ""
  echo "Vim Modes:"
  echo "- NORMAL mode: For navigation (press Esc to return here)"
  echo "- INSERT mode: For typing (press 'i' to enter)"
  echo ""
  echo "Try it on the line below that starts with '.. cod'"
  echo ""
  echo "Press any key to start..."
endfunction

" Create demo file content
function! SetupDemo()
  " Clear buffer
  silent! %delete _

  " Add demo content
  call setline(1, 'Sphinx Directive Completion Demo')
  call setline(2, '==============================')
  call setline(3, '')
  call setline(4, 'Try completing these directives:')
  call setline(5, '')
  call setline(6, '.. cod')
  call setline(7, '')
  call setline(8, '.. not')
  call setline(9, '')
  call setline(10, '.. war')
  call setline(11, '')
  call setline(12, '.. ')
  call setline(13, '')
  call setline(14, 'Instructions:')
  call setline(15, '1. Move cursor to end of line 6, 8, 10, or 12')
  call setline(16, '2. Press "i" to enter INSERT mode')
  call setline(17, '3. Press Ctrl-X then Ctrl-O for completion')
  call setline(18, '4. Select from the menu with Ctrl-N/Ctrl-P or arrows')
  call setline(19, '5. Press Enter to confirm')
  call setline(20, '')
  call setline(21, 'Quick reference:')
  call setline(22, '  i = INSERT mode')
  call setline(23, '  Esc = NORMAL mode')
  call setline(24, '  :q = quit (in NORMAL mode)')

  " Set filetype to trigger our plugin
  setfiletype rst

  " Move cursor to first completion line
  call cursor(6, 6)

  " Show mode in statusline
  set showmode
  set ruler
  set laststatus=2

  " Make completion more visible
  set wildmenu
  set completeopt=menuone,longest,preview

  " Add syntax highlighting
  syntax on

  " Highlight the completion trigger lines
  call matchadd('Search', '^\.\..*$')
endfunction

" Auto-complete demo function
function! AutoCompleteDemo()
  echo "=== AUTO-COMPLETION DEMO ==="
  echo ""
  echo "Watch as the completion works automatically..."
  sleep 1

  " Move to first directive line
  call cursor(6, 6)
  redraw
  echo "Moving to line with '.. cod'"
  sleep 1

  " Enter insert mode at end of line
  normal! A
  redraw
  echo "Entered INSERT mode (notice -- INSERT -- at bottom)"
  sleep 2

  " Trigger completion programmatically
  echo "Triggering completion with Ctrl-X Ctrl-O..."
  sleep 1

  " Simulate completion
  call feedkeys("\<C-X>\<C-O>", 'n')
  redraw

  echo ""
  echo "Completion menu should appear!"
  echo "Now YOU try it on other lines."
  echo ""
  echo "Press 'i' for INSERT mode, then Ctrl-X Ctrl-O"
endfunction

" Setup on start
autocmd VimEnter * call ShowInstructions() | call inputsave() | call input('') | call inputrestore() | call SetupDemo()

" Add helpful mappings
" F1 - Show help
nnoremap <F1> :call ShowInstructions()<CR>

" F2 - Auto demo
nnoremap <F2> :call AutoCompleteDemo()<CR>

" Set some helpful options
set nobackup
set nowritebackup
set noswapfile

" Show instructions in statusline
set statusline=%F\ %m%r%h%w\ [Mode:\ %{mode()}]\ [Line:\ %l/%L\ Col:\ %c]

echo "Demo loaded! Press F1 for help, F2 for auto-demo"
