" vim: ts=4 sw=4
" Location: ~/.vimrc

set nocompatible

" Plug
" If plug is not installed, fetch and install it automatically.
if has("unix")
	let data_dir = has('nvim') ? stdpath('data') . '/site' : $HOME.'/.vim'
elseif has("win32")
	let data_dir = has('nvim') ? stdpath('data') . '/site' : $HOME.'\vimfiles'
endif

if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if has("unix")
	call plug#begin($HOME.'/.vim/plugged')
elseif has("win32")
	call plug#begin($HOME.'\vimfiles\plugged')
endif

" vimtex: ease-of-life shortcuts for latex
Plug 'lervag/vimtex', { 'for': 'tex' }

" nerdtree: file exploring side bar
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" vim-fugitive: git control within vim
Plug 'tpope/vim-fugitive'

" emmet-vim: quick html writing
Plug 'mattn/emmet-vim', { 'for': 'html' }

" vim-closetag: automatically create matching close tags in html
Plug 'alvan/vim-closetag', { 'for': ['html', 'javascript'] }

" goyo: distraction-free editing
" Toggle shortcut: F12
Plug 'junegunn/goyo.vim'

" nerdcommenter: shortcuts to comment code
Plug 'preservim/nerdcommenter'

" vim-sandwich: surrounding text
Plug 'machakann/vim-sandwich'

" lightline: status line
Plug 'itchyny/lightline.vim'

" vim-easymotion: jumping thoughout text easily
Plug 'easymotion/vim-easymotion'

" indentLine: indent guides
Plug 'Yggdroot/indentLine'

" Asynchronous Lint Engine
Plug 'dense-analysis/ale', { 'for': ['cs', 'haskell', 'html', 'javascript'], 'on': 'ALEEnable' }

" Python specific:
"   indentpython: auto intent after : and in multiline statements
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }

" Syntax highlighting plugins:
Plug 'hrother/offlineimaprc.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'kevinoid/vim-jsonc'
Plug 'adamclerk/vim-razor'

Plug 'ctrlpvim/ctrlp.vim'

" Markdown:
"   Pandoc markdown editing
Plug 'vim-pandoc/vim-pandoc', { 'for': ['markdown', 'pandoc'] }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': ['markdown', 'pandoc'] }
"   Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug', 'pandoc'] }

" Javascript:
"   Improved Javascript indentation and syntax support
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
"   JSX and TSX syntax highlighting
Plug 'MaxMEllon/vim-jsx-pretty', { 'for': 'javascript' }

" C#:
Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs' }

" Autodetect tab settings in a file
Plug 'tpope/vim-sleuth'

Plug 'mbbill/undotree'

" Multiple cursors
Plug 'mg979/vim-visual-multi'

call plug#end()


" ===================================


" Basics
let mapleader=","
let maplocalleader="-"
set encoding=utf8
syntax on           " Syntax highlighting
set mouse=a         " Enable mouse support (yes crucify me)
set tabstop=2       " Tab width
set shiftwidth=2    " Tab width
"set softtabstop=0  " Vim will not insert spaces to simulate tabstops
"set smarttab       " Tabs at the beginning of a line use shiftwidth, not tabstop
set noexpandtab     " Use tab characters instead of spaces when pressing tab
set backspace=indent,eol,start  " Allow backspacing over autoindent, line breaks, and the start of an insert
set autoindent      " If a line is indented, an added line will be too
set copyindent      " If a line is indented, an added line will use the same type of indentation (tabs, spaces)
set number          " Print line numbers
set shiftround      " Round intents to a multiple of the shiftwidth
set showmatch       " When adding a bracket, show the matching one for a second
set ignorecase      " Searching will ignore the case of letters
set smartcase       " Searching will only consider the case of letters if a capital is used
set hlsearch        " Highlight all matched in last search
set incsearch       " Highlight all matched in current search
set title           " Set the title of the window to the filename
set noerrorbells    " Do not beep or flash during errors
set nobackup        " Do not backup files before overwriting them
set noswapfile      " Do not use swap files
set wildmenu        " Command line completion is enhanced (suggestions)
if has("win32")     " Use the clipboard for all operations
	set clipboard=unnamed
else
	set clipboard+=unnamedplus
endif
set linebreak       " Wrap long lines at characters that make sense (breakat)
set noshowmode      " Don't show the mode on the last line (this is done with lightline)
set laststatus=2    " Enable status line for all windows
if has("unix")
	set shell=/bin/bash
elseif has("win32")
	set shell=cmd.exe
endif
set scrolloff=3     " Set a minimum amount of lines above and below the cursor
set undofile        " Persistent undo tree between sessions
if has("win32")
	call system('mkdir '.$HOME.'\tmp')
	set undodir=$HOME\tmp
endif
set fileformats=unix,dos " Set default line endings

" Do not auto-insert comments on new lines
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

if !has('nvim')
	set noesckeys     " Function keys that start with <ESC> are recognised in insert mode (only necessary in vim, not neovim)
endif


" Set GUI font
function! SetFont()
	if has("gui_running")
		if has("win32")
			exe ':set guifont='.g:font.':h'.string(g:font_size).':w'.string(g:font_size / 2.0)
		elseif has("unix")
			exe ':set guifont='.g:font.'\ '.string(g:font_size)
		endif
	endif
endfunction

function! DefaultFont()
	let g:font = 'Iosevka'
	let g:font_size = 11
	call SetFont()
endfunction
call DefaultFont()

function! FontSizePlus()
	let g:font_size = g:font_size + 0.5
	call SetFont()
endfunction

function! FontSizeMinus()
	let g:font_size = g:font_size - 0.5
	call SetFont()
endfunction

if has("gui_running")
	if has("win32")
		set guioptions-=T
		set guioptions-=t
	endif

	nnoremap + :call FontSizePlus()<cr>
	nnoremap _ :call FontSizeMinus()<cr>
	nnoremap ) :call DefaultFont()<cr>
endif

" Concealing
set concealcursor=""
set conceallevel=2

" Advanced
set omnifunc=htmlcomplete#CompleteTags

" Auto refresh databases on saving
autocmd BufWritePost ~/dotfiles/aliases/folders*,~/dotfiles/aliases/configs*,~/dotfiles/aliases/groups,~/dotfiles/scripts/shortcuts.sh !bash ~/dotfiles/scripts/shortcuts.sh
autocmd FileType xdefaults autocmd BufWritePost <buffer> !$DOTFILES_SCRIPTS/reload-xresources.sh

" ===================================
" Theming
let &t_Co=256
function! s:new_colors()
	let s:foreground='#f5f5f5'
	let s:background='#1d1d1d'
	let s:black='#090909'			" 0
	let s:dark_red='#ff443e'		" 1
	let s:dark_green='#6dd82c'		" 2
	let s:dark_yellow='#ffd740'		" 3
	let s:dark_blue='#42a5f5'		" 4
	let s:dark_magenta='#d81b60'	" 5
	let s:dark_cyan='#00acc1'		" 6
	let s:light_grey='#f5f5f5'		" 7
	let s:dark_grey='#555753'		" 8
	let s:red='#ff8d8d'				" 9
	let s:green='#c8e7a8'			" 10
	let s:yellow='#ffc135'			" 11
	let s:blue='#3465a4'			" 12
	let s:magenta='#ff6482'			" 13
	let s:cyan='#46a4ff'			" 14
	let s:white='#ffffff'			" 15

	let s:navy_blue='#00005f'		" 17
	let s:steel_blue1='#5fd7ff'		" 81
	let s:dark_red1='#870000'		" 88
	let s:pale_green1='#87ffaf'		" 121
	let s:misty_rose1='#ffd7d7'		" 224
	let s:thistle='#ffd7ff'			" 225
	let s:grey19='#303030'			" 236
	let s:grey30='#4e4e4e'			" 239
	let s:grey42='#6c6c6c'			" 242
	let s:grey58='#949494'			" 246
	let s:grey74='#bcbcbc'			" 250
	let s:grey78='#c6c6c6'			" 251

	set background=dark
	"	highlight name		cterm					ctermfg				ctermbg				gui					guifg					guibg
	exe 'hi Normal'.																							' guifg='.s:foreground.	' guibg='.s:background
	exe 'hi NonText'.								' ctermfg=12'.							' gui=bold'.		' guifg='.s:blue
	exe 'hi Comment'.								' ctermfg=14'.												' guifg='.s:cyan
	exe 'hi Constant'.								' ctermfg=13'.												' guifg='.s:magenta
	exe 'hi Conceal'.								' ctermfg=246'.												' guifg='.s:grey58
	exe 'hi Identifier'.	' cterm=bold'.			' ctermfg=14'.												' guifg='.s:cyan
	exe 'hi Statement'.								' ctermfg=11'.							' gui=bold'.		' guifg='.s:yellow
	exe 'hi PreProc'.								' ctermfg=81'.												' guifg='.s:steel_blue1
	exe 'hi Type'.									' ctermfg=121'.							' gui=bold'.		' guifg='.s:pale_green1
	exe 'hi Special'.								' ctermfg=224'.												' guifg='.s:misty_rose1
	exe 'hi Underlined'.	' cterm=underline'.		' ctermfg=81'.							' gui=underline'.	' guifg='.s:steel_blue1
	hi link Label Statement
	hi link Operator Statement

	exe 'hi ErrorMsg'.								' ctermfg=15'.		' ctermbg=1'.							' guifg='.s:white.		' guibg='.s:dark_red
	exe 'hi WarningMsg'.							' ctermfg=224'.												' guifg='.s:misty_rose1
	exe 'hi ModeMsg'.		' cterm=bold'.													' gui=bold'
	exe 'hi MoreMsg'.								' ctermfg=121'.							' gui=bold'.		' guifg='.s:pale_green1
	exe 'hi Error'.									' ctermfg=15'.		' ctermbg=9'.							' guifg='.s:white.		' guibg='.s:red

	exe 'hi Todo'.									' ctermfg=0'.		' ctermbg=11'.							' guifg='.s:black.		' guibg='.s:yellow
	exe 'hi Cursor'.																							' guifg=bg'.			' guibg=fg'
	exe 'hi Search'. 		' cterm=none'. 			' ctermfg=black'.	' ctermbg=yellow'. 						' guifg='.s:black. 		' guibg='.s:yellow
	exe 'hi IncSearch'.		' cterm=reverse'.												' gui=reverse'
	exe 'hi LineNr'.		' cterm=none'.			' ctermfg=251'.												' guifg='.s:grey78
	exe 'hi Title'.									' ctermfg=225'.							' gui=bold'.		' guifg='.s:thistle

	exe 'hi StatusLineNC'.	' cterm=reverse'.												' gui=reverse'
	exe 'hi StatusLine'.	' cterm=bold,reverse'.											' gui=bold,reverse'
	exe 'hi VertSplit'.		' cterm=reverse'.												' gui=reverse'

	exe 'hi Visual'.								' ctermfg=none'. 	' ctermbg=239'.													' guibg='.s:grey30

	exe 'hi DiffChange'.							' ctermfg=white'.	' ctermbg=8'.							' guifg='.s:white.		' guibg='.s:dark_grey
	exe 'hi DiffText'.		' cterm=bold'.								' ctermbg=9'.		' gui=bold'.								' guibg='.s:red
	exe 'hi DiffAdd'.								' ctermfg=black'.	' ctermbg=2'.							' guifg='.s:black.		' guibg='.s:dark_green
	exe 'hi DiffDelete'.							' ctermfg=black'.	' ctermbg=1'.							' guifg='.s:black.		' guibg='.s:dark_red

	exe 'hi Folded'.		' cterm=none'.			' ctermfg=7'.		' ctermbg=17'.							' guifg='.s:light_grey.	' guibg='.s:navy_blue
	exe 'hi FoldColumn'.							' ctermfg=14'.		' ctermbg=242'.							' guifg='.s:cyan.		' guibg='.s:grey42

	exe 'hi SpellBad'.		' cterm=none'.			' ctermfg=white'.	' ctermbg=88'.		' gui=undercurl'
	exe 'hi EndOfBuffer'.							' ctermfg=12'.							' gui=bold'.		' guifg='.s:blue
	exe 'hi ColorColumn'.												' ctermbg=236'.													' guibg='.s:grey19

	exe 'hi Pmenu'.									' ctermfg=white'.	' ctermbg=236'.							' guifg='.s:white.		' guibg='.s:grey19
	exe 'hi PmenuSel'.								' ctermfg=250'.		' ctermbg=0'.							' guifg='.s:grey74.		' guibg='.s:black
	exe 'hi ExtraWhitespace'.											' ctermbg=88'.													' guibg='.s:dark_red1
endfunction
autocmd! ColorScheme default call s:new_colors()
call s:new_colors()

" Show whitespace at the ends on lines
autocmd BufWinEnter,InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * call clearmatches()

" ===================================
" Mappings

nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>
nnoremap ; :
nnoremap : ;
nnoremap <up> gk
nnoremap <down> gj
nnoremap <silent> ,/ :nohlsearch<CR>
nnoremap J gj
nnoremap K gk
nnoremap <C-g> :%s/\s\+$//<cr>
nnoremap <C-n> :set relativenumber!<CR>
nnoremap <F10> :NERDTreeToggle<CR>
nnoremap <silent> <leader>sp :set spell!<cr>
nnoremap <leader><C-l> :loadview<cr>
nnoremap ! :!
nnoremap Q <nop>

nmap \ a_<esc>r

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
let g:BASH_Ctrl_j = 'off' " Sometimes bash may treat Ctrl+J weird. Disable that behavior.
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
inoremap <C-h> <esc><C-w>h
inoremap <C-j> <esc><C-w>j
inoremap <C-k> <esc><C-w>k
inoremap <C-l> <esc><C-w>l

noremap <leader>d "_d
noremap <leader>c "_c
vnoremap p "_dp
vnoremap P "_dP
vnoremap <leader>p p
vnoremap <leader>P P

" Forgot to get root access before editing? No worries!
cmap w!! w !sudo tee % >/dev/null

" Mostly for the following jk commands. Makes exiting insert mode really fast.
autocmd InsertEnter * set timeoutlen=250 ttimeoutlen=0
autocmd InsertLeave * set timeoutlen=1000 ttimeoutlen=0

imap jk <esc>
imap JK <esc>
imap kj <esc>
imap <C-a> <esc>jA

" Ctrl-S saving
nnoremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" Auto clear when a command is entered
autocmd CmdlineLeave : echo ''

" Moving v-blocks
vnoremap L dpgv

" Jump to the next edit marker and edit
nmap <C-t> 0/<++><cr>,/c4l
imap <C-t> <esc>0/<++><cr>,/c4l

" Do things when a :terminal is opened
if has('nvim')
	autocmd TermOpen * startinsert
	autocmd TermOpen * set nonumber
	autocmd TermOpen * echo "To exit insert mode, use <C-\\><C-n>"
endif

" Plain text
autocmd FileType text,markdown,pandoc set spell

" C
autocmd FileType c nnoremap <leader><leader>c :!gcc -o %:r % -lm<CR>
autocmd FileType c nnoremap <leader><leader>r :term ./%:r<CR>
autocmd FileType c nnoremap <leader><leader>R :term ./%:r<space>
autocmd FileType c,java imap {<CR> {<CR>}<ESC>ka<CR>
autocmd FileType c imap MAIN int main(void)<CR>{<CR><CR>return 0;<ESC>kO
autocmd FileType c imap STDIO #include <stdio.h>
autocmd FileType c imap STDLIB #include <stdlib.h>
autocmd FileType c imap STRING #include <string.h>

autocmd FileType c,java nnoremap <leader>ta :CtrlPTag<CR>
autocmd FileType c,java nnoremap <leader>p :CtrlPTag<CR>
if executable("ctags")
	autocmd FileType c,java
		\ autocmd BufWritePost <buffer> silent! !ctags %
endif

" Java
autocmd FileType java set colorcolumn=100

" CSS autocmds
autocmd FileType css,javascript imap {<CR> {<CR>}<ESC>O

" Markdown
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
autocmd FileType markdown,pandoc nnoremap <leader><leader>r :MarkdownPreview<CR>

autocmd FileType json set conceallevel=0
let g:vim_json_warnings=0

" ===================================
" Plugin Configurations

" vimtex
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_types = {
	\ 'envs' : {
	\	'whitelist' : ['tikzpicture'],
	\ },
	\}

" Goyo
function! s:goyo_enter()
	highlight EndOfBuffer ctermfg=234
endfunction

function! s:goyo_leave()
	colorscheme default
	syntax on
endfunction

nnoremap <F12> :Goyo<cr>
imap <F12> <C-o>:Goyo<cr>

autocmd! user GoyoEnter nested call <SID>goyo_enter()
autocmd! user GoyoLeave nested call <SID>goyo_leave()


" NERDTree
" This function closes NERDTree automatically if it detects that it is the last window.
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
" Shortcut for closing tags.
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag.
let g:closetag_close_shortcut = '<leader>>'

" After you press > in these files, this plugin will try to close the current tag.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" This will make the list of non closing tags self closing in the specified files.
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" This will make the list of non closing tags case sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1


" NERDCommenter
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
noremap <leader>c<space> :call nerdcommenter#Comment(1, 'toggle')<CR>


" vim-sandwich
" runtime macros/sandwich/keymap/surround.vim
xmap is <Plug>(textobj-sandwich-query-i)
xmap as <Plug>(textobj-sandwich-query-a)
omap is <Plug>(textobj-sandwich-query-i)
omap as <Plug>(textobj-sandwich-query-a)


" indentLine
let g:indentLine_setConceal = 0
let g:indentLine_fileTypeExclude = ['markdown', 'pandoc']


" Pandoc
let g:pandoc#folding#level = 1
let g:pandoc#folding#mode = "relative"
let g:pandoc#syntax#codeblocks#embeds#langs = ["c", "java"]


" markdown-preview
let g:mkdp_filetypes = ['markdown', 'pandoc']


" ALE
nnoremap <F8> :ALEFix<CR>
let g:ale_lint_on_text_changed = 'normal'
let g:ale_line_on_insert_leave = 1
let g:ale_linters = {
			\   'cs': [],
			\   'html': ['tidy'],
			\   'javascript': ['eslint'],
			\}
let g:ale_linter_aliases = {
			\   'html': ['html', 'css', 'javascript'],
			\}
let g:ale_fixers = {
			\   '*': ['remove_trailing_lines', 'trim_whitespace'],
			\   'c': ['astyle'],
			\   'cs': ['uncrustify'],
			\   'java': ['google_java_format'],
			\   'javascript': ['eslint'],
			\   'python': ['black'],
			\}
let g:ale_haskell_ghc_options = '-dynamic -fno-code -v0'


" OmniSharp
let g:OmniSharp_selector_ui = 'ctrlp'
let g:OmniSharp_popup = 1

if has('win32')
	source $VIMRUNTIME/mswin.vim
endif

