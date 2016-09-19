" Vim Plug magic
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
"
" Needs to be set if vim is compiled without ruby
let g:plug_threads = 1

" Plugs
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'terryma/vim-multiple-cursors'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'chriskempson/base16-vim'
Plug 'szw/vim-tags'
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vim-scripts/AutoComplPop'
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny'  }
call plug#end()

" Loads the base16-shell theme
if filereadable(expand("~/.vimrc_background"))
  set t_Co=256
  let base16colorspace=256
  source ~/.vimrc_background
endif

set hidden
set showcmd
set hlsearch
set ignorecase
set smartcase
set nostartofline
set confirm
set shiftwidth=4
set softtabstop=4
set expandtab
set cc=80
set cursorline
set number
set relativenumber

" CtrlP extensions
let g:ctrlp_extensions = ['tag', 'buffertag']

" Show trailing whitespace, tabs, highlight trailing whitespace red
set list listchars=tab:→\ ,trail:·
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Airline themes and 'straight look' settings
let g:airline_theme='base16_eighties'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

