" ====== GENERAL SETTINGS ===========
" buffer
set hidden

" enable mouse support
set mouse=a

" show line numbers
set nu

" remove ugly vertical lines on window division
set fillchars+=vert:\

" use true color SUPPORT
set termguicolors

"colorscheme
let &t_Co = 256
set background=dark
colorscheme vim-material

let g:python3_host_prog = '/usr/bin/python3'

" change leader key to comma
let mapleader=","

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set encoding=utf-8

" omni completion
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

" needed so deoplete can auto select the first suggestion
set completeopt+=noinsert
" comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
set completeopt-=preview

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" automatically use the system clipboard for copy and paste
set clipboard=unnamedplus

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=5

set tags=./tags;/

" clear search results
nnoremap <silent> // :noh<CR>

" save as sudo
ca w!! w !sudo tee "%"

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre * :%s/\s\+$//e

" trigger autoread when buffer is left
au FocusGained,BufEnter * :silent! !

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" automate g++ Makefile compilation and execution
command Make !make; ./test; make clean

" ====== FILETYPE SPECIFIC ===========
" flag unnecessary whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match Cursor /\s\+$/
" autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript.tsx

" tabs and spaces handling
au BufNewFile,BufRead *.py
    \ set tabstop=4     |
    \ set softtabstop=4 |
    \ set shiftwidth=4  |
    \ set textwidth=79  |
    \ set expandtab     |
    \ set autoindent    |

au BufNewFile,BufRead *.md,*.txt,*.tex,*.latex
    \ set tabstop=4     |
    \ set softtabstop=4 |
    \ set shiftwidth=4  |
    \ set autoindent    |
    \ set textwidth=80  |
    \ set expandtab     |

au BufNewFile,BufRead *.ts,*.tsx,*.js,*.xml,*.html,*.css
    \ set tabstop=2     |
    \ set softtabstop=2 |
    \ set shiftwidth=2  |
    \ set autoindent    |
    \ set smartindent   |
    \ set expandtab     |

"refresh syntax on buf exit and enter for bug in styled components
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" spellcheck on
set spelllang=en_us
set spellfile=~/.config/nvim/spell/en.utf-8.add
autocmd BufNewFile,BufRead *.md,*.txt,*.tex setlocal spell

" enable folding for js and ts (may not work atm)
augroup javascript_folding
    au!
    au FileType javascript,typescript setlocal foldmethod=syntax
augroup END

" Formatting c# files
let g:uncrustifyCfgFile = '~/.uncrustify.cfg'
function! UncrustifyFunc(options) range
    exec a:firstline.','.a:lastline.'!uncrustify '.a:options
                \.' -c '.g:uncrustifyCfgFile.' -q -l '.&filetype
endfunction

command! -range Uncrustify <line1>,<line2>call UncrustifyFunc('--frag')
command! Uncrustify %call UncrustifyFunc('')
