" rst.vim - Filetype detection for reStructuredText files
" Maintainer: sphinx-vim
" Version: 0.1.0

" Detect .rst and .rest files as reStructuredText
autocmd BufNewFile,BufRead *.rst,*.rest setfiletype rst
