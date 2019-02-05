@echo off

SET NVIMPATH="%USERPROFILE%\AppData\Local\nvim"
SET DOTPATH="%USERPROFILE%\dotfiles"

:Menu
    pushd %0\..

    cls
    echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    echo +     Install Dotfiles                                               +
    echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    echo  1: Update repo.
    echo  2: Copy nvim settings.
    echo  3: Setup pipenv.
    echo  q: Quit.
    echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    set Slt=nul
    set /p Slt=Input:

    if %Slt%=='1' goto Set_1
    if %Slt%=='2' goto Set_2
    if %Slt%=='3' goto Set_3
    if %Slt%=='q' goto :eof

    goto Menu

:Set_1
    cls

    git pull origin master
    git submodule init
    git submodule update
    git submodule foreach git pull origin master

    pause
    goto Menu

:Set_2
    cls

    xcopy /s /e /y %DOTPATH%\config\nvim %NVIMPATH%

    pause
    goto Menu

:Set_3
    cls

    pushd %NVIMPATH%

    SET PIPENV_VENV_IN_PROJECT=true
    pipenv install

    popd

    pause
    goto Menu
