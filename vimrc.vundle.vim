" #########################################################################
"  File Info:   LiTuX's personal vim plugin configuration file
"               Sexy plugins managed by "vundle" for better vimming.
"
"  Last Change: 2014-04-11 14:19:16
"
"  ReadMe:      Please refer to the vimrc file.
"               In this file, we use "vundle" for plugin management.
"               This file is not tested! (I'm using vam)
" #########################################################################

" Some plugins provide similar functions (completion, snippets et al.),
" and might have confliction, choose one will be OK.
let s:comppets = ['neo']        " snip, ycm, acp, neo, xpt; neo is slow.
let s:texengine = 'xelatex'     " or lualatex or pdflatex
let s:pdfviewer = 'sumatra'     " or evince or mupdf or AcroRd32


" #########################################################################
" Universal
Bundle 'suxpert/vimcaps'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
Bundle 'suxpert/GitGutter'
Bundle 'matchit.zip'
Bundle 'LargeFile'
" matchparen++, there's a bug in this plugin about ruler length...
Bundle 'matchparen'
" Bundle 'hlissner/vim-multiedit'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'Lokaltog/vim-easymotion'
" : let g:EasyMotion_leader_key=','         " default is <leader><leader>
" Bundle 'oblitum/rainbow'                  " fork of luoChen's, too slow
" : let g:rainbow_active = 1
" : let g:rainbow_operators = 1
Bundle 'luochen1990/rainbow'
: let g:rainbow_active = 1
" GUI usually can use any color, so we devide a color circle into parts:
" 5-based circle, use order: 24130(mod 5); for 6-based, use 241-530(mod 6)
" A standard color wheel or rainbow can be obtained via: (3: RGB)
"   R 255,      G 0->255,   B 0;        #FF0000->#FF4000->#FF8000->#FFC000->
"   R 255->0,   G 255,      B 0;        #FFFF00->#C0FF00->#80FF00->#40FF00->
"   R 0,        G 255,      B 0->255;   #00FF00->#00FF40->#00FF80->#00FFC0->
"   R 0,        G 255->0,   B 255;      #00FFFF->#00C0FF->#0080FF->#0040FF->
"   R 0->255,   G 0,        B 255;      #0000FF->#4000FF->#8000FF->#C000FF->
"   R 255,      G 0,        B 255->0;   #FF00FF->#FF00C0->#FF0080->#FF0040->
" I'll use the Munsell color wheel (5-based):
" #F0EA00, #B1D700, #00CA24, #00A877,   #EE3338, #F26C36, #F89734, #FFC32D,
" #00A78A, #00A59C, #00A3AC, #0093AF,   #FFF215, #CCDC3C, #90C84B, #47B754,
" #0082B2, #006EBD, #7D00F8, #9F00C5,   #00A85A, #008F71, #007683, #2A5D8F,
" #B900A6, #D00081, #E20064, #F2003C,   #3F4096, #6D3D94, #953993, #BE3291,
" #F85900, #F28800, #F2AB00, #EFCC00,   #ED2790, #ED2B78, #EE2F62, #EE324C,
" cterm colors: DarkRed, Brown, DarkGreen, DarkCyan, DarkBlue, DarkMagenta;
" (Black Gray) Red, Yellow, Green, Cyan, Blue, Magenta; (DarkGray, White)
: let munsell5 = ['#00EA42', '#E700F8', '#FECC00', '#00A3EA', '#E20064']
: let basic5 = ['DarkCyan','DarkMagenta','DarkGreen','DarkBlue','DarkRed']
: let enpairs = [ ['(',')'], ['\[','\]'], ['{','}'], ]
: scriptencoding utf-8                  " For utf8 characters.
: let zhpairs = [['（','）'],['【','】'],['“','”'],['‘','’'],['《','》'],]
: scriptencoding
: let separators = ',\|;'
: let operators = '&&\|||\|==\|!=\|>=\|<='
: let xhtml_ignore = '\<script\>\|\<style\>'    " prevent highlight errors
: let html_ignore = xhtml_ignore.'\|\<area\>\|\<base\>\|\<br\>\|\<col\>\|\<embed\>\|\<hr\>\|\<img\>\|\<input\>\|\<link\>\|\<meta\>\|\<param\>\|\<source\>'
: let tex_ignore = '\<equation\>\|\<eqnarray\>\|\<multline\>\|\<split\>\|\<gather\>\|\<align\>\|\<verbatim\>'
: let g:rainbow_conf = {
\   'guifgs': munsell5,
\   'ctermfgs': basic5,
\   'operators': '_'.separators.'\|'.operators.'_',
\   'parentheses': zhpairs + enpairs,
\   'separately': { '*': {}, }
\   }
: let g:rainbow_conf.separately['xml'] = {
\   'parentheses': [
\       ['<\z(\a\w*\)\%(\_s*\| \_[^>]*\%(\/\)\@1<!\)>', '</\z1>'],
\       ] + enpairs,
\   }
: let g:rainbow_conf.separately['xhtml'] = {
\   'parentheses': [
\   [   '<\z(\%('.xhtml_ignore.'\)\@!\a\w*\)\%(\_s*\| \_[^>]*\%(\/\)\@1<!\)>',
\       '</\z1>'
\           ],
\       ] + enpairs,
\   }
: let g:rainbow_conf.separately['html'] = {
\   'parentheses': [
\   [   '<\z(\%('.html_ignore.'\)\@!\a\w*\)\%(\_s*\| \_[^>]*\%(\/\)\@1<!\)>',
\       '</\z1>'
\           ],
\       ] + enpairs,
\   }
: let g:rainbow_conf.separately['vim'] = {
\   'parentheses': [
\       ['\<fu\%[nction][!]\{,1}\ze\s\+.*)', '\<endf\%[unction]\>'],
\       ['\<for\>', '\<endfo\%[r]\>'],
\       ['\<wh\%[ile]\>', '\<endw\%[hile]\>'],
\       ['\<if\>', '_\<elsei\%[f]\>\|\<el\%[se]\>_', '\<en\%[dif]\>'],
\       ['\<try\>', '_\<cat\%[ch]\>\|\<fina\%[lly]\>_', '\<endt\%[ry]\>'],
\       ] + enpairs,
\   }
: let g:rainbow_conf.separately['tex'] = {
\   'parentheses': [
\   [   '\\begin{\z(\%('.tex_ignore.'\)\@![^}]*\)}',
\       '_\\item\|\\bibitem_',
\       '\\end{\z1}'
\           ],
\       ['\\left\\\{,1}.','\\right\\\{,1}.'],
\       ['\\langle', '\\rangle'],
\       ] + enpairs + zhpairs,
\   }

Bundle 'DirDiff'                    " script #102
Bundle 'scrooloose/nerdtree'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'
Bundle 'Shougo/unite.vim'
Bundle 'kien/ctrlp.vim'
: let g:ctrlp_cache_dir = '~/.vim/.cache/ctrlp'
: let g:ctrlp_map = '<c-p>'
: let g:ctrlp_cmd = 'CtrlP'
: let g:ctrlp_working_path_mode = 'ra'
: let g:ctrlp_extensions = ['funky']
Bundle 'tacahiroy/ctrlp-funky'
: nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
: nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

Bundle 'bling/vim-airline'
: let g:airline#extensions#vimcaps#enabled = 1  " I've modified airline.
" : let g:airline#extensions#tabline#enabled = 1
" : let g:airline#extensions#tabline#left_sep = ' '
: let g:airline#extensions#tabline#left_alt_sep = '|'
" : let g:airline_section_warning = '%{vimcaps#statusline(1)}'
: scriptencoding utf8
" : let g:airline_left_sep = '»' '▶'
" : let g:airline_right_sep = '«' '◀'
: let g:airline_symbols = {}
" : let g:airline_symbols.branch = '⎇'
" : let g:airline_symbols.paste = 'ρ' 'Þ' '∥'
: let g:airline_symbols.whitespace = 'Ξ'    " U+2591: ░ U+2592: ▒ ▓
scriptencoding

Bundle 'altercation/vim-colors-solarized'
Bundle 'tomasr/molokai'
" Bundle 'lsdr/monokai'

" #########################################################################
" Completion, NOTE there are conflictions between those plugins.
" Bundle 'ervandew/supertab'

if count(s:comppets, 'snip')                " snipmate-like
    if has('python') || has('python3')
        " Bundle 'SirVer/ultisnips'
        Bundle 'MarcWeber/ultisnips'
        : let g:UltiSnipsJumpForwardTrigger="<tab>"
        : let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
    else
        " Bundle 'MarcWeber/snipmate.vim'
        Bundle 'garbas/vim-snipmate'
    endif
endif
if count(s:comppets, 'ycm')                 " YouCompleteMe
    if has('python') && executable('clang') " TODO
        Bundle 'Valloric/YouCompleteMe'
    endif
endif
if count(s:comppets, 'acp')                 " AutoComplPop
    " Bundle 'L9'                  " dependence of AutoComplPop?
    Bundle 'ms9tks/vim-autocomplpop'
endif
if count(s:comppets, 'neo')                 " neocomplcache
    if has('lua')
        Bundle 'Shougo/neocomplete.vim'
        : let g:neocomplete#enable_at_startup = 1
        : let g:neocomplete#enable_smart_case = 1
        : let g:neocomplete#sources#syntax#min_keyword_length = 3
        : let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
    else
        Bundle 'Shougo/neocomplcache.vim'
        " It makes vim much slower.
        : let g:neocomplcache_max_list = 20
        : let g:neocomplcache_disable_auto_complete = 1
        " : so ~/.vim/neocomp.cfg.vim
        " : inoremap <expr><C-g>     neocomplcache#undo_completion()
        : inoremap <expr><C-l>     neocomplcache#complete_common_string()
        " : inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " : inoremap <expr><C-y>  neocomplcache#close_popup()
        " : inoremap <expr><C-e>  neocomplcache#cancel_popup()
        : let g:neocomplcache_temporary_dir = '~/.vim/.cache/'
        : let g:neocomplcache_enable_at_startup = 1
        : let g:neocomplcache_enable_smart_case = 1
        " : let g:neocomplcache_min_syntax_length = 4       " 4 is default
        : let g:neocomplcache_auto_completion_start_length = 4
        : let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
        " : let g:neocomplcache_enable_camel_case_completion = 1
        " : let g:neocomplcache_enable_underbar_completion = 1
    endif
    Bundle 'Shougo/neosnippet'
    " Bundle 'Shougo/neosnippet-snippets'
    : let g:neosnippet#disable_runtime_snippets = {'_': 1}
    : let g:neosnippet#enable_snipmate_compatibility = 1
    : let g:neosnippet#snippets_directory='~/.vim/addons/vim-snippets/snippets/'
    " Plugin key-mappings.
    " : imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    " : smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    " : xmap <C-k>     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    : imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)"
                \ : "\<TAB>"
                " \ : pumvisible() ? "\<C-n>" : "\<TAB>"
    : smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)"
                \ : "\<TAB>"
endif
if count(s:comppets, 'xpt')                 " xptemplate
    Bundle 'drmingdrmer/xptemplate'
endif
" ##### More snippets ############################################
Bundle 'honza/vim-snippets'

" C-function complete using ctags.
Bundle 'xolox/vim-misc'                  " dependence of easytags
Bundle 'xolox/vim-shell'
Bundle 'xolox/vim-easytags'
" Do NOT use HighlightTags command!! Too slow!!
: let g:easytags_auto_highlight = 0         " Makes movement slow
: let g:easytags_dynamic_files = 3          " I've modified easytags
: let g:easytags_dynamic_tag = './tags;'
: let g:easytags_include_members = 1
: let g:easytags_events = ['BufWritePost']
if has("win32") || has("win64") || has("win32unix")
: let g:easytags_file=expand('~/.vim/$USERNAME.tags')
else
: let g:easytags_file=expand('~/.vim/$USER.tags')   " sudo issue.
endif
" ActivateAddons TagHighlight               " hg:abudden/taghighlight
ActivateAddons undotree                     " mbbill/undotree
" ActivateAddons github:mbbill/fencview
" : let g:fencview_autodetect = 1
ActivateAddons echofunc                     " mbbill/echofunc
: let g:EchoFuncPathMappingEnabled = 7
: let g:EchoFuncAutoStartBalloonDeclaration = 1
Bundle 'mbbill/code_complete'
: let g:rs='<`'
: let g:re='`>'
: let g:completekey='<C-B>'                 " should use superTab.

" C-member complete using ctags.
Bundle 'OmniCppComplete'           " script #1520
" au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
: let OmniCpp_NamespaceSearch = 1
: let OmniCpp_GlobalScopeSearch = 1
: let OmniCpp_ShowAccess = 1
: let OmniCpp_ShowPrototypeInAbbr = 1       " show function parameters
: let OmniCpp_MayCompleteDot = 1            " autocomplete after .
: let OmniCpp_MayCompleteArrow = 1          " autocomplete after ->
: let OmniCpp_MayCompleteScope = 1          " autocomplete after ::
: let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" #########################################################################
" Programing
" Bundle 'project.tar.gz'          " don't know which is better
Bundle 'scrooloose/syntastic'
Bundle 'a'                         " script #31

Bundle 'DoxygenToolkit'            " script #987

" Bundle 'scrooloose/nerdcommenter'

" html/js/css
Bundle 'mattn/emmet-vim'
Bundle 'chrisbra/color_hightlight'
: let g:colorizer_auto_filetype="css,html,xhtml"
: let g:colorizer_colornames=1
" Bundle 'lilydjwg/colorizer'
Bundle 'gregsexton/MatchTag'
" if has("python")
"     ActivateAddons Valloric/MatchTagAlways  " a modified version
" endif
Bundle 'jsbeautify'                " script #2727

" LaTeX editing
Bundle 'LaTeX-Suite_aka_Vim-LaTeX' " vim-latex.sf.net TODO
: let g:Imap_PlaceHolderStart='<`'          " compatible with snippets
: let g:Imap_PlaceHolderEnd='`>'
" : let g:Imap_StickyPlaceHolders=1         " don't work?
" : let g:Imap_DeleteEmptyPlaceHolders=0
: let g:tex_flavor=s:texengine
: let g:Tex_MultipleCompileFormats='pdf'
: let g:Tex_DefaultTargetFormat='pdf'
: let g:Tex_CompileRule_pdf=s:texengine.' -interaction=nonstopmode -file-line-error-style $*'
: let g:Tex_ViewRule_pdf=s:pdfviewer
" : set grepprg=grep\ -nH\ $*
" : if has('win32') || has('win64')
" :     set shellslash                      " will break vam, git...
" : endif

" #########################################################################
" EOF

