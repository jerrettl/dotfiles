" Location: ~/.vimrc

set nocompatible

" Plug
" If plug is not installed, fetch and install it automatically.
if has("unix") && empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if has("unix")
  call plug#begin('~/.vim/plugged')
elseif has("win32")
  call plug#begin('~/vimfiles/plugged')
endif

" vim-latex: ease-of-life shortcuts for latex
Plug 'vim-latex/vim-latex', { 'for': 'tex' }

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
Plug 'scrooloose/nerdcommenter'

" vim-surround: surrounding text
Plug 'tpope/vim-surround'

" vim-repeat: repeat commands mostly for vim-surround
Plug 'tpope/vim-repeat'

" lightline: status line
Plug 'itchyny/lightline.vim'

" vim-easymotion: jumping thoughout text easily
Plug 'easymotion/vim-easymotion'

" indentLine: indent guides
Plug 'Yggdroot/indentLine'

" Asynchronous Lint Engine
Plug 'dense-analysis/ale', { 'for': ['cs', 'javascript'], 'on': 'ALEEnable' }

" Python specific:
"   indentpython: auto intent after : and in multiline statements
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }

" Syntax highlighting plugins:
Plug 'hrother/offlineimaprc.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'kevinoid/vim-jsonc'

Plug 'ctrlpvim/ctrlp.vim'

" Markdown:
"   Pandoc markdown editing
Plug 'vim-pandoc/vim-pandoc', { 'for': ['markdown', 'pandoc'] }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': ['markdown', 'pandoc'] }
"   Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug', 'pandoc']}

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
set clipboard+=unnamedplus  " Use the clipboard for all operations
set linebreak       " Wrap long lines at characters that make sense (breakat)
set noshowmode      " Don't show the mode on the last line (this is done with lightline)
set laststatus=2    " Enable status line for all windows
set shell=/bin/bash
set scrolloff=3     " Set a minimum amount of lines above and below the cursor
set undofile        " Persistent undo tree between sessions

" Do not auto-insert comments on new lines
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

if !has('nvim')
  set noesckeys     " Function keys that start with <ESC> are recognised in insert mode (only necessary in vim, not neovim)
endif

" Set GUI font
if has("win32")
  set guifont=PragmataProMono_Nerd_Font_Mono:h10:w5
else
  if has("unix")
    set guifont=PragmataProMono\ Nerd\ Font\ Mono\ 11
  endif
endif

" Advanced
set omnifunc=htmlcomplete#CompleteTags

" Auto refresh databases on saving
autocmd BufWritePost ~/dotfiles/aliases/folders*,~/dotfiles/aliases/configs*,~/dotfiles/scripts/shortcuts.sh !bash ~/dotfiles/scripts/shortcuts.sh
autocmd FileType xdefaults autocmd BufWritePost <buffer> !$DOTFILES_SCRIPTS/reload-xresources.sh

" ===================================

" Theming
let &t_Co=256
function! s:new_colors()
  hi search cterm=NONE ctermfg=black ctermbg=yellow
  hi spellbad cterm=none ctermfg=white ctermbg=88 "dark red
  hi folded cterm=none ctermfg=7 ctermbg=17 "blue
  hi LineNr cterm=none ctermfg=251 "grey
  hi Visual ctermfg=none ctermbg=239 guibg=Grey
  hi EndOfBuffer ctermfg=12 gui=bold guifg=Blue
  hi DiffChange ctermfg=white ctermbg=8
  hi DiffAdd ctermfg=black ctermbg=2
  hi DiffDelete ctermfg=black ctermbg=1
  hi ColorColumn ctermbg=236
  hi Pmenu ctermfg=white ctermbg=236
  hi PmenuSel ctermfg=250 ctermbg=0
  hi ExtraWhitespace ctermbg=88
endfunction
autocmd! ColorScheme default call s:new_colors()

colorscheme default

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
autocmd TermOpen * startinsert
autocmd TermOpen * set nonumber
autocmd TermOpen * echo "To exit insert mode, use <C-\\><C-n>"

" Plain text
autocmd FileType text set spell

" C
autocmd FileType c nnoremap <leader><leader>c :!gcc -o %:r % -lm<CR>
autocmd FileType c nnoremap <leader><leader>r :term ./%:r<CR>
autocmd FileType c,java imap {<CR> {<CR>}<ESC>ka<CR>
autocmd FileType c imap MAIN int main(void)<CR>{<CR><CR>return 0;<ESC>kO
autocmd FileType c imap STDIO #include <stdio.h>
autocmd FileType c imap STDLIB #include <stdlib.h>
autocmd FileType c imap STRING #include <string.h>

autocmd FileType c,java nnoremap <leader>ta :CtrlPTag<CR>
autocmd FileType c,java nnoremap <leader>p :CtrlPTag<CR>
autocmd FileType c,java
      \ autocmd BufWritePost <buffer> silent! !ctags %

" Java
autocmd FileType java set colorcolumn=100

" CSS autocmds
autocmd FileType css,javascript imap {<CR> {<CR>}<ESC>O

" Markdown
autocmd FileType markdown nnoremap <leader><leader>r :MarkdownPreview<CR>

autocmd FileType json set conceallevel=0

" ===================================
" Plugin Configurations

" latex-suite / vim-latex
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
autocmd FileType tex map <f3> <esc>:w<cr><leader>ll<CR>


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
noremap <leader>c<space> :call NERDComment(1, 'toggle')<CR>


" indentLine
let g:indentLine_setConceal = 0
let g:indentLine_fileTypeExclude = ['markdown', 'pandoc']
set concealcursor=nc
set conceallevel=2


" Pandoc
let g:pandoc#folding#level = 1
let g:pandoc#folding#mode = "relative"
let g:pandoc#spell#enabled = 0
let g:pandoc#syntax#codeblocks#embeds#langs = ["c", "java"]


" ALE
nnoremap <F8> :ALEFix<CR>
let g:ale_lint_on_text_changed = 'normal'
let g:ale_line_on_insert_leave = 1
let g:ale_linters = {
\   'cs' : [],
\}
let g:ale_linter_aliases = {
\   'html': ['html', 'css', 'javascript'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'c': ['astyle'],
\   'java': ['google_java_format'],
\   'javascript': ['eslint'],
\   'python': ['black'],
\}
