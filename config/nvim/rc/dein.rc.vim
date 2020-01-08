set encoding=utf-8
scriptencoding utf-8

if has('nvim')
    let s:dein_dir = $XDG_DATA_HOME . '/dein/nvim'
else
    let s:dein_dir = $XDG_DATA_HOME . '/dein/vim'
endif

let s:default_toml = expand('$XDG_CONFIG_HOME/nvim/rc/dein_default.toml')
let s:lazy_toml = expand('$XDG_CONFIG_HOME/nvim/rc/dein_lazy.toml')

call dein#begin(s:dein_dir, [expand('<sfile>'), s:default_toml, s:lazy_toml])

call dein#load_toml(s:default_toml, {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy' : 1})

" Plugin Manager {{{
call dein#add('Shougo/dein.vim')
call dein#add('wsdjeg/dein-ui.vim')
" }}}

" Color Scheme {{{
call dein#add('challenger-deep-theme/vim')
" }}}

" Git {{{
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
" }}}

" Project {{{
function! s:airblade_vim_rooter() abort
    let g:rooter_change_directory_for_non_project_files = 'current'
    let g:rooter_patterns = ['.git', '.git/']
endfunction

call dein#add('airblade/vim-rooter', {
    \ 'hook_add': function('s:airblade_vim_rooter')
    \ })
" }}}

" Highlight {{{
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

call dein#add('cespare/vim-toml', {
    \ 'on_ft': 'toml'
    \ })

call dein#add('pearofducks/ansible-vim', {
    \ 'on_ft': 'yaml'
    \ })

call dein#add('martinda/Jenkinsfile-vim-syntax', {
    \ 'on_path': '.*Jenkinsfile'
    \ })

call dein#add('RRethy/vim-hexokinase', {
    \ 'build': 'make hexokinase'
    \ })
" }}}

" Utility {{{
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

" function! s:rhysd_reply_vim() abort
" endfunction

" call dein#add('rhysd/reply.vim', {
"     \ 'hook_add': function('s:rhysd_reply_vim')
"     \ })
" }}}

" Terminal {{{
function! s:voldikss_vim_floaterm() abort
    let g:floaterm_winblend = 20
    let g:floaterm_position = 'center'
    let g:floaterm_width = float2nr(0.85 * winwidth(0))
    let g:floaterm_height = float2nr(0.8 * winheight(0))

    nnoremap <silent> <C-u> :FloatermToggle<CR>
    tnoremap <silent> <C-u> <C-\><C-n>:FloatermToggle<CR>
endfunction

call dein#add('voldikss/vim-floaterm', {
    \ 'on_cmd': ['FloatermToggle'],
    \ 'hook_add': function('s:voldikss_vim_floaterm')
    \ })

function! s:kassio_neoterm() abort
    let g:neoterm_autoscroll = 1
    let g:neoterm_default_mod = 'botright'
    let g:neoterm_repl_python = 'python'

    nnoremap <silent> <C-t> :Ttoggle<CR>
    tnoremap <silent> <C-t> <C-\><C-n>:Ttoggle<CR>

    nnoremap <silent> <C-y> :Topen<CR><C-w>ji
    tnoremap <silent> <C-y> <C-\><C-n><C-w>k

    " nnoremap <silent> <CR><CR> :TREPLSendFile<CR>
    " nnoremap <silent> <Leader><CR> :TREPLSendLine<CR>
    " xnoremap <silent> <Leader><CR> :TREPLSendSelection<CR>
endfunction

call dein#add('kassio/neoterm', {
    \ 'on_cmd': ['Ttoggle', 'Topen'],
    \ 'hook_add': function('s:kassio_neoterm')
    \ })
" }}}

" LSP {{{
if has('nvim')
    function! s:neovim_nvim_lsp() abort
        lua require'nvim_lsp'.pyls.setup{}
        lua require'nvim_lsp'.vimls.setup{}
        lua require'nvim_lsp'.yamlls.setup{}

        nnoremap <silent> <Leader>] <cmd>lua vim.lsp.buf.definition()<CR>
        nnoremap <silent> <Leader>k <cmd>lua vim.lsp.buf.signature_help()<CR>
        nnoremap <silent> <Leader>z <cmd>lua vim.lsp.buf.formatting()<CR>
        nnoremap <silent> K         <cmd>lua vim.lsp.buf.hover()<CR>
    endfunction

    call dein#add('neovim/nvim-lsp', {
        \ 'hook_source': function('s:neovim_nvim_lsp')
        \ })
endif
" }}}

" Completion {{{
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

call dein#add('tbodt/deoplete-tabnine', {
    \ 'build': './install.sh'
    \ })

call dein#add('Shougo/neco-syntax')

call dein#add('Shougo/neco-vim', {
    \ 'on_ft': 'vim'
    \ })

" call dein#add('deoplete-plugins/deoplete-jedi', {
"     \ 'on_ft': 'python'
"     \ })

call dein#add('fszymanski/deoplete-emoji')

call dein#add('Shougo/deoplete-lsp')
" }}}

" Linter {{{
function! s:w0rp_ale() abort
    let g:ale_sign_error = 'E>'
    let g:ale_sign_warning = 'W>'
    let g:ale_sign_highlight_linenrs = 1

    let g:ale_virtualtext_cursor = 1

    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%severity%][%linter%] %s'

    let g:ale_linters = {
        \ 'awk': ['gawk'],
        \ 'javascript': ['eslint'],
        \ 'json': ['jq'],
        \ 'make': ['checkmake'],
        \ 'python': ['flake8', 'pylint'],
        \ 'sh': ['language_server'],
        \ 'vim': ['vint'],
        \ 'vue': ['eslint'],
        \ 'yaml': ['yamllint']
        \ }

    let g:ale_fixers = {
        \ 'javascript': ['eslint'],
        \ 'json': ['jq'],
        \ 'python': ['autopep8', 'yapf', 'black', 'isort'],
        \ 'sh': ['shfmt'],
        \ 'vue': ['eslint'],
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
" }}}

" Formatter {{{
call dein#add('Vimjas/vim-python-pep8-indent', {
    \ 'on_event': 'InsertEnter',
    \ 'on_ft': 'python'
    \ })
" }}}

" Snippet {{{
" call dein#add('phenomenes/ansible-snippets')
" call dein#add('Shougo/neosnippet-snippets')
" call dein#add('honza/vim-snippets')

" function! s:Shougo_neosnippet() abort
"     imap <C-k> <Plug>(neosnippet_expand_or_jump)
"     smap <C-k> <Plug>(neosnippet_expand_or_jump)
"     xmap <C-k> <Plug>(neosnippet_expand_target)

"     let g:neosnippet#enable_snipmate_compatibility = 1

"     let g:neosnippet#snippets_directory = [
"         \ $XDG_DATA_HOME . '/dein/repos/github.com/phenomenes/ansible-snippets/snippets',
"         \ $XDG_DATA_HOME . '/dein/repos/github.com/honza/vim-snippets/snippets',
"         \ $XDG_CONFIG_HOME . '/nvim/neosnippets'
"         \ ]
" endfunction

" call dein#add('Shougo/neosnippet', {
"     \ 'depends': ['ansible-snippets', 'neosnippet-snippets', 'context_filetype.vim'],
"     \ 'on_event': 'InsertCharPre',
"     \ 'on_ft': 'snippet',
"     \ 'hook_source': function('s:Shougo_neosnippet')
"     \ })
" }}}

" Status Line {{{
call dein#add('itchyny/lightline.vim')
call dein#add('maximbaz/lightline-ale')
" }}}

" Launcher {{{
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

    function! s:denite_settings() abort " {{{
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
    endfunction " }}}

    function! s:denite_filter_settings() abort " {{{
        nnoremap <silent><buffer><expr> <ESC>
            \ denite#do_map('quit')
    endfunction " }}}

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
        \ ['init.rc.vim', '~/.dotfiles/config/nvim/rc/init.rc.vim'],
        \ ['options.rc.vim', '~/.dotfiles/config/nvim/rc/options.rc.vim'],
        \ ['dein.rc.vim', '~/.dotfiles/config/nvim/rc/dein.rc.vim'],
        \ ['dein_default.toml', '~/.dotfiles/config/nvim/rc/dein_default.toml'],
        \ ['dein_lazy.toml', '~/.dotfiles/config/nvim/rc/dein_lazy.toml'],
        \ ['vimrc.vim', '~/.dotfiles/config/nvim/autoload/vimrc.vim'],
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
" }}}

" Session Manager {{{
function! s:lambdalisue_session_vim() abort
    nnoremap ss :SessionSave
endfunction

call dein#add('lambdalisue/session.vim', {
    \ 'on_source': 'denite.nvim',
    \ 'hook_add': function('s:lambdalisue_session_vim'),
    \ })
" }}}

" My Plugins {{{
if has('nvim-0.3.2')
    function! s:line_number_interval_nvim() abort
        let g:line_number_interval#enable_at_startup = 1
        " let g:line_number_interval#use_custom = 1
    endfunction

    call dein#add('IMOKURI/line-number-interval.nvim', {
        \ 'hook_add': function('s:line_number_interval_nvim')
        \ })
endif
" }}}

call dein#end()

if dein#check_install()
    call dein#install()
    call dein#source(['deoplete.nvim', 'denite.nvim'])
    call dein#remote_plugins()
endif

if !empty(dein#check_clean())
    call map(dein#check_clean(), "delete(v:val, 'rf')")
endif

" vim:set foldmethod=marker:
