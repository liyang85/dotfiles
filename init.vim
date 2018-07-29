set nocp
" vim: set fdm=marker:

" ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
" vim-plug plugin manager {{{1
" ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====

" Install vim-plug itself automatically
" https://github.com/junegunn/vim-plug/wiki/faq#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" The install script must be run with a https_proxy!
" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  " Both options are optional. You don't have to install fzf in ~/.fzf
  " and you don't have to run install script if you use fzf only in Vim.

" Auto-completion
"
" " ncm2 is an upgrade of nvim-completion-manager,
" " and the old version has been separated to multiple new small plugins.
" " This structure is good for the developer but the users!
" " Maybe I will try it when a stable version is released.
" Plug 'ncm2/ncm2'
" " ncm2 requires nvim-yarp
" Plug 'roxma/nvim-yarp'
"
" " YCM is very heavy, and its installation is a big trouble!
" " macOS: Install `cmake` before installing YCM
" " CentOS: Install and enable devtoolset-6 from the SCL repo first.
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
"
" Now I think deoplete is the simplest auto-completion solution.
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Indent line
"
" " indentLine has performance issue, see details at:
" " https://github.com/Yggdroot/indentLine/issues?utf8=%E2%9C%93&q=is%3Aissue+performance
" Plug 'Yggdroot/indentLine'
Plug 'nathanaelkane/vim-indent-guides'

" Comment
"
" " Use nerdcommenter or tcomment to replace vim-commentary if you want to 
" " re-comment an XML comment, because the latter has an XML compatibility issue:
" "   1. https://github.com/tpope/vim-commentary/issues/65
" "   2. https://www.reddit.com/r/vim/comments/26mszm/what_is_everyones_favorite_commenting_plugin_and/chtviv7
" " But tcomment always encodes XML's special character, that's BAD.
" Plug 'tomtom/tcomment_vim'
" Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-commentary'

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'raimondi/delimitmate'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/vim-easy-align'
Plug 'haya14busa/vim-poweryank'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
" Plug 'chrisbra/NrrwRgn'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-voom/VOoM'
Plug 'w0rp/ale'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
"
" Ragtag is a set of mappings for HTML, XML, PHP, ASP, eRuby, JSP, and more.
" This includes a couple of "make last word into a tag pair" maps, 
" a doctype map (inserts in XML), a "close last tag" map ...
"
" Usage looks like this (let `|` mark cursor position) you type:
"	span|
" press `CTRL+x SPACE` and you get
"	<span>|</span>
" You can also use `CTRL+x ENTER` instead of `CTRL+x SPACE`, and you get
"	<span>
"	|
"	</span>
Plug 'tpope/vim-ragtag'
" 
" This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically 
" based on the current file, or, in the case the current file is new, blank, 
" or otherwise insufficient, by looking at other files of the same type in the 
" current and parent directories. In lieu of adjusting 'softtabstop', 'smarttab' is enabled.
Plug 'tpope/vim-sleuth'

Plug 'sheerun/vim-polyglot'
Plug 'glidenote/keepalived-syntax.vim'

" User customized text object
Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter'
Plug 'Julian/vim-textobj-variable-segment'
Plug 'paulhybryant/vim-textobj-path'
Plug 'jceb/vim-textobj-uri'

" shell
" Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }

" front-end development
Plug 'mattn/emmet-vim'
" Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'chrisbra/colorizer'

" markdown
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
" Plug 'dhruvasagar/vim-table-mode'

" Chinese
" Auto detect CJK and Unicode file encodings
Plug 'mbbill/fencview'
" search Chinese characters
" Plug 'ppwwyyxx/vim-PinyinSearch'

" Others
" Produce increasing/decreasing columns of numbers, dates, or daynames
Plug 'vim-scripts/VisIncr'

call plug#end()

" enable built-in matchit plugin
" packadd! matchit

" ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
" Settings from tpope/vim-sensible {{{1
" ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====

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

" ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
" Settings from myself {{{1
" ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====

set nu
set rnu
set nowrap
set cursorline
" set cursorcolumn
" set colorcolumn=80
set background=dark

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

" Vim-polyglot contains a lang pack (pearofducks/ansible-vim) for ansible,
" which includes syntax, indent and ftplugin settings.
" If `smartindent` off (default), a list will get wrong indentation,
" set it on will fix the problem.
set smartindent

" set 'ts' and 'sw' will mess up files: it only looks good in vim! 
" set 'softtabstop' will mix tabs and spaces.
"
" Formatting should be the task of the IDE. So, do NOT set them!
" https://softwareengineering.stackexchange.com/questions/197838/what-are-the-downsides-of-mixing-tabs-and-spaces
"
" " Number of spaces that a <Tab> in the file counts for.
" set tabstop=4
"
" " Number of spaces to use for each step of (auto)indent.
" set shiftwidth=4

" in insert mode, use `ctrl-v u 00b6` to input utf-8 character ¶ (PARAGRAPH SIGN)
" as explained in `:h utf-8-typing`
" https://wincent.com/blog/making-vim-highlight-suspicious-characters
set listchars=nbsp:¬,eol:¶,tab:>-,trail:•,extends:»,precedes:«

" To solve the 'crontab: temp file must be edited in place' issue on macOS
" this is the simplest way:
set backupskip=/tmp/*,/private/tmp/*

" ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
" Settings for GUI Vim {{{1
" ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
 
colorscheme desert
" After many many times tried, I am sure Consolas is the best font for 
" displaying Chinese & Latin characters together on macOS
" set guifont=Consolas:h14
" set linespace=2

" ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
" Key mappings & AutoCommands {{{1
" ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====

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

" ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====
" Settings for plugins {{{1
" ===== ===== ===== ===== ===== ===== ===== ===== ===== ===== =====

" " ppwwyyxx/vim-PinyinSearch 
" let g:PinyinSearch_Dict = $HOME . '/.vim/plugged/vim-PinyinSearch/PinyinSearch.dict'
" nnoremap ? :call PinyinSearch()<CR>
" nnoremap <Leader>pn :call PinyinNext()<CR>

" " vim-pandoc/vim-pandoc
" " vim-pandoc-syntax is better than built-in markdown syntax highlight,
" " the built-in markdown has more beautiful color, but also has errors!
" " ft=markdown is for snippets expanding.
" au MyAutoCmd BufEnter,BufReadPost,BufNewFile *.md set ft=pandoc.markdown
" let g:pandoc#modules#enabled = ["toc","folding","hypertext"]
" let g:pandoc#folding#level = 4

" raimondi/delimitmate
" Make delimitMate compatible with YCM, CANNOT use `inoremap`
imap <C-l> <Plug>delimitMateS-Tab
let delimitMate_expand_cr = 1
let delimitMate_jump_expansion = 1

" Valloric/YouCompleteMe
" " turn off YCM
" nnoremap <leader><leader>y :let g:ycm_auto_trigger=0<CR>
" " turn on YCM
" nnoremap <leader><leader>Y :let g:ycm_auto_trigger=1<CR>

" SirVer/ultisnips
" Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" " For YCM
" let g:UltiSnipsExpandTrigger = '<c-e>'

" netrw (Vim built-in)
" preview window shown in a vertically split window
let g:netrw_preview   = 1
" tree style listing
let g:netrw_liststyle = 3
" " percentage of the current netrw buffer's window to be used for the new window
" let g:netrw_winsize   = 70

" ctrlpvim/ctrlp.vim
let g:ctrlp_cmd = 'CtrlPBuffer'

" " dhruvasagar/vim-table-mode
" let g:table_mode_corner='|'

" " othree/javascript-libraries-syntax.vim
" let g:used_javascript_libs = 'jquery'

" " z0mbix/vim-shfmt
" let g:shfmt_fmt_on_save = 1

" junegunn/vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" glidenote/keepalived-syntax.vim
au BufRead,BufNewFile keepalived.conf setlocal ft=keepalived

" w0rp/ale
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Shougo/deoplete.nvim
let g:deoplete#enable_at_startup = 0
autocmd InsertEnter * call deoplete#enable()
"
" The default binding for vim popup selection is <c-n> , <c-p> besides arrow key.
" Read some more on `:help popupmenu-keys` or `:help ins-completion`
"
" disable deoplete when using vim-multiple-cursors
function g:Multiple_cursors_before()
	call deoplete#custom#buffer_option('auto_complete', v:false)
endfunction
function g:Multiple_cursors_after()
	call deoplete#custom#buffer_option('auto_complete', v:true)
endfunction

" " scrooloose/nerdcommenter
" " Add spaces after comment delimiters by default
" let g:NERDSpaceDelims = 1

" nathanaelkane/vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
