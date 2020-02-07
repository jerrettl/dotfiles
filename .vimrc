" Location: ~/.vimrc

set nocompatible

" Plug
" If plug is not installed, fetch and install it automatically.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged')

" Syntastic: syntax checking
" Plug 'vim-syntastic/syntastic'

" vim-latex: ease-of-life shortcuts for latex
Plug 'vim-latex/vim-latex', { 'for': 'tex' }

" nerdtree: file exploring side bar
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" vim-fugitive: git control within vim
" Plug 'tpope/vim-fugitive'

" emmet-vim: quick html writing
Plug 'mattn/emmet-vim', { 'for': 'html' }

" vim-closetag: automatically create matching close tags in html
Plug 'alvan/vim-closetag', { 'for': 'html' }

" goyo: distraction-free editing
" Toggle shortcut: F12
Plug 'junegunn/goyo.vim'

" nerdcommenter: shortcuts to comment code
Plug 'scrooloose/nerdcommenter'

" vim-devicons: icons for nerdtree, lightline, etc.
Plug 'ryanoasis/vim-devicons'

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

" Python specific:
"   indentpython: auto intent after : and in multiline statements
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }

"   jedi-vim: completion, renaming, jumping, etc.
" Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Syntax highlighting plugins:
Plug 'hrother/offlineimaprc.vim'

"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'Valloric/YouCompleteMe'
"Plug 'nvie/vim-flake8', { 'for': 'python' }
"Plug 'tpope/vim-unimpaired'

" Pandoc markdown editing
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()


" ===================================


" Basics
let mapleader=","
set encoding=utf8
syntax on           " Syntax highlighting
set mouse=a         " Enable mouse support (yes crucify me)
set tabstop=2       " Tab width
set shiftwidth=2    " Tab width
set softtabstop=0   " Vim will not insert spaces to simulate tabstops
set smarttab        " Tabs at the beginning of a line use shiftwidth, not tabstop
set expandtab       " Use spaces instead of tab characters when pressing tab
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
set display+=lastline  " As much as possible will be displayed, even if the line is cut off (prevents displaying @ on lines that are longer than end of screen)
set shell=/bin/bash
set scrolloff=3     " Set a minimum amount of lines above and below the cursor

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
autocmd BufWritePost ~/dotfiles/aliases/folders,~/dotfiles/aliases/configs !bash ~/dotfiles/scripts/shortcuts.sh
autocmd BufWritePost ~/.Xresources,~/dotfiles/.Xresources !xrdb ~/.Xresources
autocmd BufWritePost ~/.bashrc,~/dotfiles/aliases/aliases !source ~/.bashrc

" ===================================

" Theming
let &t_Co=256
hi search cterm=NONE ctermfg=black ctermbg=yellow
hi spellbad cterm=none ctermfg=white ctermbg=160 "dark red
hi folded cterm=none ctermfg=7 ctermbg=17 "blue
hi LineNr cterm=none ctermfg=251 "grey
hi Visual ctermfg=none ctermbg=239 guibg=Grey

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

" Forgot to get root access before editing? No worries!
cmap w!! w !sudo tee % >/dev/null

cmap Q q
cmap W w

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

" C stuff
autocmd FileType c nnoremap <leader>b !make %:r<cr>
autocmd FileType c nnoremap <C-b> !make %:r<cr>
autocmd FileType c imap {<CR> {<CR>}<ESC>ka<CR>
autocmd FileType c imap MAIN int main(void)<CR>{<CR><CR>return 0;<ESC>kO
autocmd FileType c imap STDIO #include <stdio.h>
autocmd FileType c imap STDLIB #include <stdlib.h>
autocmd FileType c imap STRING #include <string.h>

" CSS autocmds
autocmd FileType css imap {<CR> {<CR>}<ESC>O

" ===================================
" Plugin Configurations

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
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
      \ "mode": "passive",
      \ "active_filetypes": ['python', 'sh'],
      \ "passive_filetypes": [] }
let g:syntastic_python_checkers=['flake8', 'python']
let g:syntastic_sh_checkers=['shellcheck', 'bashate']
nnoremap <F8> :SyntasticCheck<cr>
nnoremap ]sd :lopen<cr>
nnoremap [sd :lclose<cr>
hi SyntasticErrorSign cterm=none ctermfg=white ctermbg=160 "dark red


" flake8
let g:flake8_show_quickfix=0


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
imap <C-t> <Plug>Tex_InsertItemOnThisLine
imap i <Plug>Tex_InsertItemOnThisLine


" Goyo
nnoremap <F12> :Goyo<cr>
imap <F12> <C-o>:Goyo<cr>


" YouCompleteMe
let g:ycm_filetype_blacklist = {
      \ 'tex' : 1
      \}


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



" Make python /comfy/
au BufNewFile,BufRead *.py
      \ set tabstop=4 |
      \ set softtabstop=4 |
      \ set shiftwidth=4 |
      \ set expandtab |
      \ set autoindent |
      \ set fileformat=unix

let python_highlight_all=1


" indentLine
let g:indentLine_setConceal = 0
let g:indentLine_fileTypeExclude = ['markdown', 'pandoc']
set concealcursor=nc
set conceallevel=2


" Pandoc
let g:pandoc#spell#enabled = 0
