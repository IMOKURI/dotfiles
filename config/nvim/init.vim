set encoding=utf-8
scriptencoding utf-8

" -----------------------------------------------------------------------------
" Detect platform
" -----------------------------------------------------------------------------
if !exists('g:env')
    if has('win64') || has('win32')
        let g:env = 'WINDOWS'
    else
        let g:env = toupper(substitute(system('uname'), '\n', '', ''))
    endif
endif

" -----------------------------------------------------------------------------
" Determine XDG base directory
" -----------------------------------------------------------------------------
if g:env =~# 'WINDOWS'
    set shellslash
endif

if empty($XDG_CONFIG_HOME)
    if g:env =~# 'LINUX'
        let $XDG_CONFIG_HOME = expand('~/.config')
    elseif g:env =~# 'WINDOWS'
        let $XDG_CONFIG_HOME = expand('~/AppData/Local')
    endif
endif

if empty($XDG_DATA_HOME)
    if g:env =~# 'LINUX'
        let $XDG_DATA_HOME = expand('~/.local/share')
    elseif g:env =~# 'WINDOWS'
        let $XDG_DATA_HOME = expand('~/AppData/Local')
    endif
endif

" -----------------------------------------------------------------------------
" Provider settings
" -----------------------------------------------------------------------------
let s:provider_dir = $XDG_DATA_HOME . '/provider.nvim'

if g:env =~# 'LINUX'
    let g:python3_host_prog = s:provider_dir . '/.venv/bin/python'
    let g:node_host_prog = expand('~/node_modules/.bin/neovim-node-host')

    let g:loaded_python_provider = 0
    let g:loaded_ruby_provider = 0

elseif g:env =~# 'WINDOWS'
    let g:python3_host_prog = s:provider_dir . '/.venv/Scripts/python'

    let g:loaded_node_provider = 0
    let g:loaded_python_provider = 0
    let g:loaded_ruby_provider = 0

endif

" -----------------------------------------------------------------------------
" Plugin settings
" -----------------------------------------------------------------------------
if has('nvim')
    let s:dein_dir = $XDG_DATA_HOME . '/dein/nvim'
else
    let s:dein_dir = $XDG_DATA_HOME . '/dein/vim'
endif
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . s:dein_repo_dir
endif

if !exists('g:mapleader')
    nnoremap <Space> <Nop>
    let g:mapleader = "\<Space>"
endif

call dein#begin(s:dein_dir)

" Plugin Manager
call dein#add('Shougo/dein.vim')
call dein#add('wsdjeg/dein-ui.vim')

" Color Scheme
call dein#add('challenger-deep-theme/vim')

" Git
function! s:airblade_vim_gitgutter() abort
    " let g:gitgutter_highlight_linenrs = 1
    let g:gitgutter_diff_args = '-w'

    nmap <Leader>ga <Plug>(GitGutterStageHunk)
    nmap <Leader>gp <Plug>(GitGutterPreviewHunk)
endfunction

call dein#add('airblade/vim-gitgutter', {
    \ 'hook_source': function('s:airblade_vim_gitgutter')
    \ })

call dein#add('tpope/vim-fugitive')

" Project
function! s:airblade_vim_rooter() abort
    let g:rooter_change_directory_for_non_project_files = 'current'
    let g:rooter_patterns = ['.git', '.git/']
endfunction

call dein#add('airblade/vim-rooter', {
    \ 'hook_add': function('s:airblade_vim_rooter')
    \ })

" Highlight
function! s:t9md_vim_quickhl() abort
    nmap <silent> <Leader>m <Plug>(quickhl-manual-this)
    xmap <silent> <Leader>m <Plug>(quickhl-manual-this)
    nnoremap <silent> <Leader>M :<C-u>QuickhlManualReset<CR>
endfunction

call dein#add('t9md/vim-quickhl', {
    \ 'hook_add': function('s:t9md_vim_quickhl')
    \ })

call dein#add('itchyny/vim-cursorword')

call dein#add('Shougo/context_filetype.vim')

call dein#add('mechatroner/rainbow_csv', {
    \ 'on_ft': 'csv'
    \ })

call dein#add('pearofducks/ansible-vim', {
    \ 'on_ft': 'yaml'
    \ })

call dein#add('martinda/Jenkinsfile-vim-syntax', {
    \ 'on_path': '.*Jenkinsfile'
    \ })

" Utility
function! s:LeafCage_yankround_vim() abort
    let g:yankround_dir = $XDG_DATA_HOME . '/yankround'
    let g:yankround_use_region_hl = 1

    nmap p <Plug>(yankround-p)
    xmap p <Plug>(yankround-p)
    nmap P <Plug>(yankround-P)
    nmap <C-p> <Plug>(yankround-prev)
    nmap <C-n> <Plug>(yankround-next)
endfunction

call dein#add('LeafCage/yankround.vim', {
    \ 'hook_add': function('s:LeafCage_yankround_vim')
    \ })

function! s:LeafCage_vimhelpgenerator() abort
    let g:vimhelpgenerator_defaultlanguage = 'en'
    let g:vimhelpgenerator_gitignore_lines = []
endfunction

call dein#add('LeafCage/vimhelpgenerator', {
    \ 'hook_add': function('s:LeafCage_vimhelpgenerator')
    \ })

call dein#add('haya14busa/is.vim')

function! s:osyo_manga_vim_anzu() abort
    nmap n <Plug>(is-nohl)<Plug>(anzu-n)
    nmap N <Plug>(is-nohl)<Plug>(anzu-N)
    nmap * <Plug>(anzu-star)<Plug>(is-nohl-1)

    augroup Anzu
        autocmd!
        autocmd WinLeave,TabLeave * call anzu#clear_search_status()
    augroup END
endfunction

call dein#add('osyo-manga/vim-anzu', {
    \ 'depends': 'is.vim',
    \ 'hook_add': function('s:osyo_manga_vim_anzu')
    \ })

function! s:lambdalisue_suda_vim() abort
    let g:suda_smart_edit = 1
endfunction

call dein#add('lambdalisue/suda.vim', {
    \ 'on_event': 'BufRead',
    \ 'hook_add': function('s:lambdalisue_suda_vim')
    \ })

function! s:cohama_lexima_vim() abort
    " Japanese Bracket
    call lexima#add_rule({'char': '「', 'input_after': '」'})
    call lexima#add_rule({'char': '」', 'at': '\%#」', 'leave': 1})
    call lexima#add_rule({'char': '<BS>', 'at': '「\%#」', 'delete': 1})

    " Jinja2
    call lexima#add_rule({'char': '%', 'at': '{\%#}', 'input_after': '%'})
    call lexima#add_rule({'char': '%', 'at': '{%\%#%}', 'leave': 2})
    call lexima#add_rule({'char': '}', 'at': '{%\%#%}', 'leave': 2})
    call lexima#add_rule({'char': '<BS>', 'at': '{%\%#%}', 'delete': 1})

    call lexima#add_rule({'char': '<Space>', 'at': '{%\%#%}', 'input_after': '<Space>'})
    call lexima#add_rule({'char': '%', 'at': '{% \%# %}', 'leave': 3})
    call lexima#add_rule({'char': '}', 'at': '{% \%# %}', 'leave': 3})
    call lexima#add_rule({'char': '<BS>', 'at': '{% \%# %}', 'delete': 1})
endfunction

call dein#add('cohama/lexima.vim', {
    \ 'on_event': 'InsertEnter',
    \ 'hook_source': function('s:cohama_lexima_vim')
    \ })

function! s:machakann_vim_sandwich() abort
    nmap s <Nop>
    xmap s <Nop>
endfunction

call dein#add('machakann/vim-sandwich', {
    \ 'hook_add': function('s:machakann_vim_sandwich')
    \ })

call dein#add('tpope/vim-commentary')

function! s:junegunn_vim_easy_align() abort
    nmap ga <Plug>(EasyAlign)
    xmap ga <Plug>(EasyAlign)
endfunction

call dein#add('junegunn/vim-easy-align', {
    \ 'hook_add': function('s:junegunn_vim_easy_align')
    \ })

call dein#add('thiagoalmeidasa/vim-ansible-vault')

call dein#add('dhruvasagar/vim-table-mode')

call dein#add('AndrewRadev/linediff.vim')

function! s:kassio_neoterm() abort
    let g:neoterm_autoscroll = 1
    let g:neoterm_default_mod = 'botright'
    let g:neoterm_repl_python = 'python'

    nnoremap <silent> <C-t> :Ttoggle<CR>
    tnoremap <silent> <C-t> <C-\><C-n>:Ttoggle<CR>

    nnoremap <silent> <C-y> :Topen<CR><C-w>ji
    tnoremap <silent> <C-y> <C-\><C-n><C-w>k

    " nmap <silent> <Leader><CR> <Plug>(neoterm-repl-send-line)
    " xmap <silent> <Leader><CR> <Plug>(neoterm-repl-send)
endfunction

call dein#add('kassio/neoterm', {
    \ 'on_cmd': ['Ttoggle', 'Topen'],
    \ 'hook_add': function('s:kassio_neoterm')
    \ })

" LSP


" Completion
if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
endif

if has('nvim')
    function! s:ncm2_float_preview_nvim() abort
        let g:float_preview#docked = 0
        let g:float_preview#max_width = 60
        let g:float_preview#max_height = 20
    endfunction

    call dein#add('ncm2/float-preview.nvim', {
        \ 'on_source': 'deoplete.nvim',
        \ 'hook_source': function('s:ncm2_float_preview_nvim')
        \ })
endif

function! s:shougo_deoplete_nvim() abort
    call deoplete#custom#var('around', {
        \ 'range_above': 30,
        \ 'range_below': 30,
        \ 'mark_above': '[↑]',
        \ 'mark_below': '[↓]',
        \ 'mark_changes': '[*]',
        \ })

    call deoplete#custom#var('buffer', {
        \ 'require_same_filetype': v:false
        \ })

    call deoplete#custom#var('file', {
        \ 'force_completion_length': 1
        \ })

    call deoplete#custom#option({
        \ 'auto_refresh_delay': 10
        \ })

    call deoplete#custom#source('tabnine', {
        \ 'rank': 100
        \ })

    call deoplete#enable()
endfunction

call dein#add('Shougo/deoplete.nvim', {
    \ 'depends': 'context_filetype.vim',
    \ 'on_event': 'InsertEnter',
    \ 'hook_source': function('s:shougo_deoplete_nvim')
    \ })

function! s:shougo_echodoc_vim() abort
    if has('nvim')
        let g:echodoc#type = 'virtual'
    endif
    call echodoc#enable()
endfunction

call dein#add('Shougo/echodoc.vim', {
    \ 'on_event': 'CompleteDone',
    \ 'hook_source': function('s:shougo_echodoc_vim')
    \ })

if g:env =~# 'WINDOWS'
    call dein#add('tbodt/deoplete-tabnine', {
        \ 'build': 'powershell.exe .\install.ps1'
        \ })
else
    call dein#add('tbodt/deoplete-tabnine', {
        \ 'build': './install.sh'
        \ })
endif

call dein#add('Shougo/neco-syntax')

call dein#add('Shougo/neco-vim', {
    \ 'on_ft': 'vim'
    \ })

call dein#add('deoplete-plugins/deoplete-jedi', {
    \ 'on_ft': 'python'
    \ })

" Linter
function! s:w0rp_ale() abort
    let g:ale_sign_error = 'E>'
    let g:ale_sign_warning = 'W>'
    let g:ale_sign_highlight_linenrs = 1

    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%severity%][%linter%] %s'

    let g:ale_linters = {
        \ 'awk': ['gawk'],
        \ 'json': ['jq'],
        \ 'make': ['checkmake'],
        \ 'python': ['flake8', 'pylint'],
        \ 'sh': ['language_server'],
        \ 'vim': ['vint'],
        \ 'yaml': ['yamllint']
        \ }

    let g:ale_fixers = {
        \ 'json': ['jq'],
        \ 'python': ['autopep8', 'yapf', 'black', 'isort'],
        \ 'sh': ['shfmt'],
        \ 'yaml': ['prettier']
        \ }

    let g:ale_json_jq_options = '--indent 4'
    let g:ale_python_flake8_options = '--ignore=E501'
    let g:ale_python_pylint_options = '--max-line-length=120 --disable=missing-docstring'
    let g:ale_yaml_yamllint_options='-d "{rules: {line-length: disable}}"'

    nmap <silent><expr> <C-p> yankround#is_active() ? "\<Plug>(yankround-prev)" : "\<Plug>(ale_previous_wrap)"
    nmap <silent><expr> <C-n> yankround#is_active() ? "\<Plug>(yankround-next)" : "\<Plug>(ale_next_wrap)"

    nmap <silent> <Leader>x <Plug>(ale_fix)
endfunction

call dein#add('w0rp/ale', {
    \ 'depends': 'yankround.vim',
    \ 'hook_add': function('s:w0rp_ale')
    \ })

" Formatter
call dein#add('Vimjas/vim-python-pep8-indent', {
    \ 'on_event': 'InsertEnter',
    \ 'on_ft': 'python'
    \ })

" Snippet
call dein#add('phenomenes/ansible-snippets')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('honza/vim-snippets')

function! s:Shougo_neosnippet() abort
    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)
    xmap <C-k> <Plug>(neosnippet_expand_target)

    let g:neosnippet#enable_snipmate_compatibility = 1

    let g:neosnippet#snippets_directory = [
        \ $XDG_DATA_HOME . '/dein/repos/github.com/phenomenes/ansible-snippets/snippets',
        \ $XDG_DATA_HOME . '/dein/repos/github.com/honza/vim-snippets/snippets',
        \ $XDG_CONFIG_HOME . '/nvim/neosnippets'
        \ ]
endfunction

call dein#add('Shougo/neosnippet', {
    \ 'depends': ['ansible-snippets', 'neosnippet-snippets', 'context_filetype.vim'],
    \ 'on_event': 'InsertCharPre',
    \ 'on_ft': 'snippet',
    \ 'hook_source': function('s:Shougo_neosnippet')
    \ })

" Status Line
call dein#add('itchyny/lightline.vim')
call dein#add('maximbaz/lightline-ale')

" Launcher
function! s:shougo_denite_nvim_hook_add() abort
    nnoremap <silent> <Leader>b :Denite buffer<CR>
    nnoremap <silent> <Leader>e :DeniteBufferDir file/rec<CR>
    nnoremap <silent> <Leader>f :Denite file/rec<CR>
    nnoremap <silent> <Leader>o :Denite file/old<CR>
    nnoremap <silent> <Leader>g :Denite grep -auto-action=preview<CR>
    nnoremap <silent> <Leader>c :DeniteCursorWord grep -auto-action=preview<CR>
    nnoremap <silent> <Leader>l :Denite line<CR>
    nnoremap <silent> <Leader>` :Denite mark -auto-action=preview<CR>
    nnoremap <silent> <Leader>t :Denite tag -auto-action=preview<CR>
    nnoremap <silent> <Leader>h :Denite menu<CR>

    nnoremap <silent> <Leader>gb :Denite gitbranch<CR>
    nnoremap <silent> <Leader>gg :Denite gitlog<CR>
    nnoremap <silent> <Leader>gs :Denite gitstatus<CR>
    nnoremap <silent> <Leader>gd :Denite gitchanged -auto-action=preview<CR>

    nnoremap <silent> <Leader>s :Denite session<CR>
endfunction

function! s:shougo_denite_nvim_hook_source() abort

    augroup Denite
        autocmd!
        autocmd FileType denite call s:denite_settings()
        autocmd FileType denite-filter call s:denite_filter_settings()
    augroup END

    function! s:denite_settings() abort
        nnoremap <silent><buffer><expr> <CR>
            \ denite#do_map('do_action')
        nnoremap <silent><buffer><expr> t
            \ denite#do_map('do_action', 'tabopen')
        nnoremap <silent><buffer><expr> -
            \ denite#do_map('do_action', 'split')
        nnoremap <silent><buffer><expr> <bar>
            \ denite#do_map('do_action', 'vsplit')
        nnoremap <silent><buffer><expr> p
            \ denite#do_map('do_action', 'preview')
        nnoremap <silent><buffer><expr> d
            \ denite#do_map('do_action', 'delete')
        nnoremap <silent><buffer><expr> <ESC>
            \ denite#do_map('quit')
        nnoremap <silent><buffer><expr> i
            \ denite#do_map('open_filter_buffer')
        nnoremap <silent><buffer><expr> <Space>
            \ denite#do_map('toggle_select').'j'
        nnoremap <silent><buffer><expr> <BS>
            \ denite#do_map('move_up_path')

        " for git status
        nnoremap <silent><buffer><expr> ga
            \ denite#do_map('do_action', 'add')
        nnoremap <silent><buffer><expr> gr
            \ denite#do_map('do_action', 'reset')

        " for session manager
        nnoremap <silent><buffer><expr> sf
            \ denite#do_map('do_action', 'open_force')
        nnoremap <silent><buffer><expr> sr
            \ denite#do_map('do_action', 'remove')

        if exists('&winblend')
            set winblend=20
        endif
    endfunction

    function! s:denite_filter_settings() abort
        nnoremap <silent><buffer><expr> <ESC>
            \ denite#do_map('quit')
    endfunction

    let s:denite_win_width_percent = 0.85
    let s:denite_win_height_percent = 0.7

    call denite#custom#option('_', {
        \ 'highlight_matched_char': 'Underlined',
        \ 'prompt': '>',
        \ 'split': 'floating',
        \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
        \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
        \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
        \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) * 4 / 5),
        \ 'smartcase': 'true',
        \ })

    if executable('rg')
        call denite#custom#var('file/rec', 'command',
            \ ['rg', '--files', '--glob', '!.git'])

        call denite#custom#var('grep', 'command', ['rg'])
        call denite#custom#var('grep', 'default_opts',
            \ ['-i', '--vimgrep', '--no-heading'])
        call denite#custom#var('grep', 'recursive_opts', [])
        call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
        call denite#custom#var('grep', 'separator', ['--'])
        call denite#custom#var('grep', 'final_opts', [])
    endif

    let s:denite_menus = {}

    let s:denite_menus.dotfiles = {
        \ 'description': 'Edit dotfiles'
        \ }
    let s:denite_menus.dotfiles.file_candidates = [
        \ ['init.vim', '~/.dotfiles/config/nvim/init.vim'],
        \ ['my-help-doc', '~/.dotfiles/config/nvim/my-help/doc/my-help.txt'],
        \ ['installer', '~/.dotfiles/install']
        \ ]

    call denite#custom#var('menu', 'menus', s:denite_menus)

endfunction

call dein#add('Shougo/denite.nvim', {
    \ 'depends': ['denite-git', 'session.vim'],
    \ 'on_cmd': ['Denite', 'DeniteBufferDir', 'DeniteCursorWord'],
    \ 'hook_add': function('s:shougo_denite_nvim_hook_add'),
    \ 'hook_source': function('s:shougo_denite_nvim_hook_source')
    \ })

call dein#add('neoclide/denite-git', {
    \ 'on_source': 'denite.nvim'
    \ })

" Session Manager
function! s:lambdalisue_session_vim() abort
    nnoremap ss :SessionSave
endfunction

call dein#add('lambdalisue/session.vim', {
    \ 'on_source': 'denite.nvim',
    \ 'hook_add': function('s:lambdalisue_session_vim'),
    \ })

" My Plugins
call dein#add($XDG_CONFIG_HOME . '/nvim/my-help')

function! s:line_number_interval_nvim() abort
    let g:line_number_interval#enable_at_startup = 1
    let g:line_number_interval#use_custom = 1
endfunction

call dein#add('IMOKURI/line-number-interval.nvim', {
    \ 'hook_add': function('s:line_number_interval_nvim')
    \ })

call dein#end()

if dein#check_install()
    call dein#install()
    call dein#source(['deoplete.nvim', 'denite.nvim'])
    call dein#remote_plugins()
endif

if !empty(dein#check_clean())
    call map(dein#check_clean(), "delete(v:val, 'rf')")
endif

" -----------------------------------------------------------------------------
" netrw
" -----------------------------------------------------------------------------
" one file per line with timestamp information and file size
let g:netrw_liststyle=1

" suppress the banner
let g:netrw_banner=0

" human-readable
let g:netrw_sizestyle='H'

" specify format string to vim's strftime()
let g:netrw_timefmt='%Y/%m/%d(%a) %H:%M:%S'

" The home directory for where bookmarks and history are saved
let g:netrw_home=expand('~')

" the settings that netrw buffers have
let g:netrw_bufsettings='noma nomod nu rnu nowrap ro nobl'

" -----------------------------------------------------------------------------
" Color scheme
" -----------------------------------------------------------------------------
if has('nvim') || has('termguicolors')
    set termguicolors
endif

filetype plugin indent on
syntax on

colorscheme challenger_deep

function! s:colorize(group, style) abort
    execute 'highlight' a:group
        \ 'guifg='   (has_key(a:style, 'fg')    ? a:style.fg.gui   : 'NONE')
        \ 'guibg='   (has_key(a:style, 'bg')    ? a:style.bg.gui   : 'NONE')
        \ 'ctermfg=' (has_key(a:style, 'fg')    ? a:style.fg.cterm : 'NONE')
        \ 'ctermbg=' (has_key(a:style, 'bg')    ? a:style.bg.cterm : 'NONE')
endfunction

let s:red            = {'gui': '#ff8080', 'cterm': '204'}
let s:dark_red       = {'gui': '#ff5458', 'cterm': '203'}

let s:yellow         = {'gui': '#ffe9aa', 'cterm': '228'}
let s:dark_yellow    = {'gui': '#ffb378', 'cterm': '215'}

let s:green          = {'gui': '#95ffa4', 'cterm': '120'}
let s:dark_green     = {'gui': '#62d196', 'cterm': '119'}

let s:blue           = {'gui': '#91ddff', 'cterm': '159'}
let s:dark_blue      = {'gui': '#65b2ff', 'cterm': '75'}

let s:purple         = {'gui': '#c991e1', 'cterm': '141'}
let s:dark_purple    = {'gui': '#906cff', 'cterm': '135'}

let s:cyan           = {'gui': '#aaffe4', 'cterm': '122'}
let s:dark_cyan      = {'gui': '#63f2f1', 'cterm': '121'}

let s:clouds         = {'gui': '#cbe3e7', 'cterm': '253'}
let s:dark_clouds    = {'gui': '#a6b3cc', 'cterm': '252'}

let s:asphalt        = {'gui': '#1e1c31', 'cterm': '233'}
let s:asphalt_subtle = {'gui': '#100E23', 'cterm': '232'}
let s:dark_asphalt   = {'gui': '#565575', 'cterm': '236'}

let s:norm        = s:clouds
let s:norm_subtle = s:dark_clouds

let s:bg          = s:asphalt
let s:bg_subtle   = s:asphalt_subtle
let s:bg_dark     = s:dark_asphalt

call s:colorize('Folded', {'bg': s:bg_dark, 'fg': s:bg_subtle})

if has('nvim')
    call s:colorize('ActiveWindow',   {'bg': s:bg,        'fg': s:norm})
    call s:colorize('InactiveWindow', {'bg': s:bg_subtle, 'fg': s:norm})
    set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
endif

if has('nvim-0.3.2')
    call s:colorize('ALEErrorSignLineNr',        {'bg': s:bg_subtle, 'fg': s:dark_red})
    call s:colorize('ALEStyleErrorSignLineNr',   {'bg': s:bg_subtle, 'fg': s:dark_red})
    call s:colorize('ALEWarningSignLineNr',      {'bg': s:bg_subtle, 'fg': s:dark_yellow})
    call s:colorize('ALEStyleWarningSignLineNr', {'bg': s:bg_subtle, 'fg': s:dark_yellow})
endif

call s:colorize('CursorLineNr',      {'bg': s:bg_subtle, 'fg': s:yellow})
call s:colorize('DimLineNr',         {'bg': s:bg_subtle, 'fg': s:dark_asphalt})
call s:colorize('HighlightedLineNr', {'bg': s:bg_subtle, 'fg': s:blue})

call s:colorize('YankRoundRegion', {'bg': s:norm_subtle, 'fg': s:bg_subtle})

if exists('&blend')
    highlight PmenuSel blend=0
endif

" -----------------------------------------------------------------------------
" Status line
" -----------------------------------------------------------------------------
function! LightLineFugitive() abort
    try
        return exists('*fugitive#head') ? ' ' . fugitive#head() : ''
    catch
    endtry
    return ''
endfunction

function! LightLineReadOnly()
    return &filetype !~? 'help' && &readonly ? '' : ''
endfunction

" ファイル名を下位3階層のみの表示にする
function! LightLineFilePath() abort
    try
        if expand('%:p:~') =~# '^suda://'
            let g:is_suda = 'suda://'
        else
            let g:is_suda = ''
        endif

        if expand('%:p:~:s?suda://??') =~# '^/[^/]*\/[^/]*\/[^/]*$'
            return expand('%:p:~')
        elseif expand('%:p:~:s?suda://??') =~# '/[^/]*\/[^/]*\/[^/]*$'
            return g:is_suda . expand('%:p:~:s?suda://??:s?.*\(/[^/]*\/[^/]*\/[^/]*\)$?...\1?')
        else
            return expand('%:p:~')
        endif
    catch
    endtry
    return ''
endfunction

let g:lightline#ale#indicator_checking = '(」・ω・)」うー '
let g:lightline#ale#indicator_ok = '(/・ω・)/にゃー'

let g:lightline = {
    \ 'colorscheme': 'challenger_deep',
    \ 'active': {
    \   'left': [
    \     [ 'mode', 'paste' ],
    \     [ 'fugitive', 'readonly', 'filepath', 'modified' ],
    \     [ 'linter_checking', 'linter_warnings', 'linter_errors', 'linter_ok' ]
    \   ],
    \   'right': [
    \     [ 'percent', 'lineinfo' ],
    \     [ 'filetype' ],
    \     [ 'anzu', 'fileformat', 'fileencoding' ]
    \   ]
    \ },
    \ 'tabline': {
    \   'left': [[ 'tabs' ]],
    \   'right': [[ 'none' ]]
    \ },
    \ 'component_expand': {
    \   'linter_checking': 'lightline#ale#checking',
    \   'linter_warnings': 'lightline#ale#warnings',
    \   'linter_errors': 'lightline#ale#errors',
    \   'linter_ok': 'lightline#ale#ok',
    \ },
    \ 'component_type': {
    \   'linter_warnings': 'warning',
    \   'linter_errors': 'error',
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightLineFugitive',
    \   'readonly': 'LightLineReadOnly',
    \   'filepath': 'LightLineFilePath',
    \   'anzu': 'anzu#search_status'
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }

let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette

let s:palette.tabline.tabsel = [
    \ [ s:bg_subtle.gui, s:cyan.gui,      s:bg_subtle.cterm, s:cyan.cterm ]
    \ ]

let s:palette.tabline.right = [
    \ [ s:bg_subtle.gui, s:bg_subtle.gui, s:bg_subtle.cterm, s:bg_subtle.cterm ]
    \ ]

let s:palette.normal.left = [
    \ [ s:bg_subtle.gui, s:blue.gui,      s:bg_subtle.cterm, s:blue.cterm ],
    \ [ s:bg_subtle.gui, s:dark_blue.gui, s:bg_subtle.cterm, s:dark_blue.cterm ]
    \ ]
let s:palette.normal.right = [
    \ [ s:bg_subtle.gui, s:blue.gui,      s:bg_subtle.cterm, s:blue.cterm ],
    \ [ s:bg_subtle.gui, s:dark_blue.gui, s:bg_subtle.cterm, s:dark_blue.cterm ]
    \ ]

let s:palette.insert.left = [
    \ [ s:bg_subtle.gui, s:yellow.gui,      s:bg_subtle.cterm, s:yellow.cterm ],
    \ [ s:bg_subtle.gui, s:dark_yellow.gui, s:bg_subtle.cterm, s:dark_yellow.cterm ]
    \ ]
let s:palette.insert.right = [
    \ [ s:bg_subtle.gui, s:yellow.gui,      s:bg_subtle.cterm, s:yellow.cterm ],
    \ [ s:bg_subtle.gui, s:dark_yellow.gui, s:bg_subtle.cterm, s:dark_yellow.cterm ]
    \ ]

let s:palette.visual.left = [
    \ [ s:bg_subtle.gui, s:green.gui,      s:bg_subtle.cterm, s:green.cterm ],
    \ [ s:bg_subtle.gui, s:dark_green.gui, s:bg_subtle.cterm, s:dark_green.cterm ]
    \ ]
let s:palette.visual.right = [
    \ [ s:bg_subtle.gui, s:green.gui,      s:bg_subtle.cterm, s:green.cterm ],
    \ [ s:bg_subtle.gui, s:dark_green.gui, s:bg_subtle.cterm, s:dark_green.cterm ]
    \ ]

let s:palette.replace.left = [
    \ [ s:bg_subtle.gui, s:red.gui,      s:bg_subtle.cterm, s:red.cterm ],
    \ [ s:bg_subtle.gui, s:dark_red.gui, s:bg_subtle.cterm, s:dark_red.cterm ]
    \ ]
let s:palette.replace.right = [
    \ [ s:bg_subtle.gui, s:red.gui,      s:bg_subtle.cterm, s:red.cterm ],
    \ [ s:bg_subtle.gui, s:dark_red.gui, s:bg_subtle.cterm, s:dark_red.cterm ]
    \ ]

let s:palette.inactive.left = [
    \ [ s:bg_subtle.gui, s:purple.gui,      s:bg_subtle.cterm, s:purple.cterm ],
    \ [ s:bg_subtle.gui, s:dark_purple.gui, s:bg_subtle.cterm, s:dark_purple.cterm ]
    \ ]
let s:palette.inactive.right = [
    \ [ s:bg_subtle.gui, s:purple.gui,      s:bg_subtle.cterm, s:purple.cterm ],
    \ [ s:bg_subtle.gui, s:dark_purple.gui, s:bg_subtle.cterm, s:dark_purple.cterm ]
    \ ]

" -----------------------------------------------------------------------------
" Useful function
" -----------------------------------------------------------------------------
function! DeleteHiddenBuffers() abort
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction

function! REPLSend(str) abort
    let s:str = a:str
    if s:str[-1] !=# "\n"
        let s:str .= "\n"
    endif
    let s:str = substitute(s:str, "\n", "\<CR>", 'g')

    if has('nvim')
        call chansend(g:last_terminal_job_id, [s:str])
    else
        call term_sendkeys(g:last_terminal_job_id, s:str)
    endif
endfunction

function! s:get_visual() abort
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][:col2 - 2]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
endfunction

function! REPLMapFor(cmd) abort
    exec 'nnoremap <silent> tt :call REPLSend("' . s:replmap_expand(a:cmd) . '")<CR>'
endfunction

function! s:replmap_expand(cmd) abort
    let l:cmd = substitute(a:cmd, '[^\\]\zs%', expand('%'), 'g')

    return l:cmd
endfunction

function! s:smart_foldcloser() abort
    if foldlevel('.') == 0
        norm! zM
        return
    endif

    let foldc_lnum = foldclosed('.')
    norm! zc
    if foldc_lnum == -1
        return
    endif

    if foldclosed('.') != foldc_lnum
        return
    endif
    norm! zM
endfunction

function! s:auto_mkdir(dir, force) abort
    if !isdirectory(a:dir) && (a:force || input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction

function! s:hint_cmd_output(prefix, cmd) abort
    redir => str
        execute a:cmd
    redir END
    let more_old = &more
    set nomore
    echo str
    let &more = more_old
    return a:prefix . nr2char(getchar())
endfunction

" -----------------------------------------------------------------------------
" Command
" -----------------------------------------------------------------------------

command! -range=% REPLSendSelection call REPLSend(s:get_visual())
command! REPLSendLine call REPLSend(getline('.'))
command! -complete=shellcmd -nargs=+ REPLMap call REPLMapFor(<q-args>)

" -----------------------------------------------------------------------------
" Auto command
" -----------------------------------------------------------------------------
augroup MyAutoCmd
    autocmd!

    autocmd VimEnter * if &diff | execute 'windo set wrap' | endif

    autocmd BufRead,BufNewFile Dockerfile.* setf dockerfile

    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif

    autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
    autocmd CursorHold,CursorHoldI,WinEnter * setlocal cursorline

    autocmd InsertLeave * set nopaste

    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h:s?suda://??'), v:cmdbang)

    if has('nvim')
        autocmd TermOpen * let g:last_terminal_job_id = b:terminal_job_id
    else
        autocmd TerminalOpen * let g:last_terminal_job_id = bufnr('')
    endif

    autocmd FileType vim let g:vim_indent_cont = &shiftwidth

    autocmd FileType python nnoremap <silent> <CR><CR> :call REPLSend('python ' . expand('%'))<CR>
    autocmd FileType bash,sh nnoremap <silent> <CR><CR> :call REPLSend('bash ' . expand('%'))<CR>
    autocmd FileType yaml nnoremap <silent> <CR><CR> :call REPLSend('ansible-playbook ' . expand('%'))<CR>
augroup END

" -----------------------------------------------------------------------------
" Mapping
" -----------------------------------------------------------------------------
" Exモード使わない
nmap Q <Nop>

" ファイル保存
nnoremap <silent> <Leader>w :<C-u>w<CR>

" すべてのバッファのファイルを保存
nnoremap <silent> <Leader><Leader>w :<C-u>wa<CR>

" root権限でファイルを保存する
cnoremap w!! w !sudo tee > /dev/null %

" windowを閉じる
nnoremap <silent> qq :<C-u>close<CR>

" 全てのタブを閉じる
nnoremap <silent> <Leader>q :<C-u>qa<CR>

" すべてのタブを保存せず閉じる
nnoremap <silent> <Leader>Q :<C-u>qa!<CR>

" 新しいタブを開く
nnoremap <silent> gt :<C-u>tabnew<CR>

" カーソル下のディレクトリを開く
nnoremap gd :Explore <C-r><C-f><CR>

" タブを移動する
nnoremap gn gt
nnoremap gp gT

" 先頭/末尾に移動する
noremap H ^
noremap L $

" ターミナルを開く
nnoremap <silent> te :terminal<CR>i

" ESCでターミナルモードからコマンドモードにする
tnoremap <silent> <ESC> <C-\><C-n>

" 行/選択範囲をターミナルに送る
nnoremap <silent> <Leader><CR> :REPLSendLine<CR>
xnoremap <silent> <Leader><CR> :REPLSendSelection<CR>

" インデントをコマンド1回にする
nnoremap > >>
nnoremap < <<

" 表示行単位で移動する
nnoremap j gj
nnoremap k gk

" ウィンドウを移動する
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
if has('nvim')
    " TERM環境変数が悪そう
    nnoremap <BS> <C-w>h
else
    nnoremap <C-h> <C-w>h
endif

" ウィンドウを分割する
nnoremap <Leader>- <C-w>s
nnoremap <Leader><bar> <C-w>v

" ウィンドウの大きさを変更する
nnoremap <Leader><Up> <C-w>+
nnoremap <Leader><Down> <C-w>-
nnoremap <Leader><Right> <C-w>>
nnoremap <Leader><Left> <C-w><

" 直前のバッファに移動する
nnoremap <Leader><Tab> <C-^>

" 折りたたみを開く
nnoremap <expr> l foldclosed('.') != -1 ? 'zo' : 'l'
nnoremap <silent> zl zO

" 折りたたみを閉じる
nnoremap <silent> , :<C-u>call <SID>smart_foldcloser()<CR>

" 現在いるところ以外の折り畳みを閉じる
nnoremap <silent> z, zMzv

" カーソル下の単語をハイライトして置換する
nmap # *:%s/<C-r>///g<Left><Left>

" バッファ内で置換する
nnoremap S :%s//g<LEFT><LEFT>

" コマンドラインモード内を移動する
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

" マークをリストアップして{保存,復旧}する
nnoremap <expr> m  <SID>hint_cmd_output('m', 'marks')
nnoremap <expr> `  <SID>hint_cmd_output('`', 'marks') . 'zz'

" レジストリをリストアップする
nnoremap <expr> " <SID>hint_cmd_output('"', 'registers')

" # を入力したときに行頭に移動しない
"inoremap # x<BS>#

" インサートモード中に移動する
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <left>
inoremap <C-f> <right>

" -----------------------------------------------------------------------------
" Options
" -----------------------------------------------------------------------------
" 文字コード判別
set fileencodings=utf-8,sjis,iso-2022-jp,euc-jp

" 曖昧な幅の文字の論理幅を1に
set ambiwidth=single

" 行番号を表示
set number

" 行番号を相対位置で表示
set relativenumber

" 制御文字を表示
set list

" タブをスペースに変換
set expandtab

" インデントをスペース4つ分に設定
set tabstop=4

" タブとその削除をスペース4つ分に設定
set softtabstop=4

" >> コマンドで挿入される幅
set shiftwidth=4

" >> で挿入する際、shiftwidthの倍数になるように調整
set shiftround

" スマートインデント有効化
set smartindent

" カーソルラインをハイライト
set cursorline

" 行頭に移動しない
set nostartofline

" 括弧入力時の対応する括弧を表示
set showmatch

" 折返しのときにインデントがつく
set breakindent

" breakindentの記号
set showbreak=(//_//)

" showbreakを左端に表示する
set breakindentopt=sbr

" indentの階層で折りたたみを行う
set foldmethod=indent

" 3行以上が対象となる場合のみ折りたたむ
set foldminlines=3

" 折りたたみの最大の深さ
set foldnestmax=10

" 画面端が3行見える状態でスクロールする
set scrolloff=3

" ステータスラインを常に表示する
if !has('nvim')
    set laststatus=2
endif

" モードを非表示にする
set noshowmode

" 保存していなくても移動できる
set hidden

" 画面の更新時間を設定(ms)
set updatetime=250

" 80文字目にラインを表示
set colorcolumn=80

" 有効なときのみ再描画する
set lazyredraw

" ポップアップメニューを透過する
if exists('&pumblend')
    set pumblend=20
endif

" ポップアップメニューで表示する数
set pumheight=10

" 大文字/小文字の区別なく検索する
set ignorecase

" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase

" 検索時に最後まで行ったら最初に戻る
set wrapscan

" ファイルを検索する際大文字/小文字を区別しない
set fileignorecase

" ファイル名を補完する
set wildmode=longest,full

" 置換内容を表示
if has('nvim')
    set inccommand=split
endif

" diffのアルゴリズムを設定
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

" 矩形選択時に文字のないところにカーソルを移動できるようにする
set virtualedit+=block

" clipboard設定
set clipboard+=unnamedplus

" undoファイルを作成する
set undofile

" スワップファイルを作成する
set swapfile

" 補完ディクショナリ設定
set dictionary=/usr/share/dict/words

" 補完時にpreviewを表示しない
set completeopt-=preview

" バックアップファイルを作成しない
set nobackup
