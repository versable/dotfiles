" Vim Plug magic
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Needs to be set if vim is compiled without ruby
let g:plug_threads = 1

" Plugs
call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'nordtheme/vim'
Plug 'vim-airline/vim-airline'
call plug#end()

" Color theme
colorscheme nord

" Don't save the session
let g:session_autosave = 'no'

" Use a seperate directory for temp vim files
if !empty(glob(".vim/backup/"))
  set backupdir=~/.vim/backup//
endif
if !empty(glob(".vim/swap/"))
  set directory=~/.vim/swap//
endif
if !empty(glob(".vim/undo/"))
  set undodir=~/.vim/undo//
endif

" Set clipboard to X11 buffer
set clipboard=unnamedplus

" Clear highlight selection
nnoremap <silent> <F3> :let @/ = ""<CR>

" Hide closed buffers
set hidden
" Shows last command in the status bar
set showcmd
" Highlight all search matches
set hlsearch
" Don't redraw on macros, registers etc. Use :redraw for manual redraw
set lazyredraw
" Show matching brackets etc.
set showmatch
" Match case insensitive IF the search term is lowercase
set ignorecase
set smartcase
" Autoindent
set nostartofline
" Asks if a file should be saved, rather then displaying an error
set confirm
" Tabstop values
set shiftwidth=4
set softtabstop=4
set expandtab
" 80 char marker
set cc=80
" Highlight the line the cursore is on
set cursorline

" Setting number and relativenumber displays the absolute number in the
" current line and the relative numbers above and below the current line.
set number
set relativenumber

" CtrlP extensions
let g:ctrlp_extensions = ['tag', 'buffertag']

" Disabe vim-session dialog
:let g:session_autoload = 'no'

" Set spell for gitcommit
autocmd FileType gitcommit setlocal spell

" Show trailing whitespace, tabs, highlight trailing whitespace red
set list listchars=tab:→\ ,trail:·
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Airline themes and 'straight look' settings
"let g:airline_theme='base16_eighties'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep=''
