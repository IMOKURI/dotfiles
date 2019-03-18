set encoding=utf-8
scriptencoding utf-8

" -----------------------------------------------------------------------------
" Detect platform
" -----------------------------------------------------------------------------
if !exists('g:env')
  if has('win64') || has('win32') || has('win16')
    let g:env = 'WINDOWS'
  else
    let g:env = toupper(substitute(system('uname'), '\n', '', ''))
  endif
endif

if g:env =~# 'LINUX'
  let s:nvim_dir = expand('~/.config/nvim')
  let g:python_host_prog = '/usr/bin/python2'
  let g:python3_host_prog = s:nvim_dir . '/.venv/bin/python'

elseif g:env =~# 'WINDOWS'
  let s:nvim_dir = '$USERPROFILE/AppData/Local/nvim'
  let g:python_host_prog = ''
  let g:python3_host_prog = s:nvim_dir . '/.venv/Scripts/python'
  set shell=\"C:/Program\ Files/Git/bin/bash.exe\"

endif

let g:mapleader = "\<Space>"
let g:maplocalleader = '\'

" -----------------------------------------------------------------------------
" Plugin settings
" -----------------------------------------------------------------------------
let s:dein_dir = s:nvim_dir . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
execute 'set runtimepath^=' . s:dein_repo_dir

"---------------------------------------------------------------------------"
" Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator |
"------------------|--------|--------|---------|--------|--------|----------|
" map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |
" nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |
" vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |
" omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |
" xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |
" smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |
" map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |
" imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |
" cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |
"---------------------------------------------------------------------------"

function s:t9md_vim_quickhl()
  nmap <silent> <Leader>m <Plug>(quickhl-manual-this)
  xmap <silent> <Leader>m <Plug>(quickhl-manual-this)
  nnoremap <silent> <Leader>M :<C-u>QuickhlManualReset<CR>
endfunction

function s:ttpope_vim_fugitive()
  nnoremap <silent> <Leader>s :<C-u>Gstatus<CR>
  nnoremap <silent> <Leader>d :<C-u>Gdiff<CR>
endfunction

function s:xolox_vim_session()
  let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
  if isdirectory(s:local_session_directory)
    let g:session_directory = s:local_session_directory
    let g:session_autosave = 'yes'
    let g:session_autoload = 'yes'
    let g:session_autosave_periodic = 1
  else
    let g:session_autosave = 'no'
    let g:session_autoload = 'no'
  endif
  unlet s:local_session_directory
endfunction

function s:shougo_deoplete_nvim()
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#auto_complete_delay = 0
  let g:deoplete#auto_complete_start_length = 1
endfunction

function s:neomake_neomake_hook_add()
  augroup neomake
    autocmd!
    autocmd InsertLeave,BufWritePost * Neomake
  augroup END
endfunction

function s:neomake_neomake_hook_source()
  let g:neomake_open_list = 2
  let g:neomake_error_sign = {'text': 'E>', 'texthl': 'NeomakeErrorSign'}
  let g:neomake_warning_sign = {'text': 'W>', 'texthl': 'NeomakeWarningSign',}
  let g:neomake_info_sign = {'text': 'I>', 'texthl': 'NeomakeInfoSign'}
  let g:neomake_shellcheck_args = ['-fgcc']
endfunction

function s:sbdchd_neoformat_hook_add()
  nnoremap <silent> <Leader>n :Neoformat<CR>
endfunction

function s:sbdchd_neoformat_hook_source()
  let g:neoformat_basic_format_align = 1
  let g:neoformat_basic_format_retab = 1
  let g:neoformat_basic_format_trim = 1
endfunction

function s:shougo_denite_nvim_hook_add()
  nnoremap <silent> <Leader>p :Denite file_rec<CR>
  nnoremap <silent> <Leader>g :Denite grep<CR>
endfunction

function s:shougo_denite_nvim_hook_source()
  if executable('rg')
    call denite#custom#var('file_rec', 'command',
          \ ['rg', '--files', '--glob', '!.git'])
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'final_opts', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'default_opts',
          \ ['--vimgrep', '--no-heading'])
  endif

  call denite#custom#map('insert', '<C-j>',
        \ '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('insert', '<C-k>',
        \ '<denite:move_to_previous_line>', 'noremap')

  call denite#custom#option('default', 'prompt', '>')
endfunction

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#add('Shougo/dein.vim')

  call dein#add('challenger-deep-theme/vim')
  call dein#add('jacoborus/tender.vim')
  call dein#add('itchyny/lightline.vim')

  call dein#add('t9md/vim-quickhl', {
        \ 'hook_add': function('s:t9md_vim_quickhl')
        \ })

  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-fugitive', {
        \ 'hook_add': function('s:ttpope_vim_fugitive')
        \ })

  call dein#add('tpope/vim-sleuth')

  call dein#add('xolox/vim-misc')
  call dein#add('xolox/vim-session', {
        \ 'depends': 'vim-misc',
        \ 'hook_add': function('s:xolox_vim_session')
        \ })

  call dein#add('Shougo/deoplete.nvim', {
        \ 'on_i': 1,
        \ 'hook_source': function('s:shougo_deoplete_nvim')
        \ })

  call dein#add('zchee/deoplete-jedi', {
        \ 'depends': 'deoplete.nvim',
        \ 'on_ft': 'python'
        \ })
  call dein#add('Vimjas/vim-python-pep8-indent', {
        \ 'on_i': 1,
        \ 'on_ft': 'python'
        \ })

  call dein#add('neomake/neomake', {
        \ 'hook_add': function('s:neomake_neomake_hook_add'),
        \ 'hook_source': function('s:neomake_neomake_hook_source')
        \ })

  call dein#add('sbdchd/neoformat', {
        \ 'hook_add': function('s:sbdchd_neoformat_hook_add'),
        \ 'hook_source': function('s:sbdchd_neoformat_hook_source')
        \ })

  call dein#add('Shougo/denite.nvim', {
        \ 'on_cmd': 'Denite',
        \ 'hook_add': function('s:shougo_denite_nvim_hook_add'),
        \ 'hook_source': function('s:shougo_denite_nvim_hook_source')
        \ })

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" -----------------------------------------------------------------------------
" Color schema
" -----------------------------------------------------------------------------
if has('nvim') || has('termguicolors')
  set termguicolors
endif

filetype plugin indent on
syntax on

colorscheme challenger_deep

function! LightLineFugitive()
  try
    return exists('*fugitive#head') ? fugitive#head() : ''
  catch
  endtry
  return ''
endfunction

let g:lightline = {
  \ 'colorscheme': 'tender',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'fugitive': 'LightLineFugitive'
  \ }
  \ }

" -----------------------------------------------------------------------------
" Options
" -----------------------------------------------------------------------------
runtime! options.rc.vim
