del /p %USERPROFILE%\.vimrc
del /p %USERPROFILE%\.gvimrc
del /p %USERPROFILE%\.gitconfig
rmdir %USERPROFILE%\.vim

mklink "%USERPROFILE%\.vimrc" "%USERPROFILE%\dotfiles\vimrc"
mklink "%USERPROFILE%\.gitconfig" "%USERPROFILE%\dotfiles\gitconfig"
mklink /d "%USERPROFILE%\.vim" "%USERPROFILE%\dotfiles\vim"
pause
