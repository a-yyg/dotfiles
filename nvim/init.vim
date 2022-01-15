" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Nix Support
Plug 'LnL7/vim-nix'

" Clang Autocompletion
Plug 'deoplete-plugins/deoplete-clang'

" Copilot Autocomplete
Plug 'github/copilot.vim'

" Git integration
Plug 'tpope/vim-fugitive'

" Initialize plugin system
call plug#end()

let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'vim': ['vint'],
    \ 'cpp': ['clang'],
    \ 'c': ['clang']
\}

" custom setting for clangformat
let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{IndentWidth: 4}"']
\}
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']

""""""""""""""""""""""""""""""""""""""""

" Tabs are tabstop spaces
set expandtab
set tabstop=4
set shiftwidth=4
set number

" Navigation
set cursorline
set cursorcolumn
set autoindent
set smartindent
set showmatch
nmap <silent> <C-j> :tabp<CR>
nmap <silent> <C-k> :tabn<CR>

autocmd BufNewFile,BufRead *.md set filetype=markdown

nmap <F5> :w<CR> :source %<CR>
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType markdown map <buffer> <F9> :w<CR>:exec '!pandoc % -o %:r.pdf --pdf-engine=xelatex; chromium %:r.pdf'<CR>
autocmd FileType markdown imap <buffer> <F9> <esc>:w<CR>:exec '!pandoc % -o %:r.pdf --pdf-engine=xelatex; chromium %:r.pdf'<CR>
autocmd FileType markdown map <buffer> <F8> :w<CR>:exec '!pandoc % -o %:r.html'<CR>
autocmd FileType markdown imap <buffer> <F8> <esc>:w<CR>:exec '!pandoc % -o %:r.html'<CR>


" Use the following to format code on save
autocmd FileType c,cpp setlocal formatoptions+=q

" Format C/C++ on Ctrl-F
autocmd FileType c,cpp map <buffer> <C-F> :exec '!astyle %'<CR>:e!<CR>

" Format C/C++ code on save
"
autocmd BufWritePost *.c,*.h,*.cpp,*.hpp,*.cc,*.hh,*.cxx,*.hxx silent exec '!astyle %' | e!

" Build and run the file
" autocmd FileType c,cpp map <buffer> <C-B> :w<CR>:exec '!clang++ % -o %:r && ./%:r'<CR>
" autocmd FileType c,cpp imap <buffer> <C-B> <esc>:w<CR>:exec '!clang++ % -o %:r && ./%:r'<CR>
autocmd FileType c,cpp map <buffer> <C-B> :w<CR>:exec '!make OBJECTS=%:r.o && make run'<CR>
autocmd FileType c,cpp imap <buffer> <C-B> <esc>:w<CR>:exec '!make OBJECTS=%:r.o && make run'<CR>

nnoremap <leader>z viw<esc>a)<esc>hbi(<esc>lel
nnoremap <leader>x viw<esc>a'<esc>hbi'<esc>lel
