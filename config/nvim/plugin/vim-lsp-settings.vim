
" https://github.com/palantir/python-language-server/blob/develop/vscode-client/package.json

let g:lsp_settings = {
    \ 'pyls': {
    \   'workspace_config': {
    \       'pyls': {
    \           'plugins': {
    \               'pycodestyle': {
    \                   'maxLineLength': 120
    \               },
    \               'pylint': {
    \                   'enabled': 1,
    \                   'args': [
    \                       '--init-hook="import pylint_venv; pylint_venv.inithook()"',
    \                       '--max-line-length=120',
    \                       '--disable=invalid-name',
    \                       '--disable=missing-docstring'
    \                   ]
    \               }
    \           }
    \       }
    \   }
    \ },
    \ 'vim-language-server': {
    \   'initialization_options': {
    \       'iskeyword': &iskeyword,
    \       'vimruntime': $VIMRUNTIME,
    \       'runtimepath': &runtimepath,
    \       'diagnostic': {
    \           'enable': 1
    \       },
    \       'suggest': {
    \           'fromVimruntime': 1,
    \           'fromRuntimepath': 1
    \       }
    \   }
    \ }
    \ }

