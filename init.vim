" Set leader keys
let mapleader="'"
let maplocalleader="'"

call plug#begin('~/.config/nvim/plugged')

function! DoRemote(arg)
	UpdateRemotePlugins
endfunction

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/vim-easy-align'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'lervag/vimtex'

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

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

call plug#end()

" Plugin settings
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

let g:tex_flavor = "latex"
let g:vimtex_view_method = 'zathura'

let NERDTreeMinimalUI=1

" Theme settings
let g:hybrid_use_Xresources = 1
colorscheme hybrid

" Misc settings
set encoding=utf-8
set number
set relativenumber
set showcmd
set backspace=
set tabstop=4
set shiftwidth=4
set title
set ignorecase
set cursorline
set lazyredraw
" Don't select line numbers with mouse
set mouse=a
" Recommendations from Vim tutorial
filetype plugin indent on
syntax on

" General mappings

" Map homerow keys to resemble US layout
noremap ö ;
noremap Ö :
noremap ä '
noremap Ä "
" Map jk to exit insert mode
inoremap jk <ESC>
" Map j/k to move by visual lines when not using count
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
" Map operation on entire buffer
onoremap af :<C-u>normal! ggVG<CR>
" Toggle absolute line numbers
function! NumberToggle()
	if(&relativenumber == 1)
		set relativenumber&
	else
		set relativenumber
	endif
endfunc
nmap <silent> <Leader>n :call NumberToggle()<CR>
" Save on Ctrl-S and update on F2
nmap <c-s> :w<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>
nmap <F2> :update<CR>
vmap <F2> <Esc><F2>gv
imap <F2> <c-o><F2>
" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
" Hide highlights
nmap <c-h> :noh<CR>
vmap <c-h> <Esc><c-h>
imap <c-h> <c-o><c-h>
" Toggle spellcheck
nmap <silent> <Leader>s :set spell!<CR>
" Create indent folds then return to manual fold method
nmap <silent> <localleader>f :setlocal foldmethod=indent<CR>:setlocal foldmethod=manual<CR>
" Toggle folds with space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
" Erase all folds with Ctrl-Space
nnoremap <C-Space> zE

" Plugin mappings

" Toggle autocomplete
nmap <silent> <Leader>d :call deoplete#enable()<CR>
" Toggle nerdtree
nmap <silent> <Leader>e :NERDTreeToggle<CR>
" Use TAB for deoplete navigation
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<tab>"
inoremap <expr><S-tab> pumvisible() ? "\<C-p>" : "\<S-tab>"
" Hide popup menu with ESC
inoremap <expr><Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
" Expand snippet and close popup menu with Enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
