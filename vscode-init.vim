if exists('g:vscode')
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

    " The Tim Pope Section
    call minpac#add('tpope/vim-abolish')
    call minpac#add('tpope/vim-cucumber')
    call minpac#add('tpope/vim-projectionist', {'type': 'opt'})
    call minpac#add('tpope/vim-repeat')
    call minpac#add('tpope/vim-scriptease', {'type': 'opt'})
    call minpac#add('tpope/vim-surround')
    call minpac#add('tpope/vim-unimpaired')

    " Make the status line pretty
    call minpac#add('vim-airline/vim-airline')
    call minpac#add('vim-airline/vim-airline-themes')

    " Snippets
    call minpac#add('honza/vim-snippets')

  endif

  " Define user commands for updating/cleaning the plugins.
  " Each of them loads minpac, reloads .vimrc to register the
  " information of plugins, then performs the task.
  command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
  command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

  " Enable integration with airline.
  let g:airline#extensions#ale#enabled = 1

  if has("persistent_undo")
    set undodir=~/.config/nvim/runtime/vscode-undo/
    set undofile
  endif

  if exists('+backupdir')
    set backupdir=~/.config/nvim/runtime/vscode-backup//
    set directory=~/.config/nvim/runtime/vscode-backup//
    " === BACKUP SETTINGS ===
    " turn backup OFF
    " Normally we would want to have it turned on. See bug and workaround below.
    " OBS: It's a known-bug that backupdir is not supporting
    " the correct double slash filename expansion
    " see: https://code.google.com/p/vim/issues/detail?id=179
    set nobackup

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

  " switch to upper/lower window quickly
  map <C-J> <C-W>j
  map <C-K> <C-W>k
  map <C-H> <C-W>h
  map <C-L> <C-W>l

  " F1 reserved for help

  " Toggle search highlight
  nmap <silent> <F3> :set hls!<CR>


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

endif " VSCode 