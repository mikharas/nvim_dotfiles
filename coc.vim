" GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gd :call CocAction('jumpDefinition', 'vsp')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Rename current word.
"TODO it works in a weird way, that until you save all buffer, the new name is
"not recognized. Do that it will keep analytics before saving.
nmap <leader>,r <Plug>(coc-rename)

" Format selected region.
xmap <leader>,f  <Plug>(coc-format-selected)
nmap <leader>,f  <Plug>(coc-format-selected)

" Do codeAction for selected region, ex: `<leader>ylaap` for current paragraph.
"TODO realise how you choose the action.
"TODO look for useful actions, and maybe map them separately.
xmap <leader>,a  <Plug>(coc-codeaction-selected)
nmap <leader>,a  <Plug>(coc-codeaction-selected)
"
" Use `:Format` to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=? Unfold :0,$foldopen
