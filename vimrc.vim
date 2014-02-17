" #########################################################################
"  File Info:   LiTuX's personal vimrc file
"  Last Change: 2014-02-17 00:47:01
"
"  ReadMe:      This is my personal vimrc for daily use, some of those
"               configurations are still not adjusted, and MAY be changed
"               anytime if I find a better one for me.
"
"               So, if you wanna use this file as YOUR vimrc,
"               "use at your own risk", ^_^
"
"               However, this vimrc was supposed to be something like the
"               well known "spf13" vimrc, although it is not at least now.
"               So I'm trying to made it as clearly as possible,
"               *in case* someone want to know some details of this vimrc.
"               But, remember, NEVER use a config file that you don't know
"               what it did if it is not the default.
"               If you want to use it, please READ THE SOURCE, you'd better
"               understand every line in this file to use it.
"
"               BTW, most plugins are configured in another script file.
"               Read section "Plugins" for details.
" #########################################################################

" # Common settings {{{
set nocompatible
" set language at the beginning to prevent garbled messages.
" Always use English messages.
try
    silent lang messages en_US.utf8     " Work on my Linux/MSYS2, Windows.
catch " catch all
    try
        silent lang messages en_US.ISO_8859-1
    catch " catch all
        lang messages C                 " If all failed, use C.
    endtry
endtry

" Encoding && language: TODO
if has("win32") || has("win64")
    lang English                        " don't have 'en_US'
    set tenc=chinese                    " cp936
    if !has("gui_running")
        set enc=chinese                 " windows console version
    endif
else                                    " For Linux, cygwin/MSYS:
    lang en_US.utf8
    set enc=utf8                        " NOTE cygwin/MSYS *can* be cp936
endif

set fencs=ucs-bom,utf8,cp936,gb18030,big5,euc-jp,euc-kr,default,latin1
" set ambiwidth=double

" Fonts et al.
if has("gui_running")
    set enc=utf8                        " GUI always use utf-8
    source $VIMRUNTIME/delmenu.vim      " Refresh menu
    source $VIMRUNTIME/menu.vim
    if has("gui_gtk2")
        " set gfn=Lucida\ Sans\ Typwriter\ 11,DejaVu\ Sans\ Mono\ 11,Monospace\ 11
        set gfn=DejaVu\ Sans\ Mono\ 12,Monospace\ 12
        set gfw=WenQuanYi\ Micro\ Hei\ 12,WenQuanYi\ Zen\ Hei\ 12 " Microsoft\ Yahei\ 11
    elseif has("x11")                   " Also for GTK1, TODO
        set gfn=*-lucidatypewriter-medium-r-normal-*-*-180-*-*-m-*-*
    elseif has("gui_win32")
        set gfn=LucidaMonoEF:h12,Lucida_Sans_Typwriter:h11,monaco:h11,DejaVu_Sans_Mono:h11,Consolas:h11,Fixedsys:h12
        set gfw=YouYuan:h12,NSimSun:h12 " YouYuan lacks lots of glyphs.
    endif
else                                    " for console version
    if &term == 'xterm' || &term == 'screen'
        set t_Co=256
    endif
endif

let mapleader=','

set background=dark
set number
set relativenumber
set display+=lastline
set modeline
set history=500
" set linebreak                     " don't break word. (conflict with list)
" set list                          " We use syntax highlight for spaces
" set listchars=tab:\|-,trail:-     " Highlight problematic whitespace
" set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set ruler
" set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
set showcmd
set noshowmatch                     " do not jump cursor
scriptencoding utf-8
set matchpairs+=‘:’,“:”,（:）,【:】,《:》   " Match, to be used with %,
scriptencoding
set mouse=a
set mousehide
set viewoptions=folds,options,cursor,unix,slash " *nix/windows compatible

if has('statusline')
    set laststatus=2            " Use airline for statusline.
    " Broken down into easily include-able segments
    " set statusline=%<%f\                     " Filename
    " set statusline+=%w%h%m%r                 " Options
    " set statusline+=%{vimcaps#statusline(1)}
    " set statusline+=%{fugitive#statusline()} " Git Hotness
    " set statusline+=\ [%{&ff}/%Y]            " Filetype
    " set statusline+=\ [%{getcwd()}]          " Current dir
    " set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" set nowrap                    " Wrap long lines
" set scrolljump=1              " smooth scroll
set scrolloff=1
set foldenable                  " Auto fold code
set foldlevel=100

set autoindent
set smartindent
set expandtab                   " Tabs are spaces, not tabs
set shiftwidth=4                " Use indents of 4 spaces
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set backspace=indent,eol,start  " Backspace for dummies
set nojoinspaces
set splitright
" set splitbelow

" set winminheight=0            " Windows can be 0 line high
" set linespace=0               " No extra spaces between rows
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of completing
set wildmode=list:longest,full  " Command <Tab> completion
                                " list matches, then longest common, then all.
set whichwrap=b,s,<,>,[,]       " Backspace and cursor keys wrap too

set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pdf,.un~
set wildignore+=*.o,*.obj,*.swp,*.bak,*~


" # Common end }}}

" if exists("g:vimrc_local_loaded")
"     finish
" endif
" let g:vimrc_local_loaded = 1

if isdirectory(expand('~/.vim'))            " use ~/.vim by default.
    let localrtp='~/.vim/'
elseif isdirectory(expand("~/vimfiles"))
    let localrtp='~/vimfiles/'
endif
exec "set viminfo+=n".localrtp."viminfo"

let manager = "vam"    " pathogen or vundle or vam, I prefer vam
" # Plugins: {{{
" #########################################################################
if manager == "vundle"
    " TODO, auto install vundle if not exist.
    " set up vundle environment
    filetype off
    exec 'set rtp+='.localrtp.'bundle/vundle'

    call vundle#rc()

    " plugins under vundle
    Bundle 'gmarik/vundle'
    if filereadable(expand(localrtp).'vimrc.vundle.vim')
        execute "source ".localrtp.'vimrc.vundle.vim'
    endif
" #########################################################################
elseif manager == "vam"
    let addon_dir = localrtp.'addons/'      " addons go here
    if !isdirectory(expand(addon_dir))
        call mkdir(expand(addon_dir))
    endif
    let vam_dir = addon_dir.'github-MarcWeber-vim-addon-manager/'
    if !isdirectory(expand(vam_dir))
        if executable('git')
            exec '!git clone https://github.com/MarcWeber/vim-addon-manager.git '.expand(vam_dir)
        else " TODO: if failed, we should break or try another way.
            echo 'Auto install failed, please install vam manually to '.expand(vam_dir)
        endif
    endif
    exec 'set rtp+='.expand(vam_dir)
    call vam#ActivateAddons(['github:MarcWeber/vim-addon-manager'])
    let loadPlugin = 1
    " let loadPlugin = 0 | call vam#ActivateAddons([''])    " test plugin .
    if loadPlugin == 1 && filereadable(expand(localrtp).'vimrc.vam.vim')
        execute "source ".localrtp.'vimrc.vam.vim'
    endif
" #########################################################################
elseif manager == "pathogen"
    exec 'set rtp+='.localrtp.'pathogen'
    call pathogen#infect()
endif
" Plugin end }}}

filetype plugin indent on


" #########################################################################
function! ToDesktop()
    if has('win32') || has('win64') || has('win32unix')
        let regsz = system('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop')
        let desktop = split(regsz)[-1]
    elseif executable('xdg-user-dir')
        let desktop = system('xdg-user-dir DESKTOP')
    else
        let desktop = expand($HOME)
    endif
        cd `=desktop`
endfunction

" If buffer modified, update any 'Last Modified:' in the first 20 lines.
" 'Last Modified: ' can have up to 10 characters before (they are retained).
" Restores cursor and window position using save_cursor variable.
" ('%a %b %d, %Y  %I:%M%p')
function! LastModified()
  if &modified && exists("*strftime")
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}Last \%(Modified\|Change\):\s*\).*#\1' . strftime('%Y-%m-%d %H:%M:%S') . '#e'
    call histdel('search', -1)      " Can we delete this in undo?
    call setpos('.', save_cursor)
  endif
endfun

" syntax region function from vim wikia
function! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
    let ft=toupper(a:filetype)
    let group='textGroup'.ft
    if exists('b:current_syntax')
        let s:current_syntax=b:current_syntax
        " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
        " do nothing if b:current_syntax is defined.
        unlet b:current_syntax
    endif
    execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
    try
        execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
    catch
    endtry
    if exists('s:current_syntax')
        let b:current_syntax=s:current_syntax
    else
        unlet b:current_syntax
    endif
    execute 'syntax region textSnip'.ft.' matchgroup='.a:textSnipHl.' start="'.a:start.'" end="'.a:end.'" contains=@'.group
endfunction

function! HighListing()
    " seems don't work. - -b
    let lsts = '\\begin{lstlisting}'
    let lste = '\\end{lstlisting}'
    call TextEnableCodeSnip('c', lsts.'\[.*language=.*\<C,\]', lste, 'SpecialComment')
    call TextEnableCodeSnip('c', lsts, lste, 'SpecialComment')
endfunction

" Autocmd {{{
augroup vimrcEx
au!
autocmd Colorscheme,Syntax *
    \ syn match BadWhitespace /\s\+$\|\t/ containedin=ALL |
    \ if &background=='dark' |
    \     highlight BadWhitespace ctermbg=DarkGrey guibg=Black |
    \ else |
    \     highlight BadWhitespace ctermbg=DarkGrey guibg=LightCyan |
    \ endif
autocmd InsertEnter * set norelativenumber " noimd
autocmd InsertLeave * set relativenumber " imd
autocmd BufWritePre * call LastModified()
" autocmd FileType tex call HighListing()       " does not work?
autocmd FileType text setlocal textwidth=76 cc=+2
if has("autocmd") && exists("+omnifunc")
    autocmd FileType *
        \ if &omnifunc == "" |
        \    setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
endif
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \     exe "normal! g`\"" |
    \ endif
autocmd BufRead *.nfo set nonu nornu ambw=single gfn=consolas:h8
autocmd VimEnter * set imi=0              " TODO: need a better way.
augroup END
" Autocmd end }}}

if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

set swapfile
if has("persistent_undo")
    " set undodir=tmp
    " let &undodir=localrtp."tmp"
    set undofile
    " set undolevels=1000
    " set undoreload=10000
endif
if &undofile == 1 || has("vms")
    set nobackup
else
    set backup
endif

syntax on
" color molokai
color desert

if has('multi_byte_ime')
    " highlight Cursor guifg=NONE guibg=Green
    highlight CursorIM guifg=NONE guibg=Magenta
endif

set tags=./tags;,./.tags;,tags,.tags,~/.tags

let usetags = ['tcc64']
if has("win32") || has("win64")
    if count(usetags, 'tcc64')
        set tags+=D:\Apps\PortableGit\tcc64\include\tags
    endif
    if count(usetags, 'tcc32')
        set tags+=D:\Apps\PortableGit\tcc32\include\tags
    endif
    if count(usetags, 'cl')     " - =
        set tags+=D:\Apps\Microsoft\\\ Visual\\\ Studio\\\ 12.0\VC\include\tags
        set tags+= C:\Program\\\ Files\\\ (x86)\Windows\\\ Kits\*\include\tags
    endif
    if count(usetags, 'gcc64')  " too large thus slow
        set tags+= D:\Apps\MSYS2x64\mingw64\x86_64-w64-mingw32\include\tags
    endif
    if count(usetags, 'gcc32')  " too large
        set tags+= D:\Apps\MSYS2x64\mingw32\i686-w64-mingw32\include\tags
    endif
elseif has("win32unix")
    if count(usetags, 'tcc64')
        set tags+=/tcc64/include/tags
    endif
    if count(usetags, 'tcc32')
        set tags+=/tcc32/include/tags
    endif
    if count(usetags, 'cl')
    endif
    if count(usetags, 'gcc64')  " too large
        set tags+=/mingw64/x86_64-w64-mingw32/include/tags
    endif
    if count(usetags, 'gcc32')  " too large
        set tags+=/mingw32/i686-w64-mingw32/include/tags
    endif
endif

" set vbs=1     " debug

" Map {{{
map Q gq
nnoremap Y y$
inoremap <C-U> <C-G>u<C-U>
nmap <F2> :update<CR>
imap <F2> <C-O>:update<CR>
nmap <F4> :q<CR>
nmap <Up> gk
nmap <Down> gj
vnoremap < <gv
vnoremap > >gv
vnoremap . :normal .<CR>
cnoremap %% <C-R>=expand('%:h').'/'<CR>
cmap `g. lcd %:p:h<CR>:pwd<CR>
cmap `gd call ToDesktop()<CR>:pwd<CR>
cmap `gh lcd ~<CR>:pwd<CR>
" map <F12> :!ctags -R --c++-kinds=+p --fields=+ialS --extra=+q .<CR>
" Map end }}}
" #########################################################################

