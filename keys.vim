" Remap terminal exit
tnoremap <C-[> <C-\><C-n>

" adjust split screen size
noremap ¬ 8<C-W>>
noremap ˙ 8<C-W><
noremap ˚ 4<C-W>+
noremap ∆ 4<C-W>-


" move screen
nnoremap <C-W>j <C-W>J
nnoremap <C-W>k <C-W>K
nnoremap <C-W>l <C-W>L
nnoremap <C-W>h <C-W>H
nnoremap <C-W>t <C-W>T

" tab navigation mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
inoremap <C-]> <C-X><C-O>
nnoremap <C-H> <C-W><C-H>

" map tt :tabnew
map <M-Right> :tabn<CR>
imap <M-Right> <ESC>:tabn<CR>
map <M-Left> :tabp<CR>
imap <M-Left> <ESC>:tabp<CR>
map <M-Down> :tabclose<CR>

" window swap
nnoremap <silent> <leader>w : call WindowSwap#EasyWindowSwap()<CR>

" Toggle terminal on/off (neovim)
nnoremap <leader>t :call TermToggle(12)<CR>
tnoremap <leader>t <C-\><C-n>:call TermToggle(12)<CR>

"JSDoc
autocmd FileType javascript nmap <leader>d :JsDoc<CR>

"JAVA align comments
autocmd FileType java xmap <leader>a :Tab /\/\/<CR>

" toggle tagbar display
map <leader>2 :TagbarToggle<CR>

" show pending tasks list
map <F1> :TaskList<CR>

" open nerdtree with the current file selected
nnoremap <leader>1 :NERDTreeFind<CR>

" ale fixer
nnoremap <leader>e :ALEFix<CR>

" eslint correction
autocmd FileType javascript,typescript,typescript.tsx nnoremap <leader>e :CocCommand eslint.executeAutofix<CR>

" ========== ASYNCRUN ===============
function! s:compile_and_run()
 let l:cmd = {
 \ 'c' : "gcc % -o %<; time ./%<",
 \ 'sh' : "time bash %",
 \ 'go' : "go run %",
 \ 'cpp' : "g++ -std=c++11 % -o %<; time ./%<",
 \ 'ruby' : "time ruby %",
 \ 'java' : "javac %; time java %<",
 \ 'rust' : "rustc % -o %<; time ./%<",
 \ 'python' : "time python %",
 \ 'typescript' : "./node_modules/ts-node %",
 \ 'javascript' : "node %",
 \ 'javascript.jsx' : "yarn start",
 \ 'html' : "chromium %",
 \ 'lilypond' : "lilypond %",
 \}
 let l:ft = &filetype
 if has_key(l:cmd, l:ft)
   exec 'w'
   exec "AsyncRun! ".l:cmd[l:ft]
 else
   echoerr "AsyncRun not supported in current filetype!"
 endif

endfunction

"run asyncrun
nnoremap gm :call <SID>compile_and_run()<CR>

" execute python file in terminal
autocmd FileType python nnoremap gm :CocCommand python.execInTerminal<CR>

" compile tex file
autocmd FileType tex nnoremap gm :VimtexCompile<CR>

" markdown preview
command MdToPdf !pandoc % -o %:r.pdf --template=template.tex --pdf-engine=lualatex
autocmd FileType markdown nnoremap gm :MarkdownPreview<CR>
autocmd FileType markdown nnoremap cm :MdToPdf<CR>


" mappings to jump to changed blocks for signify (git)
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)

" change binding of folding (simpylfold)
nnoremap <space> za

" with spellcheck on, fix all spelling errors
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" file finder mapping
nmap <leader>l :Files<CR>

" general code finder in all files mapping
nmap <leader>F :Rg<CR>

" code finder in loaded buffers
nmap <leader>f :Lines<CR>

" search under the cursor
nmap <leader>r :exec 'Rg' expand('<cword>')<CR>

" tags in all buffers
nmap <leader>G :Tags<CR>

" tags (symbols) in current file finder mapping
nmap <leader>g :BTag<CR>

" list all files in buffer
nmap <leader>b :Buffers<CR>

" commands finder mapping
nmap <leader>c :Commands<CR>

" fugitive status shortcut
nmap <leader>gs :Gstatus<CR>

" omnisharp
augroup omnisharp_commands
    autocmd!

    " Show type information automatically when the cursor stops moving.
    " Note that the type is echoed to the Vim command line, and will overwrite
    " any other messages in this space including e.g. ALE linting messages.
    autocmd CursorHold *.cs OmniSharpTypeLookup

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> <Leader>gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>pd :OmniSharpPreviewDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>pi :OmniSharpPreviewImplementation<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-'> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-;> :OmniSharpNavigateDown<CR>

    " Find all code errors/warnings for the current solution and populate the quickfix window
    autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>ss :OmniSharpStartServer<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>sp :OmniSharpStopServer<CR>
    " autocmd FileType cs nnoremap <buffer> <Leader>e :OmniSharpCodeFormat<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>e :Uncrustify<CR>
    " Contextual code actions (uses fzf, CtrlP or unite.vim when available)
    autocmd FileType cs nnoremap <buffer> <Leader><Space> :OmniSharpGetCodeActions<CR>
    " Run code actions with text selected in visual mode to extract method
    autocmd FileType cs xnoremap <buffer> <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>
augroup END
