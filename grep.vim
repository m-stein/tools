"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" This plugin is a slightly patched version of the grep plugin by romainl
"" (https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3).
"" It enables me to grep with :G inside vim while the results are directly
"" shown in an extra buffer window.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"
" Open file from the grep results in a new window (split) except when there
" already is a window with this file. In the latter case, use that window
" instead (useopen).
"
set switchbuf=useopen,split

" set grepprg=ag\ --vimgrep

function! Grep(...)
"	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
	return system('ag ' . join(a:000, ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar G  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LG lgetexpr Grep(<f-args>)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" This was meant to ensure that :grep is backed by my custom grep command.
"" However, I prefer using :G anyway.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'G'  : 'grep'
"cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LG' : 'lgrep'

augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost cgetexpr cwindow
	autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

" close quickfix window once I select one of the grep results
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
