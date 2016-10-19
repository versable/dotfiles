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
Plug 'chriskempson/base16-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-signify'
Plug 'scrooloose/syntastic'
Plug 'shougo/neocomplete.vim'
Plug 'SirVer/ultisnips'
Plug 'szw/vim-tags'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny'  }
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
call plug#end()

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

" Loads the base16-shell theme
set t_Co=256
let base16colorspace=256
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif

set hidden
set showcmd
set hlsearch
set lazyredraw
set showmatch
set ignorecase
set smartcase
set nostartofline
set confirm
set shiftwidth=4
set softtabstop=4
set expandtab
set cc=80
set cursorline

" Setting number and relativenumber displays the absolute number in the
" current line and the relative numbers above and below the current line.
set number
set relativenumber

" CtrlP extensions
let g:ctrlp_extensions = ['tag', 'buffertag']

" Reverse tab order for SuperTab
let g:SuperTabMappingForward = '<s-tab>'
let g:SuperTabMappingBackward = '<tab>'

" Disabe vim-session dialog
:let g:session_autoload = 'no'

" Recommended settings for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Enable perl for Syntastic
let g:syntastic_enable_perl_checker = 1

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
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep=''

" Map <F8> to the tagbar
nmap <F8> :TagbarToggle<CR>

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
inoremap <expr><CR> pumvisible()? "\<C-y>" : "\<CR>"

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" Load guard for the perltidy scripts
if ( exists('g:perltidy_loaded') && g:perltidy_loaded )
    \ || v:version < 700 || &cp
    finish
endif
let g:perltidy_loaded = 1

" Define :Tidy command to run perltidy on visual selection || entire buffer
command -range=% -nargs=* Tidy <line1>,<line2>!perltidy -pbp -bl -sbl

" Run :Tidy on entire buffer and return cursor to original position
fun DoTidy()
    let l = line(".")
    let c = col(".")
    :Tidy
    call cursor(l, c)
endfun

" Shortcut for normal mode to run on entire buffer then return to current line
au Filetype perl nmap <F2> :call DoTidy()<CR>

" Shortcut for visual mode to run on the the current visual selection
au Filetype perl vmap <F2> :Tidy<CR>
