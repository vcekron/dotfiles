call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-easy-align'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using git URL
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

Plug 'SirVer/ultisnips', { 'on': [] } | Plug 'honza/vim-snippets', { 'on': [] }

augroup load_us_ycm
autocmd InsertEnter * call plug#load('ultisnips', 'vim-snippets')
                     \| autocmd! load_us_ycm 
augroup END

Plug 'Valloric/YouCompleteMe', { 'on': [] }
command! YCM call plug#load('YouCompleteMe') | call youcompleteme#Enable() | YcmCompleter

Plug 'lervag/vimtex'

call plug#end()

set number
set tabstop=4
set shiftwidth=4

set title
"set titlestring=VIM:\ %-25.55F\ %a%r%m titlelen=70

let g:hybrid_use_Xresources = 1
colorscheme hybrid

if has('gui_running')
	set guioptions-=T	"no toolbar
	set guioptions-=m	"no menu bar
	set guifont-=DejaVu_Sans_Mono:h12:cANSI
endif

"let g:ycm_global_ycm_extra_conf = '/path/to/the/file'

"Recommendations from Vim tutorial
inoremap jk <ESC>
let mapleader = "\<Space>"
filetype plugin indent on
syntax on
set encoding=utf-8

