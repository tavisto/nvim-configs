
" For a paranoia.
" Normally `:set nocp` is not needed, because it is done automatically
" when .vimrc is found.
if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif

" Try to load minpac.
packadd minpac
call minpac#init()

if !exists('g:loaded_minpac')
  " minpac is not available.

  " Settings for plugin-less environment.
else
  " minpac is loaded.
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Lspconfig
  call minpac#add('neovim/nvim-lspconfig')
  call minpac#add('hrsh7th/cmp-nvim-lsp')
  call minpac#add('hrsh7th/cmp-buffer')
  call minpac#add('hrsh7th/cmp-path')
  call minpac#add('hrsh7th/cmp-cmdline')
  call minpac#add('hrsh7th/nvim-cmp')
  call minpac#add('williamboman/mason.nvim')
  call minpac#add('williamboman/mason-lspconfig.nvim')
  call minpac#add('jose-elias-alvarez/null-ls.nvim')

  " Snippest
  call minpac#add('L3MON4D3/LuaSnip')
  call minpac#add('saadparwaiz1/cmp_luasnip')
  call minpac#add('rafamadriz/friendly-snippets')

  " Additional plugins here.
  call minpac#add('junegunn/fzf')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('junegunn/vim-easy-align')

  call minpac#add('vim-scripts/AnsiEsc.vim')
  call minpac#add('vim-scripts/cecutil')

  call minpac#add('takac/vim-hardtime')
  call minpac#add('mbbill/undotree')

  " call minpac#add('mtth/scratch.vim')

  call minpac#add('scrooloose/nerdtree')
  call minpac#add('Xuyuanp/nerdtree-git-plugin')


  " Treesitter
  call minpac#add('nvim-treesitter/nvim-treesitter')
  call minpac#add('rcarriga/nvim-notify')

  " Telescope
  call minpac#add('nvim-lua/plenary.nvim')
  call minpac#add('nvim-telescope/telescope.nvim')

  " Linter to fill in the gaps
  call minpac#add('mfussenegger/nvim-lint')

  " Languages
  call minpac#add('CH-DanReif/haproxy.vim')
  call minpac#add('chr4/nginx.vim')
  call minpac#add('ekalinin/Dockerfile.vim')
  call minpac#add('vim-scripts/groovy.vim')
  call minpac#add('wgwoods/vim-systemd-syntax')
  call minpac#add('tbastos/vim-lua')
  call minpac#add('google/vim-jsonnet')
  call minpac#add('tsandall/vim-rego')
  call minpac#add('gregjurman/vim-nc')
  call minpac#add('isobit/vim-caddyfile')

  " Go
  call minpac#add('fatih/vim-go')
  call minpac#add('sebdah/vim-delve')

  call minpac#add('hashivim/vim-hashicorp-tools')
  call minpac#add('hashivim/vim-terraform')
  call minpac#add('martinda/Jenkinsfile-vim-syntax')
  call minpac#add('mustache/vim-mustache-handlebars')
  call minpac#add('nathanielc/vim-tickscript')
  call minpac#add('othree/html5.vim')
  call minpac#add('pearofducks/ansible-vim')
  call minpac#add('plasticboy/vim-markdown')

  " Ruby
  call minpac#add('sheerun/rspec.vim')
  call minpac#add('vim-ruby/vim-ruby')

  " Puppet
  call minpac#add('rodjek/vim-puppet')
  call minpac#add('farkasmate/epp-syntax-vim')

  " Python
  call minpac#add('Vimjas/vim-python-pep8-indent')
  call minpac#add('vim-python/python-syntax')
  call minpac#add('cespare/vim-toml')

  " Javascript
  call minpac#add('leafgarland/typescript-vim')
  call minpac#add('pangloss/vim-javascript')
  call minpac#add('peitalin/vim-jsx-typescript')
  call minpac#add('jparise/vim-graphql')

  " Mermaid Diagrams
  call minpac#add('zhaozg/vim-diagram')

  " Splunk config files and SPL
  call minpac#add('yorokobi/vim-splunk')

  " EditorConfig support
  call minpac#add('editorconfig/editorconfig-vim')

  " The Tim Pope Section
  call minpac#add('tpope/vim-abolish')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-cucumber')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tpope/vim-git')
  call minpac#add('tpope/vim-projectionist', {'type': 'opt'})
  call minpac#add('tpope/vim-repeat')
  call minpac#add('tpope/vim-scriptease', {'type': 'opt'})
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-unimpaired')

  " Make the status line pretty
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('vim-airline/vim-airline-themes')

  " Complete the list
  call minpac#add('honza/vim-snippets')

  " Color Themes
  call minpac#add('cocopon/iceberg.vim')
  call minpac#add('lifepillar/vim-solarized8')
  call minpac#add('whatyouhide/vim-gotham')
  call minpac#add('nanotech/jellybeans.vim')

  " Yaml
  call minpac#add('pedrohdz/vim-yaml-folds')
  call minpac#add('towolf/vim-helm')

endif

" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

colorscheme gotham256
set termguicolors


" Put the error list into the local list window
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_open_list = 1

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1


" Easy Align mappings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" Fix from github comment: https://github.com/mhinz/vim-grepper/issues/244#issuecomment-892227766
" Just sets grepprg to ripgrep and maps some quick aliases to it, no need for a plugin.
set grepprg=rg\ --vimgrep\ --smart-case
set grepformat=%f:%l:%c:%m,%f:%l:%m

nnoremap <Leader>/ :silent grep<Space>
nnoremap gs :silent grep <C-r><C-w><CR>:copen<CR>
xnoremap gs "sy:silent grep <C-r>s<CR>:copen<CR>


if has("persistent_undo")
  set undodir=~/.config/nvim/runtime/undo/
  set undofile
endif

if exists('+backupdir')
  set backupdir=~/.config/nvim/runtime/backup//
  set directory=~/.config/nvim/runtime/backup//
  " === BACKUP SETTINGS ===
  " turn backup OFF
  " Normally we would want to have it turned on. See bug and workaround below.
  " OBS: It's a known-bug that backupdir is not supporting
  " the correct double slash filename expansion
  " see: https://code.google.com/p/vim/issues/detail?id=179
  set nobackup

  " set a centralized backup directory

  " This is the workaround for the backup filename expansion problem.
  autocmd BufWritePre * :call SaveBackups()

  function! SaveBackups()
    if expand('%:p') =~ &backupskip | return | endif

    " If this is a newly created file, don't try to create a backup
    if !filereadable(@%) | return | endif

    for l:backupdir in split(&backupdir, ',')
      :call SaveBackup(l:backupdir)
    endfor
  endfunction

  function! SaveBackup(backupdir)
    let l:filename = expand('%:p')
    if a:backupdir =~ '//$'
      let l:backup = escape(substitute(l:filename, '/', '%', 'g')  . &backupext, '%')
    else
      let l:backup = escape(expand('%') .  &backupext, '%')
    endif

    let l:backup_path = a:backupdir . l:backup
    :silent! execute '!cp' .  resolve(l:filename) . ' ' .  l:backup_path
  endfunction
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

" Scroll when cursor gets within 3 characters of top/bottom edge
set scrolloff=3
set scrolljump=5 " Set the scroll jump to be 5 lines


" Airline Config
let g:airline_detect_paste=1
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


"
" Key Mappings
"

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
nmap <silent> <F5> <Plug>Commentary
vmap <silent> <F5> <Plug>Commentary

" use <F6> to toggle line numbers
nmap <silent> <F6> :set number!<CR>
nmap <silent> <leader><F6> :set relativenumber!<CR>

" use <F7> to togle folding
nmap <silent> <F7> za

" map <F8>
nmap <silent> <F8> :Telescope live_grep<cr>

" Togle showing non printing chars
nmap <silent> <F9> :set list!<CR>

" Togle paste mode on and off with F10
set pastetoggle=<F10>

" Add current buffer to diff
nmap <silent> <F11> :diffthis<CR>
nmap <silent> <leader><F11> :diffoff!<CR>

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
au BufRead,BufNewFile *Corefile   setfiletype caddyfile

if has('nvim')
  " Terminal Mode Settigs
  highlight! link TermCursor Cursor
  highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
endif

" All things go related
" TODO: Move these to their own file or something
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

let g:go_auto_type_info = 1
let g:go_auto_sameids = 1

let g:go_fmt_command = "goimports"

" Disable vim-go completion
let g:go_code_completion_enabled = 0
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

let g:go_metalinter_enabled = ['deadcode' ,'errcheck' ,'gocyclo' ,'golint' ,'gosimple' ,'govet' ,'ineffassign' ,'maligned' ,'staticcheck' ,'structcheck' ,'typecheck' ,'unused' ,'varcheck' ,'vet']

" Set markdown folding to be the lowest level insetad of highest
" let g:vim_markdown_folding_level = 6
" Disable markdown folding entirely because it gets annoying
let g:vim_markdown_folding_disabled = 1


" Set the default fold level to fairly deep by default
set foldlevelstart=5


au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
lua <<EOF
require('treesitter')
require('nvim-cmp')
require('nvim-lspconfig')
require('config-luasnip')
require('nvim-lint')
require('nvim-notify')
require("config-mason")
EOF
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

au BufWritePost <buffer> lua require('lint').try_lint()


" luasnip
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'


" Telescope bindings
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fG <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Handy base64 deadcode
:vnoremap <leader>64 c<c-r>=system('base64 --decode', @")<cr><esc>

" Terraform defaults
let g:terraform_fmt_on_save=1 " Format all terraform on save
let g:terraform_fold_sections=1 " Fold all terraform sections by default
