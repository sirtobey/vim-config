" If vundle is not installed, do it first
if (!isdirectory(expand("$HOME/.vim/bundle/vundle")))
    call system(expand("mkdir -p $HOME/.vim/bundle"))
    call system(expand("git clone https://github.com/gmarik/vundle $HOME/.vim/bundle/vundle"))
    echoerr 'Vundle was freshly installed. You should run :BundleInstall'
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Plugin 'gmarik/vundle'
Plugin 'vim-python-virtualenv'
"Plugin 'davidhalter/jedi-vim.git'
Plugin 'Syntastic'
Plugin 'bling/vim-airline'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'https://github.com/Valloric/YouCompleteMe.git'
let g:syntastic_python_checkers = ['pylama']
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_python_flake8_args = '--ignore=E221,E241,E272,E251,W702,E203'
let g:syntastic_python_pylama_args = '-l pep8,pyflakes,pylint -i E203,E272,E221,E251,E202,E271,C0302,W0511,F0401,E1101,R0901,R0904,C0111,C0103,R0921,R0201,E211'
let g:pymode_rope_guess_project = 0
let g:jedi#popup_on_dot           = 0
let g:jedi#use_splits_not_buffers = ""
let g:jedi#popup_select_first     = 0
let g:jedi#show_call_signatures   = 0


set modeline
syntax on

autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala            setfiletype vala
au BufRead,BufNewFile *.vapi            setfiletype vala
au BufRead,BufNewFile *.json            setfiletype javascript
au BufRead,BufNewFile *.css set ft=css syntax=css3

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

setlocal omnifunc=syntaxcomplete#Complete

let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_NamespaceSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 50
let Tlist_File_Fold_Auto_Close = 1
map <F4> :TlistToggle<cr>

filetype indent on

let g:miniBufExplUseSingleClick = 1

set vb

set pastetoggle=<F3>

set list listchars=tab:»\ ,trail:·,precedes:…,extends:…,nbsp:‗

" OPTIONAL
" show whitespace at end of lines
highlight WhitespaceEOL ctermbg=lightgray guibg=lightgray
match WhitespaceEOL /s+$/

set noet ci sts=0 sw=2 ts=2

set autoindent

set tabpagemax=16
set showtabline=1

if has("gui_running")
	set mouse=a
	colorscheme mustang
	"nmap "+gP
	"imap i
	"vmap "+y
	map <F8> :TName(input('label: '))<CR>
	set guifont=DejaVu\ Sans\ Mono\ 8
	set guioptions-=T
	set guioptions-=m
	set guioptions-=r
	set guioptions-=L
	set nu
	set cursorline
	set cursorcolumn
	highlight CursorColumn guibg=#2d2d2d
	highlight CursorLine guibg=#262626
	highlight SpecialKey guifg=#444444
	autocmd vimenter * NERDTree
else
	set mouse=
	colorscheme slate
	set tenc=utf8
end



"php syntax test
function! PHPsynCHK()
let winnum =winnr() " get current window number
silent make -l %
cw " open the error window if it contains error
" return to the window with cursor set on the line of the first error (if any)
execute winnum . "wincmd w"
endfunction


setl makeprg=php
set errorformat=%m\ in\ %f\ on\ line\ %l

" PHP Syntax
let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=1

"php auto indent
let PHP_autoformatcomment = 1 "default 1
let PHP_default_indenting = 0 "default 0
let PHP_removeCRwhenUnix  = 1 "default 0 but 1 is needed to enable indention on windows files
let PHP_BracesAtCodeLevel = 0 "default 0

"folding
set foldenable

" Make folding indent sensitive
set foldmethod=syntax

" Don't autofold anything (but I can still fold manually)
set foldlevel=100

""
" visual cues
""
"smarty syntax
au BufRead,BufNewFile *.tpl set filetype=smarty

"highlight as you type search phrase
set incsearch

" don't blink
set novisualbell

" xml plugin
let xml_use_xhtml = 1

set nocompatible

function! Tabstyle_tabs()
  set softtabstop=4
  set shiftwidth=4
  set tabstop=4
  set noexpandtab
endfunction

function! Tabstyle_spaces()
  set softtabstop=4
  set shiftwidth=4
  set tabstop=4
  set expandtab
endfunction

call Tabstyle_spaces()

" Indentation
set ai " autoindent
set si " smartindent

" Windows
set equalalways " Multiple windows, when created, are equal in size
set splitbelow splitright

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase " only ignore case on lowercase searches

" Misc
set matchpairs+=<:>

" Don't save backups of *.gpg files
set backupskip+=*.gpg
" To avoid that parts of the file is saved to .viminfo when yanking or
" deleting, empty the 'viminfo' option.
set viminfo=

augroup encrypted
  au!
  " Disable swap files, and set binary file format before reading the file
  autocmd BufReadPre,FileReadPre *.gpg
    \ setlocal noswapfile bin
  " Decrypt the contents after reading the file, reset binary file format
  " and run any BufReadPost autocmds matching the file name without the .gpg
  " extension
  autocmd BufReadPost,FileReadPost *.gpg
    \ execute "'[,']!gpg --decrypt --default-recipient-self" |
    \ setlocal nobin |
    \ execute "doautocmd BufReadPost " . expand("%:r")
  " Set binary file format and encrypt the contents before writing the file
  autocmd BufWritePre,FileWritePre *.gpg
    \ setlocal bin |
    \ '[,']!gpg --encrypt --default-recipient-self
  " After writing the file, do an :undo to revert the encryption in the
  " buffer, and reset binary file format
  autocmd BufWritePost,FileWritePost *.gpg
    \ silent u |
    \ setlocal nobin
augroup END

set wildmode=longest,list
set laststatus=2
