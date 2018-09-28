let g:python_host_prog = substitute(system("cd ~/.dotfiles/config/nvim/py2; pipenv run which python; cd -"), '\n', '', 'g')
let g:python3_host_prog = substitute(system("cd ~/.dotfiles/config/nvim/py3; pipenv run which python; cd -"), '\n', '', 'g')
