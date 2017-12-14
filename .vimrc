" misc
set nowrap
set number
set tabstop=4
set list
set list listchars=tab:+-,trail:+,precedes:«,extends:»
                               " highlight tabs, trailing spaces and wraps
set colorcolumn=80             " print vertical line at max text width
set winminheight=0             " minimize buffers to height 0
set modeline
set smartcase                  " when searching treat capitals as capitals
                               " and small chars as small or capital

set hlsearch                   " highlight matches of last search
set incsearch                  " search while typing
set history=500                " max size of undo-history
set showcmd                    " display incomplete commands
set backspace=indent,eol,start " allow spacing over everything in insert mode
set paste
set ruler
set wildmode=list:longest      " complete commandline paths to longest match
                               " and show list of full matches
set scrolloff=3

" mappings
map <C-Down> <Down><Down><Down><Down>
map <C-Up> <Up><Up><Up><Up>

" colors and highlighting
colorscheme koehler
hi ColorColumn ctermbg=darkgrey guibg=darkgrey
