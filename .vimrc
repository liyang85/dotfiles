set nocp

" ===== ===== ===== ===== ==== ======
" vim-plug plugin manager
" ===== ===== ===== ===== ==== ======

" Install vim-plug itself automatically
" https://github.com/junegunn/vim-plug/wiki/faq#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/vim-scripts/VisIncr.git'

" Install `cmake` before YCM on macOS
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'chrisbra/NrrwRgn'
Plug 'easymotion/vim-easymotion'
Plug 'godlygeek/tabular'
Plug 'ppwwyyxx/vim-PinyinSearch'
Plug 'raimondi/delimitmate'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'terryma/vim-multiple-cursors'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'sheerun/vim-polyglot'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'chrisbra/colorizer'
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }
Plug 'WolfgangMehner/bash-support'
Plug 'haya14busa/vim-poweryank'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline'

" user customized text object
Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter'
Plug 'Julian/vim-textobj-variable-segment'
Plug 'paulhybryant/vim-textobj-path'
Plug 'jceb/vim-textobj-uri'

call plug#end()

" enable built-in matchit plugin
" packadd! matchit

" ===== ===== ===== ===== ==== ======
" Settings from tpope/vim-sensible
" ===== ===== ===== ===== ==== ======

filetype plugin indent on
syntax enable
set autoindent
set backspace=2
set smarttab
set incsearch
set laststatus=2
set ruler
set wildmenu
set scrolloff=1
set sidescrolloff=5
set display+=lastline
set autoread

" ===== ===== ===== ===== ==== ======
" Settings from myself
" ===== ===== ===== ===== ==== ======

set nu
set rnu
set cursorline
" set cursorcolumn
" set colorcolumn=80

" for Chinese characters
set formatoptions+=mB
set linebreak
set breakat+="，。？！：、；"

set autochdir
set cmdheight=2
set showcmd
set hlsearch
set ignorecase
set smartcase
set modeline

" set ts+sw will mess up files: it looks good in vim only! 
" set softtabstop will mix tabs and spaces
" Formatting should be the task of the IDE. So, do NOT set them!
" https://softwareengineering.stackexchange.com/questions/197838/what-are-the-downsides-of-mixing-tabs-and-spaces
" set tabstop=4
" set shiftwidth=4

" in insert mode, use `ctrl-v u 00b6` to input utf-8 character ¶ (PARAGRAPH SIGN)
" as explained in `:h utf-8-typing`
" https://wincent.com/blog/making-vim-highlight-suspicious-characters
set listchars=nbsp:¬,eol:¶,tab:>-,trail:•,extends:»,precedes:«

" To solve the 'crontab: temp file must be edited in place' issue on macOS
" this is the simplest way:
set backupskip=/tmp/*,/private/tmp/*

" ===== ===== ===== ===== ==== ======
" Only works in GUI Vim
" ===== ===== ===== ===== ==== ======
 
colorscheme desert
" After many many times tried, I am sure Consolas is the best font for 
" displaying Chinese & Latin characters together on macOS
set guifont=Consolas:h14
set linespace=2

" ===== ===== ===== ===== ==== ======
" Key mappings & Autocommands
" ===== ===== ===== ===== ==== ======

" Set augroup
" https://github.com/terryma/dotfiles/blob/master/.vimrc
" http://learnvimscriptthehardway.onefloweroneworld.com/chapters/14.html
augroup MyAutoCmd
	autocmd!
augroup END

let mapleader=","
" let maplocalleader="\/"

noremap <space> :
inoremap jj <esc>

" Jump to a window
nnoremap <leader>wj :wincmd j<cr>
nnoremap <leader>wk :wincmd k<cr>
nnoremap <leader>wh :wincmd h<cr>
nnoremap <leader>wl :wincmd l<cr>
" Move window
nnoremap <leader>wJ :wincmd J<CR>
nnoremap <leader>wK :wincmd K<CR>
nnoremap <leader>wH :wincmd H<CR>
nnoremap <leader>wL :wincmd L<CR>
" Resize splits when the window is resized
au MyAutoCmd VimResized * :wincmd = 

" Bash like keys for the command line
cnoremap <c-a> <home>
" Ctrl-[hl]: Move left/right by word
cnoremap <c-h> <s-left>
cnoremap <c-l> <s-right>

" Edit and reload .vimrc quickly
nnoremap <leader>ev :vs $MYVIMRC<CR>
au MyAutoCmd BufWritePost $MYVIMRC source $MYVIMRC

" Copy current file's Name to the system clipboard
" `:help registers`, `:help expand`
:nmap <leader>cn :let @+ = expand("%")<cr>
" Copy current file's Path to the system clipboard
:nmap <leader>cp :let @+ = expand("%:p")<cr>

" ===== ===== ===== ===== ==== ======
" Settings for plugins
" ===== ===== ===== ===== ==== ======

" ppwwyyxx/vim-PinyinSearch 
let g:PinyinSearch_Dict = $HOME . '/.vim/plugged/vim-PinyinSearch/PinyinSearch.dict'
nnoremap ? :call PinyinSearch()<CR>
nnoremap <Leader>pn :call PinyinNext()<CR>

" vim-pandoc/vim-pandoc
" vim-pandoc-syntax is better than built-in markdown syntax highlight.
" built-in markdown has more beautiful color, but also has errors!
" set ft=markdown is for snippets expanding.
au MyAutoCmd BufEnter,BufReadPost,BufNewFile *.md set ft=pandoc.markdown
let g:pandoc#modules#enabled = ["toc","folding","hypertext"]
let g:pandoc#folding#level = 4

" raimondi/delimitmate
" Make delimitMate compatible with YCM, CANNOT use `inoremap`
imap <C-l> <Plug>delimitMateS-Tab
let delimitMate_expand_cr = 1
let delimitMate_jump_expansion = 1

" Valloric/YouCompleteMe
" turn off YCM
nnoremap <leader><leader>y :let g:ycm_auto_trigger=0<CR>
" turn on YCM
nnoremap <leader><leader>Y :let g:ycm_auto_trigger=1<CR>

" SirVer/ultisnips
let g:UltiSnipsExpandTrigger = '<c-e>'

" netrw (built-in)
" preview window shown in a vertically split window
let g:netrw_preview   = 1
" tree style listing
let g:netrw_liststyle = 3
" percentage of the current netrw buffer's window to be used for the new window
" let g:netrw_winsize   = 70

" ctrlpvim/ctrlp.vim
let g:ctrlp_cmd = 'CtrlPBuffer'

" dhruvasagar/vim-table-mode
let g:table_mode_corner='|'

" othree/javascript-libraries-syntax.vim
let g:used_javascript_libs = 'jquery'

" z0mbix/vim-shfmt
" let g:shfmt_fmt_on_save = 1

