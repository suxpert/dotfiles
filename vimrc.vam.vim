" #########################################################################
"  File Info:   LiTuX's personal vim plugin configuration file
"               Sexy plugins managed by "VAM" for better vimming.
"
"  Last Change: 2014-02-17 20:44:07
"
"  ReadMe:      Please refer to the vimrc file.
"               In this file, we use "VAM" for plugin management.
"               NOTE that the name in vam of those plugins sometimes change.
" #########################################################################

" Some plugins provide similar functions (completion, snippets et al.),
" and might have confliction, choose one will be OK.
let comppets = ['neo']      " snip, ycm, acp, neo, xpt; TODO, neo is slow.
let texengine = 'xelatex'   " or lualatex or pdflatex
let pdfviewer = 'sumatra'   " or evince or mupdf or AcroRd32


let addons = []
" #########################################################################
" Universal
let addons += ['github:suxpert/vimcaps']    " my capslock plugin. :)
let addons += ['surround']                  " tpope/vim-surround
let addons += ['abolish']                   " tpope/vim-abolish
let addons += ['unimpaired']                " tpope/vim-unimpaired
let addons += ['commentary']                " tpope/vim-commentary
let addons += ['repeat']                    " tpope/vim-repeat
let addons += ['fugitive']                  " tpope/vim-fugitive
let addons += ['matchit.zip']
let addons += ['LargeFile']
" matchparen++, there's a bug in this plugin about ruler length...
let addons += ['matchparen']
" let addons += ['vim-multiedit']           " hlissner/vim-multiedit
let addons += ['vim-multiple-cursors']      " terryma/...
let addons += ['EasyMotion']                " Lokaltog/vim-easymotion
" : let g:EasyMotion_leader_key=','         " default is <leader><leader>
" let addons += ['github:oblitum/rainbow']  " fork of luoChen's, too slow
" : let g:rainbow_active = 1
" : let g:rainbow_operators = 1
let addons += ['Rainbow_Parentheses_Improved']  " luochen1990/rainbow, #4176
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
\       ['<\a\w*\%(\_s*\| \_[^>]*\%(\/\)\@1<!\)>', '</\a\w*>'],
\       ] + enpairs,
\   }
: let g:rainbow_conf.separately['xhtml'] = {
\   'parentheses': [
\   [   '<\%('.xhtml_ignore.'\)\@!\a\w*\%(\_s*\| \_[^>]*\%(\/\)\@1<!\)>',
\       '</\%('.xhtml_ignore.'\)\@!\a\w*>'
\           ],
\       ] + enpairs,
\   }
: let g:rainbow_conf.separately['html'] = {
\   'parentheses': [
\   [   '<\%('.html_ignore.'\)\@!\a\w*\%(\_s*\| \_[^>]*\%(\/\)\@1<!\)>',
\       '</\%('.html_ignore.'\)\@!\a\w*>'
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
\   [   '\\begin{\%('.tex_ignore.'\)\@![^}]*}',
\       '_\\item\|\\bibitem_',
\       '\\end{\%('.tex_ignore.'\)\@![^}]*}'
\           ],
\       ['\\left\\\{,1}.','\\right\\\{,1}.'],
\       ['\\langle', '\\rangle'],
\       ['(',')'], ['\[','\]'],
\       ] + zhpairs,
\   }

let addons += ['DirDiff']                   " script #102
let addons += ['The_NERD_tree']             " scrooloose/nerdtree
let addons += ['ctrlp']                     " kien/ctrlp.vim
: let g:ctrlp_cache_dir = '~/.vim/.cache/ctrlp'
: let g:ctrlp_map = '<c-p>'
: let g:ctrlp_cmd = 'CtrlP'
: let g:ctrlp_working_path_mode = 'ra'
: let g:ctrlp_extensions = ['funky']
let addons += ['ctrlp-funky']               " tacahiroy/ctrlp-funky
: nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
: nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

let addons += ['vim-airline']               " bling/vim-airline
" : let g:airline_section_warning = '%{vimcaps#statusline(1)}'
: scriptencoding utf8
" : let g:airline_left_sep = '»' '▶'
" : let g:airline_right_sep = '«' '◀'
: let g:airline_symbols = {}
" : let g:airline_symbols.branch = '⎇'
" : let g:airline_symbols.paste = 'ρ' 'Þ' '∥'
: let g:airline_symbols.whitespace = 'Ξ'
scriptencoding

let addons += ['Solarized']                 " altercation/--solarized
let addons += ['molokai']                   " tomasr/molokai, slant
" let addons += ['monokai']                 " lsdr/monokai, not good

" #########################################################################
" Completion, NOTE there are conflictions between those plugins.
" let addons += ['SuperTab']                " ervandew/supertab

if count(comppets, 'snip')                  " snipmate-like
    if has('python') || has('python3')
        " let addons += ['UltiSnips']       " LaunchPad: SirVer/ultisnips
        let addons += ['github:MarcWeber/ultisnips']
        : let g:UltiSnipsJumpForwardTrigger="<tab>"
        : let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
    else
        " let addons += ['snipmate']        " MarcWeber, VAM messed them up
        let addons += ['snipMate']          " garbas/vim-snipmate
    endif
endif
if count(comppets, 'ycm')                   " YouCompleteMe
    if has('python') && executable('clang') " TODO
        let addons += ['YouCompleteMe']     " Valloric/YouCompleteMe
    endif
endif
if count(comppets, 'acp')                   " AutoComplPop
    " let addons += ['L9']                  " dependence of AutoComplPop?
    let addons += ['AutoComplPop']          " ms9tks/vim-autocomplpop
endif
if count(comppets, 'neo')                   " neocomplcache
    if has('lua')
        let addons += ['neocomplete']       " Shougo/neocomplete.vim
        : let g:neocomplete#enable_at_startup = 1
        : let g:neocomplete#enable_smart_case = 1
        : let g:neocomplete#sources#syntax#min_keyword_length = 3
        : let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
    else
        let addons += ['neocomplcache']     " Shougo/neocomplcache.vim
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
        " : let g:neocomplcache_min_syntax_length = 4           " 4 is default
        : let g:neocomplcache_auto_completion_start_length = 4
        : let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
        " : let g:neocomplcache_enable_camel_case_completion = 1
        " : let g:neocomplcache_enable_underbar_completion = 1
    endif
    let addons += ['neosnippet']            " Shougo/neosnippet
    " let addons += ['neosnippet-snippets'] " Shougo/neosnippet-snippets
    " : let g:neosnippet#disable_runtime_snippets = 1
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
if count(comppets, 'xpt')                   " xptemplate
    let addons += ['xptemplate']            " drmingdrmer/xptemplate
endif
" ##### More snippets ############################################
let addons += ['vim-snippets']              " honza/vim-snippets

" C-function complete using ctags.
let addons += ['vim-misc']                  " dependence of easytags
let addons += ['shell']                     " xolox/vim-shell
let addons += ['easytags']                  " xolox/vim-easytags
: let g:easytags_auto_highlight = 0         " Makes movement slow
: let g:easytags_dynamic_files = 1
: let g:easytags_include_members = 1
: let g:easytags_events = ['BufWritePost']
if has("win32") || has("win64") || has("win32unix")
: let g:easytags_file=expand('~/.vim/$USERNAME.tags')
else
: let g:easytags_file=expand('~/.vim/$USER.tags')   " sudo issue.
endif
" let addons += ['TagHighlight']              " hg:abudden/taghighlight
let addons += ['undotree']                  " mbbill/undotree
" let addons += ['github:mbbill/fencview']
" : let g:fencview_autodetect = 1
let addons += ['echofunc']                  " mbbill/echofunc
: let g:EchoFuncPathMappingEnabled = 7
: let g:EchoFuncAutoStartBalloonDeclaration = 1
let addons += ['code_complete']             " mbbill/code_complete
: let g:rs='<+'
: let g:re='+>'
: let g:completekey='<C-B>'                 " should use superTab.

" C-member complete using ctags.
let addons += ['OmniCppComplete']           " script #1520
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
" let addons += ['project.tar.gz']          " don't know which is better
let addons += ['Syntastic']                 " scrooloose/syntastic
let addons += ['a']                         " script #31

let addons += ['DoxygenToolkit']            " script #987

" let addons += ['The_NERD_Commenter']      " scrooloose/nerdcommenter

" html/js/css
let addons += ['Emmet']                     " mattn/emmet-vim
let addons += ['Colorizer']                 " chrisbra/color_hightlight
: let g:colorizer_auto_filetype="css,html,xhtml"
: let g:colorizer_colornames=1
" let addons += ['colorizer']               " lilydjwg/colorizer
let addons += ['MatchTag']                  " gregsexton/MatchTag
" let addons += ['MatchTagAlways']          " a modified version
let addons += ['jsbeautify']                " script #2727

" LaTeX editing
let addons += ['LaTeX-Suite_aka_Vim-LaTeX'] " vim-latex.sf.net
: let g:tex_flavor=texengine
: let g:Tex_MultipleCompileFormats='pdf'
: let g:Tex_DefaultTargetFormat='pdf'
: let g:Tex_CompileRule_pdf=texengine.' -interaction=nonstopmode -file-line-error-style $*'
: let g:Tex_ViewRule_pdf=pdfviewer
" : set grepprg=grep\ -nH\ $*
" : if has('win32') || has('win64')
" :     set shellslash                      " will break vam, git...
" : endif


" #########################################################################
" Finally
call vam#ActivateAddons(addons, {'auto_install': 0})

