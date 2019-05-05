" Set leader keys
"let mapleader=","
"let maplocalleader=","

call plug#begin('~/.config/nvim/plugged')

function! DoRemote(arg)
	UpdateRemotePlugins
endfunction

Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-github-dashboard'
Plug 'kopischke/vim-stay'
Plug 'lervag/vimtex'
Plug 'liuchengxu/vim-which-key'
Plug 'luochen1990/rainbow'
Plug 'mbbill/undotree'
Plug 'michaeljsmith/vim-indent-object'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'wellle/targets.vim'

" Completion libraries
"Plug 'zchee/deoplete-jedi'

" On-demand loading
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

call plug#end()

" Plugin settings

" airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme = 'hybrid'
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'

" deoplete settings

let g:deoplete#enable_at_startup = 1
" deoplete vimtex integration
if !exists('g:deoplete#omni#input_patterns')
	let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
" deoplete-jedi settings
"autocmd CompleteDone * pclose!
"autocmd FileType python setlocal completeopt-=preview

" neosnippet settings
let g:neosnippet#snippets_directory = '~/.config/nvim/snippets'
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#expand_word_boundary = 1

" nerdtree settings

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
" Open nerdtree if nvim launched without argument
autocmd StdinReadPre * let s:std_in = 1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Open nerdtree if nvim launched with directory as argument
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd p | endif
" Close nvim if only nerdtree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Rainbow parenthesis settings
let g:rainbow_active = 1
let g:rainbow_conf = {
	\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	\	'ctermfgs': ['red', 'yellow', 'lightyellow', 'green', 'blue', 'magenta'],
	\	'operators': '',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
	\		},
	\		'lisp': {
	\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\		'html': {
	\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
	\		},
	\		'css': 0,
	\	}
	\}

" vimtex settings
let g:tex_flavor = "latex"
let g:vimtex_view_method = "zathura"
let g:vimtex_compiler_progname = "nvr"
let g:vimtex_complete_close_braces = 1

" undotree settings
if !exists('g:undotree_WindowLayout')
	let g:undotree_WindowLayout = 3
endif
if !exists('g:undotree_HelpLine')
	let g:undotree_HelpLine = 0
endif

" vim-stay settings
set viewoptions=cursor,folds,slash,unix

" Theme settings
let g:hybrid_custom_term_colors = 1
"set background=dark
set background=light
colorscheme hybrid

" Misc settings
set encoding=utf-8
set number
set relativenumber
set showcmd
set backspace=
set nojoinspaces
set tabstop=4
set shiftwidth=4
set title
set ignorecase smartcase
set cursorline
set lazyredraw
set linebreak
set hidden
set wildmenu
set wildmode=list:longest,full
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.jpeg,*.png,*.xpm,*.gif
" Show indents and wraps
set list
set showbreak=↪\
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨
" Don't select line numbers with mouse
set mouse=a
" Recommendations from Vim tutorial
filetype plugin indent on
syntax on
" Persistent undo
if has("persistent_undo")
	set undodir=~/.undodir/
	set undofile
endif

" User alias
command Fw w !sudo tee %

" General mappings

nnoremap <silent> <leader> :WhichKey '<Bslash>'<CR>

" Map homerow keys to resemble US layout
"noremap ö [
"noremap Ö {
"noremap ä ]
"noremap Ä }
" Map B/E to beginning/end of line
nnoremap B ^
nnoremap E $
onoremap B ^
onoremap E $
" Movement in insert mode
inoremap <M-h> <C-o>h
inoremap <M-l> <C-o>l
inoremap <M-j> <C-o>j
inoremap <M-k> <C-o>k
" Map meta-q to exit insert mode
inoremap <M-n> <ESC>
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
" List registers
nnoremap <silent> <Leader>r :registers "0123456789abcdefghijklmnopqrstuvwxyz*+.<CR>
" + and 0 register mappings
nnoremap <silent> <Leader>y "+y
vnoremap <silent> <Leader>y "+y
nnoremap <silent> <Leader>p "+p
nnoremap <silent> <Leader>P "+P
nnoremap <silent> <Leader>0 "0p
nnoremap <silent> <Leader>= "0P
" Hide highlights
nmap <silent> <Leader>h :noh<CR>
" Toggle visible indents and wraps
nmap <silent> <Leader>vi :set list!<CR>
" Toggle spellcheck
nmap <silent> <Leader>s :set spell!<CR>
" Create indent folds then return to manual fold method
nmap <silent> <Leader>f :setlocal foldmethod=indent<CR>:setlocal foldmethod=manual<CR>
" Erase all folds
nmap <silent> <Leader>F zE
" Toggle folds with space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
" Buffer navigation
nnoremap <M-o> :e
nnoremap <M-t> :enew<CR>
nnoremap <M-S-tab> :bprevious<CR>
nnoremap <M-tab> :bnext<CR>
nnoremap <M-d> :bdelete<CR>
nnoremap <M-u> :edit #<CR>
" Highlight last inserted text
nnoremap gV `[v`]

" Plugin mappings

" Toggle autocomplete
nmap <silent> <Leader>d :call deoplete#toggle()<CR>
" Toggle nerdtree
nmap <silent> <Leader>e :NERDTreeToggle<CR>
" Toggle undotree
nmap <silent> <Leader>u :UndotreeToggle<CR>
" Navigate completion menu with tab/s-tab
inoremap <expr><S-tab> pumvisible() ? "\<C-n>" : "\<S-tab>"
" Cancel suggestion or snippet insertion and close popup menu with M-Space
inoremap <expr><C-Space> pumvisible() ? "\<C-e>" : ""

" Disable menu navigation with arrow keys
inoremap <expr><Up> pumvisible() ? "\<C-y>\<Up>" : "\<Up>"
inoremap <expr><Down> pumvisible() ? "\<C-y>\<Down>" : "\<Down>"
