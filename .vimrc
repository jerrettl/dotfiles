" Location: ~/.vimrc

set nocompatible
filetype off

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-syntastic/syntastic'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
"Plugin 'altercation/vim-colors-solarized'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-latex/vim-latex'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'mattn/emmet-vim'
Plugin 'alvan/vim-closetag'
"Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdcommenter'
Plugin 'hrother/offlineimaprc.vim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'itchyny/lightline.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'vim-scripts/indentpython.vim' " Correct python indentation
Plugin 'nvie/vim-flake8' " PEP8 checking
Plugin 'Yggdroot/indentLine' " Indent guides
Plugin 'davidhalter/jedi-vim' " Python autocompletion


call vundle#end()
filetype plugin indent on


" Basics
set encoding=utf8
syntax on
set mouse=a
let mapleader=","
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
set linebreak
set noshowmode
set noesckeys
"set guifont=PragmataProMono\ Nerd\ Font\ Mono\ 11
set guifont=PragmataProMono_Nerd_Font_Mono:h10:w5
set laststatus=2
set shell=/bin/bash
set display+=lastline

autocmd InsertEnter * set timeoutlen=250 ttimeoutlen=0
autocmd InsertLeave * set timeoutlen=1000 ttimeoutlen=0


" Advanced
set omnifunc=htmlcomplete#CompleteTags

" Auto refresh aliases
autocmd BufWritePost ~/dotfiles/aliases/folders,~/dotfiles/aliases/configs !python ~/dotfiles/scripts/shortcuts.py
autocmd BufWritePost ~/.Xresources,~/dotfiles/.Xresources !xrdb ~/.Xresources

" Theming
" set background=dark
" colorscheme 256-grayvim
" let g:solarized_termcolors=256
" let &t_Co=256
hi search cterm=NONE ctermfg=black ctermbg=yellow
hi spellbad cterm=none ctermfg=white ctermbg=160 "dark red
hi folded cterm=none ctermfg=7 ctermbg=17


" Mappings
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nmap ; :
nmap <up> gk
nmap <down> gj
nmap <silent> ,/ :nohlsearch<CR>
nmap J gj
nmap K gk
nmap <C-g> :%s/\s\+$//<cr>
nmap <C-n> :set norelativenumber<CR>
nmap <C-m> :set relativenumber<CR>
nmap <F10> :NERDTreeToggle<CR>
nmap <silent> <leader>sp :set spell<cr>
nmap <silent> <leader>nsp :set nospell<cr>
nmap <leader><C-l> :loadview<cr>

" Window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

cmap w!! w !sudo tee % >/dev/null
cmap Q q

imap jk <esc>
imap JK <esc>
imap kj <esc>
imap <C-a> <esc>jA

" Nifty alphabetize shortcut
vnoremap <F3> d:execute 'normal i' . join(sort(split(getreg('"'))), ' ')<CR>

" Ctrl-S saving
nmap <C-S> :update<CR>
vmap <C-S> <C-C>:update<CR>
imap <C-S> <C-O>:update<CR>


" Plugin Configurations

" Airline
"let g:airline#extensions#synastic#enables = 1
"set laststatus=2
"let g:airline_powerline_fonts = 1
"let g:airline_theme = 'powerlineish'
"if !exists('g:airline_symbols')
"	let g:airline_symbols = {}
"endif
"let g:airline_symbols.maxlinenr = ''
"let g:airline_symbols.whitespace = ''


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


" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
			\ "mode": "passive",
			\ "active_filetypes": [],
			\ "passive_filetypes": [] }

" latex-suite
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf='pdflatex -interaction=nonstopmode $*'
let g:Tex_ViewRule_pdf='zathura'
let g:Tex_IgnoredWarnings='"Underfull\n".
    \"Overfull\n".
    \"specifier changed to\n".
    \"You have requested\n".
    \"Missing number, treated as zero.\n".
    \"There were undefined references\n"
    \"Citation %.%# undefined"
    \"Package gensymb Warning: Not defining\n".'
let g:Tex_IgnoreLevel=8
map <f3> <esc>:w<cr><leader>ll<CR>
imap <C-t> <Plug>Tex_InsertItemOnThisLine
imap i <Plug>Tex_InsertItemOnThisLine


" Goyo
nmap <F12> :Goyo<cr>
imap <F12> <C-o>:Goyo<cr>


" YouCompleteMe
let g:ycm_filetype_blacklist = {
			\ 'tex' : 1
			\}

" NERDTree
function! NERDTreeQuit()
	redir => buffersoutput
	silent buffers
	redir END
	"                     1BufNo  2Mods.     3File           4LineNo
	let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
	let windowfound = 0

	for bline in split(buffersoutput, "\n")
		let m = matchlist(bline, pattern)

		if (len(m) > 0)
			if (m[2] =~ '..a..')
				let windowfound = 1
			endif
		endif
	endfor

	if (!windowfound)
		quitall
	endif
endfunction
autocmd WinEnter * call NERDTreeQuit()


" Closetag
" filenames like *.xml, *.html, *.xhtml, ...
" Then after you press <kbd>&gt;</kbd> in these files, this plugin will try to close the current tag.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non closing tags self closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" integer value [0|1]
" This will make the list of non closing tags case sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'



" Make python /comfy/
au BufNewFile,BufRead *.py
      \ set tabstop=4 |
      \ set softtabstop=4 |
      \ set shiftwidth=4 |
      \ set textwidth=79 |
      \ set expandtab |
      \ set autoindent |
      \ set fileformat=unix

let python_highlight_all=1

" Python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
	project_base_dir = os.environ['VIRTUAL_ENV']
	activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
	execfile(activate_this, dict(__file__=activate_this))
EOF


au BufNewFile,BufRead *.js, *.html, *.css
      \ set tabstop=2 |
      \ set softtabstop=2 |
      \ set shiftwidth=2
