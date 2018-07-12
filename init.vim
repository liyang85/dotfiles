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

" use everyday

Plug 'ncm2/ncm2'
" ncm2 requires nvim-yarp
Plug 'roxma/nvim-yarp'
" some completion sources
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

" " YCM is very heavy, and its installation is a big trouble!
" " macOS: Install `cmake` before installing YCM
" " CentOS: Install and enable devtoolset-6 from the SCL repo first.
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
"
" I also tried `Shougo/deoplete.nvim`, 
" but it's complicated and heavy too, so I removed it finally.

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'raimondi/delimitmate'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/vim-easy-align'
Plug 'haya14busa/vim-poweryank'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'sheerun/vim-polyglot'
" Plug 'chrisbra/NrrwRgn'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Yggdroot/indentLine'
Plug 'vim-voom/VOoM'
Plug 'glidenote/keepalived-syntax.vim'
Plug 'w0rp/ale'

" The install script must be run with a https_proxy!
" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  " Both options are optional. You don't have to install fzf in ~/.fzf
  " and you don't have to run install script if you use fzf only in Vim.

" user customized text object
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

" ppwwyyxx/vim-PinyinSearch 
" let g:PinyinSearch_Dict = $HOME . '/.vim/plugged/vim-PinyinSearch/PinyinSearch.dict'
" nnoremap ? :call PinyinSearch()<CR>
" nnoremap <Leader>pn :call PinyinNext()<CR>

" vim-pandoc/vim-pandoc
" vim-pandoc-syntax is better than built-in markdown syntax highlight,
" the built-in markdown has more beautiful color, but also has errors!
" ft=markdown is for snippets expanding.
" au MyAutoCmd BufEnter,BufReadPost,BufNewFile *.md set ft=pandoc.markdown
" let g:pandoc#modules#enabled = ["toc","folding","hypertext"]
" let g:pandoc#folding#level = 4

" raimondi/delimitmate
" Make delimitMate compatible with YCM, CANNOT use `inoremap`
imap <C-l> <Plug>delimitMateS-Tab
let delimitMate_expand_cr = 1
let delimitMate_jump_expansion = 1

" Valloric/YouCompleteMe
" turn off YCM
" nnoremap <leader><leader>y :let g:ycm_auto_trigger=0<CR>
" turn on YCM
" nnoremap <leader><leader>Y :let g:ycm_auto_trigger=1<CR>

" SirVer/ultisnips
" For YCM
" let g:UltiSnipsExpandTrigger = '<c-e>'
" For NCM
let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0
" optional
inoremap <silent> <c-u> <c-r>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<cr>

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
" let g:table_mode_corner='|'

" othree/javascript-libraries-syntax.vim
" let g:used_javascript_libs = 'jquery'

" z0mbix/vim-shfmt
" let g:shfmt_fmt_on_save = 1

" junegunn/vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" glidenote/keepalived-syntax.vim
au BufRead,BufNewFile keepalived.conf setlocal ft=keepalived

" ncm2/ncm2
"
" enable ncm2 for all buffer
autocmd BufEnter * call ncm2#enable_for_buffer()
"
" note that must keep noinsert in completeopt, the others is optional
set completeopt=noinsert,menuone,noselect
"
" supress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c
"
" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>
"
" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
"
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"
" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
    \ 'name' : 'css',
    \ 'priority': 9, 
    \ 'subscope_enable': 1,
    \ 'scope': ['css','scss'],
    \ 'mark': 'css',
    \ 'word_pattern': '[\w\-]+',
    \ 'complete_pattern': ':\s*',
    \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
    \ })

" w0rp/ale
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

