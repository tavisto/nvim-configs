" For a paranoia.
" Normally `:set nocp` is not needed, because it is done automatically
" when .vimrc is found.
if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif

if exists('*minpac#init')
  " minpac is loaded.
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Additional plugins here.
  call minpac#add('junegunn/fzf')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('junegunn/vim-easy-align')

  call minpac#add('mtth/scratch.vim')

  call minpac#add('scrooloose/nerdtree')
  call minpac#add('Xuyuanp/nerdtree-git-plugin')

  " Languages
  call minpac#add('sheerun/vim-polyglot')
  call minpac#add('fatih/vim-go')
  call minpac#add('hashivim/vim-hashicorp-tools')
  call minpac#add('voxpupuli/vim-puppet')
  call minpac#add('nathanielc/vim-tickscript')
  call minpac#add('zchee/deoplete-jedi')

  " Themes
  call minpac#add('whatyouhide/vim-gotham')

  " Syntax highligting
  call minpac#add('w0rp/ale')

  " The Tim Pope Section
  call minpac#add('tpope/vim-abolish')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-projectionist', {'type': 'opt'})
  call minpac#add('tpope/vim-repeat')
  call minpac#add('tpope/vim-scriptease', {'type': 'opt'})
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-unimpaired')
  call minpac#add('tpope/vim-commentary')

  call minpac#add('mbbill/undotree')

  " Make the status line pretty
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('vim-airline/vim-airline-themes')

  " Call in the Grepper
  call minpac#add('mhinz/vim-grepper')

  " Complete the list
  call minpac#add('Shougo/deoplete.nvim')
  call minpac#add('SirVer/ultisnips')
  call minpac#add('honza/vim-snippets')

endif
let g:deoplete#enable_at_startup = 1

" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

" Set the background to dark
set background=dark
colorscheme gotham

" Mappings for ALE
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)

" Easy Align mappings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

let g:grepper = {}
let g:grepper.tools = ['rg','git', 'grep']

" Search for the current word
nnoremap <Leader>* :Grepper -cword -noprompt<CR>

" Search for the current selection
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" Open Grepper-prompt for a particular Grep-alike tool
nnoremap <Leader>g :Grepper -tool git<CR>
nnoremap <Leader>G :Grepper -tool rg<CR>

function! SetupCommandAlias(input, output)
  exec 'cabbrev <expr> '.a:input
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:input.'")'
        \ .'? ("'.a:output.'") : ("'.a:input.'"))'
endfunction
call SetupCommandAlias("grep", "GrepperRg")

if has("persistent_undo")
  set undodir=~/.config/nvim/runtime/undo/
  set undofile
endif

if exists('+backupdir')
  set backupdir=~/.config/nvim/runtime/backup
  set directory=~/.config/nvim/runtime/backup
endif

" Use menu to show command-line completion (in 'full' case)
set wildmenu

" Set command-line completion mode:
"   Complete longest common string, then list alternatives.
set wildmode=longest,list,full

set mouse=n

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" Allow backspacing over everything
set backspace=indent,eol,start

" Remember up to 5000 'colon' commmands and search patterns
set history=5000

" Make all tabs 2 spaces
" Make tabs delete properly
" Make autoindent add 2 spaces per indent level
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab " Convert all tabs
set smarttab
" Don't auto wrap anything
set nowrap " No wrapping unless I say so.
set textwidth=0
set linebreak " Wrap lines at convenient points

set autoindent " Auto Indent
set smartindent " Smart Indent

set ignorecase
set smartcase

set nohlsearch " Don't Highlight searches
" Always show status line, even for one window
set laststatus=2

" Enable CTRL-A/CTRL-X to work on octal and hex numbers, as well as characters
set nrformats=octal,hex,alpha

" Set the default behavior of opening a buffer to use the one already open
set swb=useopen




" Insert mode completion options
set completeopt=menu,menuone,preview

" Show Whitespace
" highlight WhiteSpaceEOL ctermbg=darkgreen guibg=lightgreen
" match WhiteSpaceEOL /^\s*\ \s*\|\s\+$/
" autocmd WinEnter * match WhiteSpaceEOL /^\s*\ \s*\|\s\+$/
set listchars=tab:▶-,eol:¬,trail:-

" Always show status line, even for one window
set laststatus=2

" Scroll when cursor gets within 3 characters of top/bottom edge
set scrolloff=3
set scrolljump=5 " Set the scroll jump to be 5 lines


" Airline Config
let g:airline_detect_paste=1
let g:airline_theme= "gotham"
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.whitespace = 'Ξ'

" Snippits Configs
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"



"
" Key Mappings
"

" Bubble single lines
nmap <C-k> [e
nmap <C-j> ]e
" " Bubble multiple lines
vmap <C-k> [egv
vmap <C-j> ]egv

" switch to upper/lower window quickly
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" F1 reserved for help

" Toggle NERDTree
nmap <silent> <F2> :NERDTreeToggle<CR>
nmap <silent> <leader><F2> :NERDTreeFind<CR>

" Toggle search highlight
nmap <silent> <F3> :set hls!<CR>

" Rerun last : command
nmap <silent> <F4> :UndotreeToggle<CR>

" Use <F5> to togle comments
nmap <silent> <F5> <Plug>NERDCommenterToggle
vmap <silent> <F5> <Plug>NERDCommenterToggle

" use <F6> to toggle line numbers
nmap <silent> <F6> :set number!<CR>
nmap <silent> <leader><F6> :set relativenumber!<CR>

" use <F7> to togle folding
nmap <silent> <F7> zA

" map <F8>
nmap <silent> <F8> :FZF

" Togle showing non printing chars
nmap <silent> <F9> :set list!<CR>

" Togle paste mode on and off with F10
set pastetoggle=<F10>

" Add current buffer to diff
nmap <silent> <F11> :diffthis<CR>
nmap <silent> <leader><F11> :diffoff!<CR>

" Check current file
nmap <silent> <F12> :ALELint<CR>
" Show error window from synstastic
nmap <silent> <leader><F12> <Plug>(ale_detail)

" Map <leader>mc to count the number of matches the curren search will
" return in the current buffer
nmap <silent> <leader>mc :%s///gn<CR>

" Fix the & command to always preserve flags on searches
" in both normal and visual mode
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Functions!

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

nmap <leader>$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap <leader>= :call Preserve("normal gg=G")<CR>

" Fill date with current timestamp
nnoremap <leader>fd "=strftime("%Y-%m-%dT%T%z")<CR>p

au BufRead,BufNewFile *.pp   setfiletype puppet

if has('nvim')
  " Terminal Mode Settigs
  highlight! link TermCursor Cursor
  highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
endif
