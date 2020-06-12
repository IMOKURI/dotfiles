
setlocal foldmethod=marker

let g:vim_indent_cont = &shiftwidth

if has('nvim-0.4.0')
    packadd nvim-colorizer.lua
    lua if jit ~= nil then require'colorizer'.setup() end
endif
