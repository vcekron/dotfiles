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
Plug 'https://github.com/tpope/vim-fugitive'

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
Plug 'lervag/vimtex'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

if !exists('g:deoplete#omni_patterns')
	let g:deoplete#omni_patterns = {}
endif
let g:deoplete#omni_patterns.tex =
	\ '\v\\%('
	\ . '\a*cite\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
	\ . '|\a*ref%(\s*\{[^}]*|range\s*\{[^,}]*%(}\{)?)'
	\ . '|hyperref\s*\[[^]]*'
	\ . '|includegraphics\*?%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
	\ . '|%(include%(only)?|input)\s*\{[^}]*'
	\ . '|\a*(gls|Gls|GLS)(pl)?\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
	\ . '|includepdf%(\s*\[[^]]*\])?\s*\{[^}]*'
	\ . '|includestandalone%(\s*\[[^]]*\])?\s*\{[^}]*'
	\ . ')\m'

let g:airline_powerline_fonts=1
let g:airline_theme = 'hybrid'

let g:hybrid_use_Xresources = 1
colorscheme hybrid

let g:tex_flavor = "latex"
let g:vimtex_view_method = 'zathura'

set encoding=utf-8
set number
set relativenumber
set showcmd
set backspace=
set tabstop=4
set shiftwidth=4
set title
" Don't select line numbers with mouse
set mouse=a
" Recommendations from Vim tutorial
filetype plugin indent on
syntax on
inoremap jk <ESC>
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

" Save on Ctrl-S and update on F2
nmap <c-s> :w<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>

nmap <F2> :update<CR>
vmap <F2> <Esc><F2>gv
imap <F2> <c-o><F2>

" Toggle absolute line numbers
nmap <silent> <leader>n :call NumberToggle()<CR>

" Toggle spellcheck
nmap <silent> <leader>s :set spell!<CR>

" Toggle autocomplete
nmap <silent> <leader>d :call deoplete#enable()<CR>

" Hide highlights
nmap <c-h> :noh<CR>
vmap <c-h> <Esc><c-h>
imap <c-h> <c-o><c-h>

" Tweak behaviour of return in autocomplete menu
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
