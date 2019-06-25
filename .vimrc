
set nocompatible              
" required 
set encoding=utf-8 
set nowrap 
set number 
set hlsearch 
syntax on 


" Install theme docs
" cd ~/.vim/colors
" wget https://raw.githubusercontent.com/aonemd/kuroi.vim/master/colors/kuroi.vim
set background=dark
color kuroi

" Install theme docs
" https://draculatheme.com/vim/
" color dracula

filetype off                  
" required
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'w0rp/ale'
Plug 'Chiel92/vim-autoformat'
Plug 'OrangeT/vim-csharp'
Plug 'leafgarland/typescript-vim'
Plug 'python-mode/python-mode'
Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'liuchengxu/space-vim-dark'
Plug 'python-rope/ropevim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'mgedmin/coverage-highlight.vim'
Plug 'vim-scripts/mako.vim'
Plug 'vim-scripts/vim-auto-save'
Plug 'wavded/vim-stylus'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
" Front-end related plugins:
Plug 'posva/vim-vue'
Plug 'mattn/emmet-vim'
" Android related plugins:
Plug 'wincent/command-t' 
Plug 'terryma/vim-multiple-cursors'
Plug 'hsanson/vim-android'
Plug 'ap/vim-css-color'
Plug 'JulesWang/css.vim'
Plug 'dgraham/vim-eslint'
Plug 'Valloric/YouCompleteMe'
Plug 'wincent/command-t'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdcommenter'
Plug 'yuttie/comfortable-motion.vim'
call plug#end()
set cursorline
" hi CursorLine <guibg></guibg>00000 ctermbg=0 gui=none
" set guifont=Meslo\ LG\ M\ Regular\ for\ Powerline:h11
map \ :NERDTreeToggle<cr>

""
filetype plugin indent on    " required
" Using system's clipboard
set clipboard=unnamed
" Spell checking
setlocal spell spelllang=en_us
set nospell
" split and navigation
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=79
set colorcolumn=79

" Enable folding with the space bar
nnoremap <space> za

set textwidth=79
set tabstop=4
set softtabstop=4
set autoindent
set cindent
set noexpandtab
set shiftwidth=4   
 
" PEP8
au BufNewFile,BufRead *.py  
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal textwidth=79 |
    \ setlocal expandtab |
    \ setlocal autoindent |
    \ setlocal fileformat=unix

" js, css , HTML
au BufNewFile,BufRead *.js,*.json,*.html,*.css,*.styl,*.scss,*.ts,*.cshtml,*.vue
    \ setlocal tabstop=2 |
    \ setlocal softtabstop=2 |
    \ setlocal shiftwidth=2 |
    \ setlocal textwidth=99 |
	\ setlocal colorcolumn=99 |
    \ setlocal expandtab |
    \ setlocal autoindent |

" c
au BufRead,BufNewFile *.c,*.h
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal textwidth=79 |
    \ setlocal expandtab |
    \ setlocal autoindent |
    \ setlocal fileformat=unix

" Other (miscellaneous)
au BufRead,BufNewFile *.md,*.txt,*.rst
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal textwidth=79 |
    \ setlocal expandtab |
    \ setlocal autoindent |
"    \ setlocal fileformat=unix

" ignore files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$', '^__pycache__$', '\.egg-info$', '^build$', '^dist$', '\.so$', '\.o$'] 
set runtimepath+=~/.vim/bundle/nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if !argc() | NERDTree | endif
let g:NERDTreeShowIgnoredStatus = 1

" set shellcmdflag=-ic
let $BASH_ENV = "~/.bash_aliases"

fun! NoseTestCurrentScope()
    " Find function under cursor
    let l:scope = ""
    let l:save = winsaveview()
    normal [[
    let l:class_matches = filter(matchlist(getline('.'), '\s*class \(\w*\)(.*'), 'v:val !=# ""')
    if len(l:class_matches) > 0
        let l:scope = l:class_matches[1]
    endif
    call winrestview(l:save)
    normal [m
    let l:func_matches = filter(matchlist(getline('.'), '\s*\(async\sdef|def\)\s\(test_[\w_]*\).*'), 'v:val !=# ""')
    if len(l:func_matches) > 1
        let l:scope = join([l:scope, l:func_matches[1]], '.')
    endif
    execute ':!nosetests -s --pudb %\:' . l:scope
    call winrestview(l:save)
endfun

let test#python#runner = 'nose2'

augroup python_test
    autocmd!
    autocmd Filetype python nnoremap <Leader>t :call NoseTestCurrentScope()<CR>
augroup end




" python-mode
" let g:pymode_virtualenv = 1
" let g:pymode_virtualenv_path = $VIRTUAL_ENV
" let g:pymode_run = 1
" let g:pymode_run_bind = '<leader>r'
" let g:pymode_breakpoint = 1
" let g:pymode_breakpoint_bind = '<leader>b'
" let g:pymode_python = 'python'
let g:pymode_breakpoint_cmd = 'from pudb import set_trace; set_trace()'
let g:pymode_python = 'python3'

" Rope
let g:pymode_rope = 1

" Lint
" Lint is activated to fix pep8 errors
let g:pymode_lint = 1
let g:pymode_lint_on_write = 1

"change parameters to open go to definition in vertical splited window
"possible parameters are 'e', 'new', 'vnew
let g:pymode_rope_goto_definition_cmd = 'new'
let g:pymode_rope_organize_imports_bind = '<Leader>q'
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_autoimport = 1
let g:pymode_rope_rename_bind = '<C-c>rr'
let g:user_emmet_expandabbr_key = '<tab>'
" let g:user_emmet_mode='a'

set completeopt=longest,menuone
let ropevim_vim_completion=1
let ropevim_extended_complete=1
map <C-]> <C-C>g
map <Leader>i <C-c>ro

" Bash aliases
let $BASH_ENV = "~/.bash_aliases"

" Python code comment
vnoremap <silent> # :s/^/#/<cr>:noh<cr>
vnoremap <silent> -# :s/^#//<cr>:noh<cr>

nnoremap <Leader>c :HighlightCoverage<CR>
autocmd FileType python nnoremap <buffer> <F9> :write<cr> :exec '!python' shellescape(@%, 1)<cr>
autocmd FileType python nnoremap <buffer> <F8> :write<cr> :exec '!pytest -vvv' shellescape(@%, 1)<cr>
autocmd FileType python nnoremap <buffer> <F7> :write<cr> :exec '!pytest'<cr>
noremap <F10> :write<cr> :exec '!coverage run --source $(python -c "from setuptools import find_packages; print(find_packages()[0])") $(which nosetests)'<cr>

" autocmd FileType python,*.pyx nnoremap <Leader>B :exec '!python setup.py build_ext --force --inplace --define=CYTHON_TRACE'<cr>
" nnoremap <Leader>B  :write<cr> :exec '!python setup.py build_ext --force --inplace --define=CYTHON_TRACE'<cr>
" nnoremap <Leader>m  :write<cr> :exec '!make'<cr>
" nnoremap <Leader>f  :write<cr> :exec '!make flash'<cr>

" let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_no_updatetime = 1  " do not change the 'updatetime' option
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode
autocmd InsertLeave * write

set t_Co=256

nmap oo o<Esc>k

" Added sopport for HTML (and other languages) matching tags with %
runtime macros/matchit.vim

" Press Leader+Space to turn off highlighting and clear any message already displayed.
nnoremap <Leader><Space> :nohlsearch<Bar>:echo<CR>

" Using local config. Uncomment line below. 
" source ~/.vimrc-local
set encoding=UTF-8
"set guifont=<FONT_NAME>:h<FONT_SIZE>
set guifont=DroidSansMono\ 10
nnoremap ss i<space><esc>
" nnoremap cc <Leader>ci
" map cc <Plug>NERDCommenterToggle
imap jj <Esc>
xnoremap p pgvy
set cursorline
" nnoremap cc <Leader>ci
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules,*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/node_modules/*,*/.DS_Store,*/vendor
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹ ",
    \ "Staged"    : "✚ ",
    \ "Untracked" : "✭ ",
    \ "Renamed"   : "➜ ",
    \ "Unmerged"  : "═ ",
    \ "Deleted"   : "✖ ",
    \ "Dirty"     : "☂ ",
    \ "Clean"     : "✔︎ ",
    \ 'Ignored'   : "♣ ",
    \ "Unknown"   : "? "
    \ }

" https://github.com/w0rp/ale#usage-fixing
let g:ale_fixers = ['eslint']
let g:ale_fix_on_save = 0
let g:ale_sign_error = '✖ '
let g:ale_sign_warning = '☂'
let g:ale_linter_aliases = {'vue': ['css', 'eslint', 'vue']}
let g:ale_linters = {'vue': ['stylelint', 'eslint', 'vue']}
highlight clear ALEWarningSign
let g:ale_set_highlights = 0
highlight ALEWarning ctermbg=DarkMagenta
augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

