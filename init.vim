call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-easy-align'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using git URL
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

call plug#end()

command! Deo call deoplete#enable()

set number
set tabstop=4
set shiftwidth=4

set title
"set titlestring=VIM:\ %-25.55F\ %a%r%m titlelen=70

"Don't select line numbers with mouse
set mouse=a

let g:hybrid_use_Xresources = 1
colorscheme hybrid

if has('gui_running')
	set guioptions-=T	"no toolbar
	set guioptions-=m	"no menu bar
	set guifont-=DejaVu_Sans_Mono:h12:cANSI
endif

"Recommendations from Vim tutorial
inoremap jk <ESC>
let mapleader = "\<Space>"
filetype plugin indent on
syntax on
set encoding=utf-8

