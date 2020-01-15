set encoding=utf-8
scriptencoding utf-8

let g:dein#auto_recache = 1

if has('nvim')
    let g:dein#install_progress_type = 'title'

    let s:dein_dir = $XDG_DATA_HOME . '/dein/nvim'
else
    let s:dein_dir = $XDG_DATA_HOME . '/dein/vim'
endif

let s:default_toml = expand('$XDG_CONFIG_HOME/nvim/rc/dein_default.toml')
let s:lazy_toml = expand('$XDG_CONFIG_HOME/nvim/rc/dein_lazy.toml')

call dein#begin(s:dein_dir, [expand('<sfile>'), s:default_toml, s:lazy_toml])

call dein#load_toml(s:default_toml, {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy' : 1})

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

if !has('vim_starting')
    call dein#call_hook('source')
    call dein#call_hook('post_source')
endif

" Neoterm calls autoload functions in ftdetect.
" So source neoterm before filetype on.
call dein#source('neoterm')

" vim:set foldmethod=marker:
