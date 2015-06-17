set nocompatible              " be iMproved, required
filetype off                  " required

syntax on
set background=dark


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""   VUNDLE 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
	" alternatively, pass a path where Vundle should install plugins
	"call vundle#begin('~/some/path/here')

	" let Vundle manage Vundle, required
	Plugin 'gmarik/Vundle.vim'

	" The following are examples of different formats supported.
	" Keep Plugin commands between vundle#begin/end.
	"
	" plugin on GitHub repo
	Plugin 'tpope/vim-fugitive'
	Plugin 'tpope/vim-surround'

        Plugin 'itchyny/lightline.vim'

	" Syntax highlighter for most languages
	Plugin 'scrooloose/syntastic'

	" load markdown files in browser
	Plugin 'shime/vim-livedown'

	" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" lightline settings
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ }
set laststatus=2
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Clear the styles for misspelled words
hi clear SpellBad
" underline misspelled words
hi SpellBad cterm=underline 
"Set the color to orange-ish
hi SpellBad ctermfg=166 

" Disable folding by default in Markdown files
let g:vim_markdown_folding_disabled=1

set autoindent " auto indent after {
set shiftwidth=2 " number of space characters inserted for indentation
set expandtab " inserts spaces instead of tabs
set tabstop=2 " number of spaces the tab is.
set bs=indent,eol,start		" allow backspacing over everything in insert mode

" Word wrapping visually, but no explicit line break unless Enter explicitly
" pressed
set wrap
set linebreak
set nolist  " list disables linebreak
set textwidth=0
set wrapmargin=0


" Allow j and k keys to move cursor through soft wrapped lines, AND still
" allow for relative numbers
nnoremap <silent> k :<C-U>call Up(v:count)<CR>
vnoremap <silent> k gk

nnoremap <silent> j :<C-U>call Down(v:count)<CR>
vnoremap <silent> j gj

function! Down(vcount)
  if a:vcount == 0
    exe "normal! gj"
  else
    exe "normal! ". a:vcount ."j"
  endif
endfunction

function! Up(vcount)
  if a:vcount == 0
    exe "normal! gk"
  else
    exe "normal! ". a:vcount ."k"
  endif
endfunction


" Line numbers and relative line numbers, and a mapping to turn them on and off.
set relativenumber
set number
:nmap <C-N><C-N> :set invnumber <bar> :set invrelativenumber<CR>



" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%


set splitbelow
set splitright

""""""""""""""""""""""""""""""""""""""""
"http://github.com/shime/vim-livedown
""""""""""""""""""""""""""""""""""""""""
" should markdown preview get shown automatically upon opening markdown buffer
let g:livedown_autorun = 1
" should the browser window pop-up upon previewing
let g:livedown_open = 1 
" the port on which Livedown server will run
let g:livedown_port = 1337
"global function you can call explicitly for previews
map gm :call LivedownPreview()<CR>
""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""
" Automatic Paste mode
""""""""""""""""""""""""""""""""""""""""
function! WrapForTmux(s)
    if !exists('$TMUX')
        return a:s
    endif

    let tmux_start = "\<Esc>Ptmux;"
    let tmux_end = "\<Esc>\\"

    return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""
" following from: http://amix.dk/vim/vimrc.html
""""""""""""""""""""""""""""""""""""""""
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload
""""""""""""""""""""""""""""""""""""""""
