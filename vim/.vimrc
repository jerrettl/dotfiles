execute pathogen#infect()

set nocompatible
syntax on
filetype plugin indent on
set mouse=a
let mapleader=","

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

set background=dark
colorscheme solarized
let g:solarized_termcolors=256
let &t_Co=256

set tabstop=2
set backspace=indent,eol,start
set autoindent
set copyindent
set number
set shiftwidth=2
set shiftround
set showmatch
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch
set title
set noerrorbells
set nobackup
set noswapfile
set wildmenu
set clipboard=unnamedplus
set pastetoggle=<F2>


nmap ; :
nmap <up> gk
nmap <down> gj
nmap <silent> ,/ :nohlsearch<CR>
nmap J gj
nmap K gk
nmap <C-d> :sh<cr>
" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
"command -nargs=0 -bar Update if &modified
"			\|	if empty(bufname('%'))
"			\|		browse confirm write
"			\|	else
"			\|		confirm write
"			\|	endif
"			\|endif
"nnoremap <silent> <C-S> :<C-u>Update<CR>
nmap <C-g> :%s/\s\+$//<cr>

cmap w!! w !sudo tee % >/dev/null
cmap Q q

"imap <C-s> <C-o>:s<CR>
"imap <C-n> :set relativenumber<CR>
"imap <C-m> :set number<CR>
"imap <C-s> <C-o> :Update<CR>
imap jk <esc>

"What am I doing just give me Ctrl-S saving
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" Airline
let g:airline#extensions#synastic#enables = 1
set laststatus=2
let g:airline_powerline_fonts = 1


" Neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#dictionary#dictionaries = {
			\ 'default' : '',
			\ 'vimshell' : $HOME.'/.vimshell_hist',
			\ 'scheme' : $HOME.'/.gosh_completions'
			\ }
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'


autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
