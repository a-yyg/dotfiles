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

" Vim Script
Plug 'folke/twilight.nvim'

" Vim Script
Plug 'folke/zen-mode.nvim'

" Git integration
" Plug 'mhinz/vim-signify'
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'

" Brackets configuration
Plug 'jiangmiao/auto-pairs'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Dracula Theme
Plug 'Mofiqul/dracula.nvim'

" lir.nvim
" Plug 'tamago324/lir.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'kyazdani42/nvim-web-devicons'

" Nerdtree
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'

" Initialize plugin system
call plug#end()

" lualine.nvim config
lua << END
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
END

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

colorscheme dracula

""""""""""""""""""""""""""""""""""""""""

" Tabs are tabstop spaces
set expandtab
set tabstop=2
set shiftwidth=2
set number

" Use mouse
set mouse=a

" Navigation
" set cursorline
" set cursorcolumn
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
autocmd BufWritePost *.c,*.h,*.cpp,*.hpp,*.cc,*.hh,*.cxx,*.hxx,*.cu silent exec '!astyle % --options="$HOME/.astylerc"' | e!

" Build and run the file
" autocmd FileType c,cpp map <buffer> <C-B> :w<CR>:exec '!clang++ % -o %:r && ./%:r'<CR>
" autocmd FileType c,cpp imap <buffer> <C-B> <esc>:w<CR>:exec '!clang++ % -o %:r && ./%:r'<CR>
autocmd FileType c,cpp,cu map <buffer> <C-B> :w<CR>:exec '!make OBJECTS=%:r.o && make run'<CR>
autocmd FileType c,cpp,cu imap <buffer> <C-B> <esc>:w<CR>:exec '!make OBJECTS=%:r.o && make run'<CR>

nnoremap <leader>z viw<esc>a)<esc>hbi(<esc>lel
nnoremap <leader>x viw<esc>a'<esc>hbi'<esc>lel

" Copy the contents of the current file to the clipboard with xclip
nnoremap <silent> <leader>c :exec '!xclip -selection clipboard -t image/png -i %:p'<CR>

" Escape key to exit insert mode for terminal
tnoremap <Esc> <C-\><C-n>

" Use fontawesome icons as signs
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'
let g:gitgutter_override_sign_column_highlight = 1
highlight SignColumn guibg=#555599
" highlight SignColumn guifg=white

set signcolumn=number

" Open vimagit pane
nnoremap <leader>gs :Magit<CR>       " git status

" Open current line in the browser
nnoremap <Leader>gb :.Gbrowse<CR>

" Open visual selection in the browser
vnoremap <Leader>gb :Gbrowse<CR>

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
