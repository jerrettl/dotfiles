" vim: ts=4 sw=4
" Location: ~/.vimrc

set nocompatible

" Add Windows-like bindings if on Windows
if has('win32')
	source $VIMRUNTIME/mswin.vim
endif

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

" Function to help plugin loading for only neovim
" https://github.com/junegunn/vim-plug/wiki/tips
function! LoadIfTrue(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Tab bar - Neovim only
Plug 'nvim-tree/nvim-web-devicons', LoadIfTrue(has('nvim')) " For file icons
Plug 'nanozuki/tabby.nvim', LoadIfTrue(has('nvim'))

" Scrollbars - Neovim only
Plug 'dstein64/nvim-scrollview', LoadIfTrue(has('nvim'))

" nerdtree: file exploring side bar
" coc-explorer should be used if not on Windows
Plug 'scrooloose/nerdtree', LoadIfTrue(has('win32'), { 'on': 'NERDTreeToggle' })

" vimtex: ease-of-life shortcuts for latex
Plug 'lervag/vimtex', { 'for': 'tex' }

" vim-fugitive: git control within vim
Plug 'tpope/vim-fugitive'

" git-gutter: View changes relative to version control in the side
Plug 'airblade/vim-gitgutter', LoadIfTrue(!has('nvim'), { 'for': ['rust'] })

" gitsigns: View changes relative to version control, works with nvim-scrollbar
Plug 'lewis6991/gitsigns.nvim', LoadIfTrue(has('nvim'))

" emmet-vim: quick html writing
Plug 'mattn/emmet-vim', { 'for': 'html' }

" vim-closetag: automatically create matching close tags in html
Plug 'alvan/vim-closetag', { 'for': ['html', 'javascript'] }

" goyo: distraction-free editing
" Toggle shortcut: F12
Plug 'junegunn/goyo.vim', LoadIfTrue(!has('nvim'))
" zen-mode: Distraction-free editing, but a little better for neovim
Plug 'folke/zen-mode.nvim', LoadIfTrue(has('nvim'))

" nerdcommenter: shortcuts to comment code
Plug 'preservim/nerdcommenter'

" vim-sandwich: surrounding text
Plug 'machakann/vim-sandwich'

" lightline: status line
Plug 'itchyny/lightline.vim'

" vim-easymotion: jumping thoughout text easily
Plug 'easymotion/vim-easymotion'

" Indent guides
"   Neovim only
"   nvim-treesitter is for additional scope interpretation
Plug 'nvim-treesitter/nvim-treesitter', LoadIfTrue(has('nvim'), {'do': ':TSUpdate'})
"   nvim-treesitter-context is used to see the current context at the top
Plug 'nvim-treesitter/nvim-treesitter-context', LoadIfTrue(has('nvim'))
Plug 'lukas-reineke/indent-blankline.nvim', LoadIfTrue(has('nvim'))
"   indentLine: indent guides
"   Fallback if neovim is not available
Plug 'Yggdroot/indentLine', LoadIfTrue(!has('nvim'))

" splitjoin.vim: Switch between single-line and multi-line forms of code
Plug 'AndrewRadev/splitjoin.vim'

" Intellisence
Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': ['cs', 'rust', 'yaml'], 'on': ['CocEnable', 'CocCommand', 'CocInstall']}

" Asynchronous Lint Engine
" May not be needed in favor of coc
" Plug 'dense-analysis/ale', { 'for': ['cs', 'haskell', 'html', 'javascript'], 'on': 'ALEEnable' }

" Python specific:
"   indentpython: auto intent after : and in multiline statements
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }

" Syntax highlighting plugins:
Plug 'hrother/offlineimaprc.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'udalov/kotlin-vim'
Plug 'kevinoid/vim-jsonc'
Plug 'adamclerk/vim-razor'

" Fuzzy search
"   For vim
Plug 'ctrlpvim/ctrlp.vim', LoadIfTrue(!has('nvim'))
"   For neovim
"     Dependency for telescope
Plug 'nvim-lua/plenary.nvim', LoadIfTrue(has('nvim'))
Plug 'nvim-telescope/telescope.nvim', LoadIfTrue(has('nvim'), { 'tag': '0.1.8' })

" Table of contents
Plug 'stevearc/aerial.nvim', LoadIfTrue(has('nvim'))

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

" Rust:
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" YAML:
"   Better folding
Plug 'pedrohdz/vim-yaml-folds', { 'for': 'yaml' }

" Autodetect tab settings in a file
Plug 'tpope/vim-sleuth'

Plug 'mbbill/undotree'

" Define text objects based on indent levels
Plug 'michaeljsmith/vim-indent-object'

" Multiple cursors
Plug 'mg979/vim-visual-multi'

" Automatic bulleting
Plug 'dkarter/bullets.vim', { 'for': ['markdown', 'pandoc'] }

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
set cursorline      " Highlight the currently selected line
set splitbelow      " When splitting, use the bottom pane
set listchars+=space:␣,tab:>- " Show spaces
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
	if !isdirectory($HOME.'\tmp')
		call mkdir($HOME.'\tmp', 'p')
	endif
	set undodir=$HOME\tmp
endif
set fileformats=unix,dos " Set default line endings

" Do not auto-insert comments on new lines
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

if !has('nvim')
	set noesckeys     " Function keys that start with <ESC> are recognised in insert mode (only necessary in vim, not neovim)
endif

if exists("g:neovide")
	let g:neovide_cursor_animation_length = 0.08
	let g:neovide_cursor_unfocused_outline_width = 0.08
	let g:neovide_cursor_trail_size = 0.2
	let g:neovide_scroll_animation_length = 0.1
endif


" Set GUI font
function! SetFont()
	if has("gui_running")
		if has("win32") && !exists("g:neovide")
			exe ':set guifont='.g:font.':h'.string(g:font_size).':w'.string(g:font_size / 2.0)
		elseif has("win32") && exists("g:neovide")
			exe ':set guifont='.g:font.':h'.string(g:font_size)
		elseif has("unix")
			exe ':set guifont='.g:font.'\ '.string(g:font_size)
		endif
	endif
endfunction

function! DefaultFont()
	if has("win32") && !exists("g:neovide")
		let g:font = 'Iosevka_NFM'
		let g:font_size = 11
	elseif has("win32") && !exists("g:neovide")
		let g:font = 'Iosevka\ Term'
		let g:font_size = 12
	else
		let g:font = 'Iosevka\ Term'
		let g:font_size = 11
	endif
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

" Allow 24-bit RGB in the terminal interface. Requires a compatible terminal.
set termguicolors

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
	"	highlight name			cterm					ctermfg				ctermbg				gui					guifg					guibg
	exe 'hi Normal'.																								' guifg='.s:foreground.	' guibg='.s:background
	exe 'hi NonText'.									' ctermfg=12'.							' gui=bold'.		' guifg='.s:blue
	exe 'hi Comment'.									' ctermfg=14'.												' guifg='.s:cyan
	exe 'hi Constant'.									' ctermfg=13'.												' guifg='.s:magenta
	exe 'hi Conceal'.									' ctermfg=246'.		' ctermbg=NONE'.						' guifg='.s:grey58.		' guibg=NONE'
	exe 'hi Identifier'.		' cterm=bold'.			' ctermfg=14'.												' guifg='.s:cyan
	exe 'hi Statement'.									' ctermfg=11'.							' gui=bold'.		' guifg='.s:yellow
	exe 'hi PreProc'.									' ctermfg=81'.												' guifg='.s:steel_blue1
	exe 'hi Type'.										' ctermfg=121'.							' gui=bold'.		' guifg='.s:pale_green1
	exe 'hi Special'.									' ctermfg=224'.												' guifg='.s:misty_rose1
	exe 'hi Underlined'.		' cterm=underline'.		' ctermfg=81'.							' gui=underline'.	' guifg='.s:steel_blue1
	hi link Label Statement
	hi link Operator Statement

	exe 'hi ErrorMsg'.									' ctermfg=15'.		' ctermbg=1'.							' guifg='.s:white.		' guibg='.s:dark_red
	exe 'hi WarningMsg'.								' ctermfg=224'.												' guifg='.s:misty_rose1
	exe 'hi ModeMsg'.			' cterm=bold'.													' gui=bold'
	exe 'hi MoreMsg'.									' ctermfg=121'.							' gui=bold'.		' guifg='.s:pale_green1
	exe 'hi Error'.										' ctermfg=15'.		' ctermbg=9'.							' guifg='.s:white.		' guibg='.s:red

	exe 'hi Cursor'.																								' guifg=bg'.			' guibg=fg'
	exe 'hi Search'.			' cterm=none'. 			' ctermfg=black'.	' ctermbg=yellow'. 						' guifg='.s:black. 		' guibg='.s:yellow
	" Used for nvim-scrollview
	exe 'hi ScrollViewSearch'.							' ctermfg=yellow'.											' guifg='.s:yellow
	exe 'hi IncSearch'.			' cterm=reverse'.												' gui=reverse'
	exe 'hi LineNr'.			' cterm=none'.			' ctermfg=251'.												' guifg='.s:grey78
	exe 'hi CursorLineNr'.		' cterm=bold'.													' gui=bold'
	exe 'hi Title'.										' ctermfg=225'.							' gui=bold'.		' guifg='.s:thistle
	exe 'hi CursorLine'.		' cterm=none'.								' ctermbg=236'.		' gui=none'.								' guibg='.s:grey19

	exe 'hi VertSplit'.			' cterm=reverse'.												' gui=reverse'

	" Inactive tab
	exe 'hi TabLine'.									' ctermfg=231'.		' ctermbg=240'.							' guifg=#ffffff'.		' guibg=#585858'
	" Active tab
	exe 'hi TabLineSel'.								' ctermfg=241'.		' ctermbg=252'.							' guifg=#606060'.		' guibg=#d0d0d0'
	" The rest of the line
	exe 'hi TabLineFill'.								' ctermfg=247'.		' ctermbg=236'.							' guifg=#9e9e9e'.		' guibg=#303030'

	exe 'hi Visual'.									' ctermfg=none'. 	' ctermbg=239'.													' guibg='.s:grey30

	exe 'hi DiffChange'.								' ctermfg=white'.	' ctermbg=8'.							' guifg='.s:white.		' guibg='.s:dark_grey
	exe 'hi DiffText'.			' cterm=bold'.								' ctermbg=9'.		' gui=bold'.								' guibg='.s:red
	exe 'hi DiffAdd'.									' ctermfg=black'.	' ctermbg=2'.							' guifg='.s:black.		' guibg='.s:dark_green
	exe 'hi DiffDelete'.								' ctermfg=black'.	' ctermbg=1'.							' guifg='.s:black.		' guibg='.s:dark_red

	exe 'hi Folded'.			' cterm=none'.			' ctermfg=7'.		' ctermbg=17'.							' guifg='.s:light_grey.	' guibg='.s:navy_blue
	exe 'hi FoldColumn'.								' ctermfg=14'.		' ctermbg=242'.							' guifg='.s:cyan.		' guibg='.s:grey42

	exe 'hi SpellBad'.			' cterm=none'.			' ctermfg=white'.	' ctermbg=88'.		' gui=undercurl'
	exe 'hi EndOfBuffer'.								' ctermfg=12'.							' gui=bold'.		' guifg='.s:blue
	exe 'hi ColorColumn'.													' ctermbg=236'.													' guibg='.s:grey19

	exe 'hi Pmenu'.										' ctermfg=white'.	' ctermbg=236'.							' guifg='.s:white.		' guibg='.s:grey19
	exe 'hi PmenuSel'.									' ctermfg=250'.		' ctermbg=0'.							' guifg='.s:grey74.		' guibg='.s:black
	exe 'hi ExtraWhitespace'.												' ctermbg=88'.													' guibg='.s:dark_red1
	exe 'hi Todo'.										' ctermfg=black'.	' ctermbg=9'.							' guifg='.s:black.		' guibg='.s:red
	exe 'hi IndentBlanklineChar'.						' ctermfg=242'.							' gui=nocombine'.	' guifg='.s:grey42
	exe 'hi SpecialKey'.								' ctermfg=242'.												' guifg='.s:grey42
endfunction
autocmd! ColorScheme default call s:new_colors()
call s:new_colors()

" Show trailing whitespace at the ends on lines
autocmd BufWinEnter,InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match none

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
if has("win32") && !has("nvim")
	" coc-explorer is currently giving issues with Windows
	nnoremap <F10> <cmd>NERDTreeToggle<CR>
else
	nnoremap <F10> <cmd>CocCommand explorer<CR>
endif
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
vnoremap <leader>x "_x
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

" Saving session options
" Don't save color highlighting, etc as part of a session
set sessionoptions-=options

" Moving v-blocks
vnoremap L dpgv

" Split line into 3 lines and place cursor in the center
nnoremap <leader>o i<cr><esc>O
inoremap <C-o> <cr><esc>O

" Jump to the next edit marker and edit
nmap <C-t> 0/<++><cr>,/c4l
imap <C-t> <esc>0/<++><cr>,/c4l

" Shortcut to insert current date in YYYY-MM-DD format.
if exists("*strftime")
	inoremap <C-d> <C-r>=strftime('%F')<CR>
	inoremap <C-e> <C-r>=strftime('%a %F %T')<CR>
else
	inoremap <C-d> <esc>:echo "Unable to retrieve date. strftime is not installed on this system."<CR>a
	inoremap <C-e> <esc>:echo "Unable to retrieve date. strftime is not installed on this system."<CR>a
endif

" Do things when a :terminal is opened
if has('nvim')
	autocmd TermOpen * startinsert
	autocmd TermOpen * set nonumber
	autocmd TermOpen * echo "To exit insert mode, use <C-\\><C-n>"
endif

" Move by text of the same indent level
" https://vi.stackexchange.com/questions/12835/how-do-i-jump-to-the-next-line-with-the-same-indent-level
function! GoToNextIndent(inc)
    " Get the cursor current position
    let currentPos = getpos('.')
    let currentLine = currentPos[1]
    let matchIndent = 0

    " Look for a line with the same indent level whithout going out of the buffer
    while !matchIndent && currentLine != line('$') + 1 && currentLine != -1
        let currentLine += a:inc
        let matchIndent = indent(currentLine) == indent('.')
    endwhile

    " If a line is found go to this line
    if (matchIndent)
        let currentPos[1] = currentLine
        call setpos('.', currentPos)
    endif
endfunction
nnoremap ]t :call GoToNextIndent(1)<CR>
nnoremap [t :call GoToNextIndent(-1)<CR>

" Plain text
autocmd FileType text,markdown,pandoc set spell
autocmd FileType markdown,pandoc inoremap <C-e> TODO

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

" Text and Markdown
if !has('nvim')
	" Only show indent guides if indent-blankline is not being used
	autocmd FileType markdown,pandoc,text setlocal list
	autocmd FileType markdown,pandoc,text setlocal listchars=trail:·,tab:┆\ ,multispace:┆
endif
autocmd WinEnter,BufEnter *.md,*.txt 2match Todo /TODO/

autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
autocmd FileType markdown,pandoc nnoremap <leader><leader>r :MarkdownPreview<CR>
autocmd FileType markdown,pandoc set tabstop=4
autocmd FileType markdown,pandoc set shiftwidth=4

" JSON
autocmd FileType json set conceallevel=0
let g:vim_json_warnings=0

" YAML / YML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" ===================================
" Plugin Configurations

" tabby.nvim
if has('nvim') && has_key(plugs, 'tabby.nvim')
	autocmd VimEnter * call s:setup_tabby()
	function! s:setup_tabby() abort
		lua << EOF
		local theme = {
			fill = 'TabLineFill',
			-- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
			head = 'TabLine',
			current_tab = 'TabLineSel',
			tab = 'TabLine',
			win = 'TabLine',
			tail = 'TabLine',
		}
		require('tabby').setup({
			preset = 'active_wins_at_tail',
			option = {
				-- nerdfont = true,
			},
			line = function(line) return {
				-- {
				-- 	{ '  ', hl = theme.head },
				-- 	line.sep('', theme.head, theme.fill),
				-- },
				line.tabs().foreach(function(tab)
					local hl = tab.is_current() and theme.current_tab or theme.tab
					return {
						-- line.sep('', hl, theme.fill),
						line.sep(' ', hl, theme.fill),
						-- tab.is_current() and '' or '󰆣',
						tab.is_current() and '' or '',
						tab.number(),
						tab.name(),
						tab.close_btn(''),
						-- line.sep('', hl, theme.fill),
						line.sep('', hl, hl),
						hl = hl,
						margin = ' ',
					}
				end),
				line.spacer(),
				line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
					return {
						-- line.sep('', theme.win, theme.fill),
						line.sep('', theme.win, theme.win),
						win.is_current() and '' or '',
						win.buf_name(),
						-- line.sep('', theme.win, theme.fill),
						line.sep(' ', theme.win, theme.fill),
						hl = theme.win,
						margin = ' ',
					}
				end),
				-- {
				-- 	line.sep('', theme.tail, theme.fill),
				-- 	{ '  ', hl = theme.tail },
				-- },
				hl = theme.fill,
			} end,
			-- option = {}, -- setup modules' option,
		})
EOF
	endfunction
endif


" Scrollbars with nvim-scrollview
let g:scrollview_signs_on_startup = ['diagnostics', 'search', 'gitsigns']
let g:scrollview_winblend_gui = 50


" vimtex
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_types = {
	\ 'envs' : {
	\	'whitelist' : ['tikzpicture'],
	\ },
	\}
let g:vimtex_compiler_latexrun_engines = {
	\ '_'            : 'xelatex',
	\ 'pdflatex'     : 'pdflatex',
	\ 'lualatex'     : 'lualatex',
	\ 'xelatex'      : 'xelatex',
	\ 'latex'        : 'latex',
	\}

" Goyo
function! s:goyo_enter()
	highlight EndOfBuffer ctermfg=234
endfunction

function! s:goyo_leave()
	colorscheme default
	syntax on
endfunction

if !has('nvim')
	nnoremap <F12> :Goyo<cr>
	imap <F12> <C-o>:Goyo<cr>
endif

autocmd! user GoyoEnter nested call <SID>goyo_enter()
autocmd! user GoyoLeave nested call <SID>goyo_leave()


" zen-mode
if has('nvim') && has_key(plugs, 'zen-mode.nvim')
	autocmd VimEnter * call s:setup_zen_mode()
	function! s:setup_zen_mode() abort
		lua << EOF
		require('zen-mode').setup {
			window = {
				backdrop = 1,
				width = 80,
				height = 0.85,
				options = {
					signcolumn = "no",
					foldcolumn = "0",
					number = false,
				}
			},
			on_open = function(win)
				vim.cmd("ScrollViewDisable")
			end,
			on_close = function()
				vim.cmd("ScrollViewEnable")
			end,
		}
EOF
	endfunction
endif
if has('nvim')
	nnoremap <silent> <F12> :ZenMode<cr>
	inoremap <silent> <F12> <C-o>:ZenMode<cr>
endif


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


" gitsigns.nvim
if has('nvim') && has_key(plugs, 'gitsigns.nvim')
	autocmd VimEnter * call s:setup_gitsigns()
	function! s:setup_gitsigns() abort
		lua << EOF
		require('gitsigns').setup()
EOF
	endfunction
endif


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


" Coc
let g:coc_global_extensions = [
	\'coc-explorer',
	\'coc-marketplace',
	\'coc-omnisharp',
	\'coc-rust-analyzer',
	\'coc-yaml',
	\]
" Go to definition
nnoremap gd <Plug>(coc-definition)

" Show documentation
nnoremap <silent> D <Cmd>call ShowDocumentation()<cr>
function! ShowDocumentation()
	if CocAction('hasProvider', 'hover')
		call CocActionAsync('doHover')
	else
		call feedkeys('K', 'in')
	endif
endfunction

" Autocomplete suggestions
if exists("*coc#pum#visible")
	inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<C-n>"
	inoremap <silent><expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<C-p>"
	inoremap <silent><expr> <down> coc#pum#visible() ? coc#pum#next(0) : "\<down>"
	inoremap <silent><expr> <up> coc#pum#visible() ? coc#pum#prev(0) : "\<up>"
	inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : "\<C-e>"
	inoremap <silent><expr> <C-y> coc#pum#visible() ? coc#pum#confirm() : "\<C-y>"
endif


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


" nvim-treesitter
if has('nvim') && has_key(plugs, 'nvim-treesitter')
	autocmd VimEnter * call s:setup_treesitter()
	function! s:setup_treesitter() abort
		lua << EOF
		require('nvim-treesitter.configs').setup {
			ensure_installed = { "markdown", "markdown_inline", "rust", "vim" }
		}
EOF
	endfunction
endif


" indent-blankline
if has('nvim') && has_key(plugs, 'indent-blankline.nvim')
	autocmd VimEnter * call s:setup_indentline()
	function! s:setup_indentline() abort
		lua << EOF
		require('ibl').setup {
			indent = {
				char = "┆",
				highlight = "IndentBlanklineChar"
			}
		}
EOF
	endfunction
endif


" indentLine
let g:indentLine_setConceal = 0
" let g:indentLine_fileTypeExclude = ['markdown', 'pandoc']


" aerial.nvim: Table of contents
if has('nvim') && has_key(plugs, 'aerial.nvim')
	autocmd VimEnter * call s:setup_aerial()
	function! s:setup_aerial() abort
		lua << EOF
		require('aerial').setup()
EOF
	endfunction
endif


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


" rust.vim
" Braced blocks are folded. All folds are open by default.
let g:rust_fold = 1


" View syntax highlighting stack
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc


" Bullets.vim
let g:bullets_enabled_file_types = [
    \ 'markdown',
	\ 'pandoc',
	\ 'markdown.pandoc',
    \]
let g:bullets_outline_levels = ['ROM', 'ABC', 'num', 'abc', 'rom', 'std-']
