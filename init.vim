call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/vim-easy-align'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using git URL
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'https://github.com/vim-scripts/ReplaceWithRegister.git'
Plug 'https://github.com/tomtom/tcomment_vim.git'
Plug 'https://github.com/wellle/targets.vim.git'
Plug 'https://github.com/michaeljsmith/vim-indent-object.git'
Plug 'https://github.com/tpope/vim-surround.git'

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

command! Deo call deoplete#enable()

let g:airline_powerline_fonts=1
let g:airline_theme = 'hybrid'

let g:hybrid_use_Xresources = 1
colorscheme hybrid

set encoding=utf-8
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set title
" Don't select line numbers with mouse
set mouse=a
" Recommendations from Vim tutorial
filetype plugin indent on
syntax on
inoremap jk <ESC>
let mapleader = "\<Space>"
" Map j/k to move by visual lines when not using count
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
" Map operation on entire buffer
onoremap af :<C-u>normal! ggVG<CR>

function! NumberToggle()
	if(&relativenumber == 1)
		set relativenumber&
	else
		set relativenumber
	endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

if has('gui_running')
	set guioptions-=T	"no toolbar
	set guioptions-=m	"no menu bar
	set guifont-=DejaVu_Sans_Mono:h12:cANSI
endif
