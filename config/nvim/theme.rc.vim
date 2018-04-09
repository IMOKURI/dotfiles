colorscheme challenger_deep

let g:lightline = {
  \ 'colorscheme': 'tender',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'fugitive': 'LightLineFugitive'
  \ }
  \ }

" ステータスバーにgitのHEADのブランチを表示する関数
function! LightLineFugitive()
  try
    return exists('*fugitive#head') ? fugitive#head() : ''
  catch
  endtry
  return ''
endfunction

hi! Normal ctermbg=NONE guibg=NONE
