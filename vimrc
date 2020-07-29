" Alvin Cao vimrc script
" alvin.cao@gmail.com

if has("gui_running")
  set guioptions-=m " no menu
  set guioptions-=T " no toolbar
  au GUIEnter * simalt ~x " maximise window
  if has("win32")
    set guifont=Cascadia\ Code:h10
    set guifontwide=Sarasa\ Mono\ SC:h11
  endif
endif

set nocompatible

"runtime bundle/vim-pathogen/autoload/pathogen.vim
"execute pathogen#infect()

set encoding=utf-8

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
if has("gui_running")
	set showcmd		" display incomplete commands, will make terminal slow
endif
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"  set mouse=a
"endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
syntax on
set hlsearch
"if has("gui_running")
"  set background=dark
"else
"  set background=dark
"endif
"let g:solarized_termcolors=256
colorscheme nord


" indentation things
set shiftwidth=4
set tabstop=4

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  
  autocmd FileType sh setlocal shiftwidth=2 tabstop=2 expandtab
  autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab
  autocmd FileType c setlocal shiftwidth=4 tabstop=4 expandtab
  autocmd FileType java setlocal shiftwidth=4 tabstop=4 expandtab
  autocmd FileType vim setlocal shiftwidth=2 tabstop=2 expandtab

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" nerdtree
map <F2> :NERDTreeToggle<CR>

" handy key mapping to switch buffer
" should not work on console vim
map <C-Tab> :bn<CR>
map <C-S-Tab> :bp<CR>

" Move lines
nmap <C-Down> :<C-u>move .+1<CR>
nmap <C-Up> :<C-u>move .-2<CR>

imap <C-Down> <C-o>:<C-u>move .+1<CR>
imap <C-Up> <C-o>:<C-u>move .-2<CR>

vmap <C-Down> :move '>+1<CR>gv
vmap <C-Up> :move '<-2<CR>gv

" more informative status line
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set laststatus=2

set wildmode=longest,list
set cscopequickfix=c-,d-,e-,g-,i-,s-,t-
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
nmap <C-n> :cnext<CR>
nmap <C-p> :cprev<CR>

nmap <F3> :TagbarToggle<CR>

map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

" For GNU global
nmap <F5> :GtagsCursor<CR>
nmap <F6> :Gtags<Space>
nmap <F7> :copen<CR>
nmap <F8> :cclose<CR>

" vim-airline
let g:airline_theme='molokai'
let g:airline#extensions#tabline#enabled=1
