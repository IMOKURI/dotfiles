@echo off

SET NVIMPATH="%USERPROFILE%\AppData\Local\nvim"
SET DOTPATH="%USERPROFILE%\dotfiles"

:Menu
    pushd %0\..

    cls
    echo ----------------------------------------------------------------------
    echo       Install Dotfiles
    echo ----------------------------------------------------------------------
    echo  r: Repository update.
    echo  n: Nvim settings.
    echo  p: Pipenv setup.
    echo  q: Quit.
    echo ----------------------------------------------------------------------

    set input=nul
    set /p input=Input:

    if '%input%'=='r' goto Repo
    if '%input%'=='n' goto Nvim
    if '%input%'=='p' goto Pipenv
    if '%input%'=='q' goto :EOF

    goto Menu

:Repo
    cls

    git pull origin master
    git submodule init
    git submodule update
    git submodule foreach git pull origin master

    pause
    goto Menu

:Nvim
    cls

    xcopy /s /e /y %DOTPATH%\config\nvim %NVIMPATH%

    pause
    goto Menu

:Pipenv
    cls

    pushd %NVIMPATH%

    SET PIPENV_VENV_IN_PROJECT=true
    pipenv install

    popd

    pause
    goto Menu
