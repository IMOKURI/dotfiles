let g:python_host_prog = substitute(system('ls /root/.virtualenvs/py2-*/bin/python'), '\n', '', 'g')
let g:python3_host_prog = substitute(system('ls /root/.virtualenvs/py3-*/bin/python'), '\n', '', 'g')
