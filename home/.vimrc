" PastLeo's ~/.vimrc

"---------------------------------------------------------------------------
" Some basic checkings and settings
"---------------------------------------------------------------------------
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif
set nocompatible    " not compatible with the old-fashion vi mode

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
" Only do this part when compiled with support for autocommands.
" set t_Co=256
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

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
  set autoindent    " always set autoindenting on
  finish "require autocmd to continue
endif " has("autocmd")

"---------------------------------------------------------------------------
" Terminal and platform settings
"---------------------------------------------------------------------------
let s:bad_term=0

if has('win32')
  " set shell=powershell.exe\ -executionpolicy\ bypass
  if has('gui_running') " Using gvim
    let $LANG="en_US.UTF-8"
    set langmenu=en_US.utf-8
    set encoding=utf8
    set guifont=Consolas:h10

    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
    set guioptions-=e  "use console tab instead of ugly gui tab

    set guicursor=n-v-c:block-Cursor
    set guicursor+=i:ver100-iCursor
    set guicursor+=n-v-c:blinkon0
    set guicursor+=i:blinkwait10


    " reload menu with UTF-8 encoding
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
  elseif !empty($CONEMUBUILD)
    if !empty($CONEMU_UTF8)
      set encoding=utf-8
      set termencoding=utf8
    endif
    if !empty($CONEMU_XTERM)
      set term=xterm
      set t_Co=256
      let &t_AB="\e[48;5;%dm"
      let &t_AF="\e[38;5;%dm"
    else
      let s:bad_term=1
    endif

    " Mouse scroll
    inoremap <Esc>[62~ <C-X><C-E>
    inoremap <Esc>[63~ <C-X><C-Y>
    nnoremap <Esc>[62~ <C-E>
    nnoremap <Esc>[63~ <C-Y>
  else
    let s:bad_term=1
  endif
endif

"---------------------------------------------------------------------------
" Encoding settings
"---------------------------------------------------------------------------
if has("multi_byte") && s:bad_term == 0
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1
endif

"---------------------------------------------------------------------------
" General settings
"---------------------------------------------------------------------------

" auto read when file is changed from outside
set autoread

" allow backspacing over everything in insert mode
set backspace=2
set backspace=indent,eol,start

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" keep 50 lines of command line history
set history=50

" show the cursor position all the time
set ruler

" do not keep a backup file, use versions instead
set nobackup

" display incomplete commands
set showcmd

" do incremental searching
set incsearch

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Dont save options to session file
set sessionoptions-=options

" Split at right and below
set splitright
set splitbelow

" stop from creating undo file
set noundofile

" smartcase
set smartcase

" enable per project setting
set exrc

" don't pre-select any completion automatically
set completeopt=menuone,noselect

"---------------------------------------------------------------------------
" Functions and commands
"---------------------------------------------------------------------------

" Actions
function! ShowCurrentFilePaths()
  call input("Showing current file (buffer) paths, press enter to continue:\n" . expand('%:p') . "\n" . @% . "\n")
endfunction

" Processors

fun! Linend_DosToUnix()
  :update
  :e ++ff=dos
  :setlocal ff=unix
  :echo "use :w to save"
endfun
command! Linend2Unix call Linend_DosToUnix()

fun! Linend_UnixToDos()
  :update
  :e ++ff=dos
  :echo "use :w to save"
endfun
command! Linend2Dos call Linend_UnixToDos()

fun! ConvertIndentTabsToSpace()
  let new_tabstop = input("Convert tabs to spaces, how many spaces per tab?\n (press enter to use current tabstop = " . &tabstop . ") ")
  set expandtab
  if !empty(new_tabstop)
    exe 'set tabstop=' . new_tabstop
  endif
  retab
  echo "\n > Done. use :w to save"
endfun
command! ConvertIndent2Spaces call ConvertIndentTabsToSpace()

fun! ConvertIndentSpaceToTabs()
  set sts=&ts noet
  retab!
  echo "Convert space indent to spaces done. use :w to save"
endfun
command! ConvertIndent2Tabs call ConvertIndentSpaceToTabs()

"---------------------------------------------------------------------------
" Key mappings
"---------------------------------------------------------------------------
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Don't use Ex mode, use Q for formatting
map Q gq

" set leader to t key
let mapleader='t'
let g:mapleader='t'

" New tab and split
nnoremap <leader>n :tabnew<CR>
nnoremap <leader>N :tab split<CR>
nnoremap <leader>i :split<CR>
nnoremap <leader>I :new<CR>
nnoremap <leader>s :vsplit<CR>
nnoremap <leader>S :vnew<CR>

" split vertically and diff with a file
nnoremap <leader>D :vert diffsplit<SPACE>

" Navigation before tabs
nnoremap <leader>h :tabprevious<CR>
nnoremap <leader>l :tabnext<CR>
nnoremap <leader>j <C-W>w
nnoremap <leader>k <C-W>W

" Move split line
nnoremap <S-J> :resize +1<CR>
nnoremap <S-K> :resize -1<CR>
nnoremap <S-L> :vertical resize +2<CR>
nnoremap <S-H> :vertical resize -2<CR>

" Move tabs around
nnoremap <leader>L :tabmove +<CR>
nnoremap <leader>H :tabmove -<CR>

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" Block Visual
nnoremap <leader>v <C-v>

" <leader>p toggles paste mode
nnoremap <leader>p :set paste!<BAR>set paste?<CR>

" Search and replace for selected text
vnoremap <leader>r :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
  \:%s//

" Show current file (buffer) full path
nnoremap <leader>W :call ShowCurrentFilePaths()<CR>

"---------------------------------------------------------------------------
" Autocmds
"---------------------------------------------------------------------------
" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1

"---------------------------------------------------------------------------
" Theme
"---------------------------------------------------------------------------
if s:bad_term == 0
  set background=dark
  colorscheme zenburn
  hi IndentGuidesEven guibg=#36382f ctermbg=235

  " Overwrite some settings
  hi Normal ctermfg=NONE ctermbg=NONE guifg=#75f1ab guibg=#272822
  hi Cursor ctermfg=NONE ctermbg=NONE guifg=#272822 guibg=#e5e5e5
  hi iCursor ctermfg=NONE ctermbg=8 guifg=#272822 guibg=#717171
  hi Visual ctermfg=0 ctermbg=10 guifg=#272822 guibg=#4dff70

  hi TabLine      ctermfg=Black  ctermbg=242
  hi TabLineFill  ctermfg=Black  ctermbg=239
  hi TabLineSel   ctermfg=White  ctermbg=2

  let g:indent_guides_auto_colors = 0
endif

"---------------------------------------------------------------------------
" Keeping other unknown settings by generators
"---------------------------------------------------------------------------
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" prevent unsafe command from per project vimrc
set secure
