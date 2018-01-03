set nowrap                " do not wrap text at right border
set number                " show line numbers at the left border
set tabstop=4             " a tab is 4 characters long
set list listchars=tab:+-,trail:+,precedes:«,extends:»
                          " highlight tabs, trailing spaces and text that goes
                          " beyond the left or right border
set colorcolumn=80        " print vertical line at max text width
set winminheight=0        " minimize buffers to height 0
set modeline
set smartcase             " when searching treat capitals as capitals
                          " and small chars as small or capital
set hlsearch              " highlight matches of last search
set incsearch             " search while typing
set history=500           " max size of undo-history
set showcmd               " display incomplete commands
set backspace=indent,eol,start
                          " allow spacing over everything in insert mode
set paste                 " aid in pasting from other applications
set wildmode=list:longest " complete commandline paths to longest match
                          " and show list of full matches
set ruler                 " position information in the lower right corner
set scrolloff=3           " scroll 3 lines before reaching a border

" map <control>+<up|down> to 4 times <up|down>
map <C-Down> <Down><Down><Down><Down>
map <C-Up>   <Up><Up><Up><Up>

" set highlighting colors
colorscheme koehler
hi ColorColumn ctermbg=darkgrey guibg=darkgrey

" try to get to the last cursor position when reopening a file
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


