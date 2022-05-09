" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_file_line') || (v:version < 700)
	finish
endif
let g:loaded_file_line = 1

function! s:gotoline()

	let file = bufname("%")

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Original plugin code.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"	" :e command calls BufRead even though the file is a new one.
"	" As a workarround Jonas Pfenniger<jonas@pfenniger.name> added an
"	" AutoCmd BufRead, this will test if this file actually exists before
"	" searching for a file and line to goto.
"	if (filereadable(file))
"		return
"	endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" This is my own patch for the plugin in order to make it more convenient,
"" e.g., ignore junk strings around the line/col numbers and at the end of
"" the argument.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

	let file_name = ''
	let line_num = ''
	let col_num = ''

	let file_name_list =  matchlist( file, '\([^:]*\)')
	if !empty(file_name_list)
		let file_name = file_name_list[1]
	endif

	let my_arg =  matchlist( file, ':[^0-9]*\(.*\)')
	if !empty(my_arg)
		let line_num_list =  matchlist( my_arg[1], '\([0-9]*\)')
		if !empty(line_num_list)
			let line_num = line_num_list[1]
			if !empty(my_arg)
				let my_arg =  matchlist( my_arg[1], '[^:]*:[^0-9]*\(.*\)')
				if !empty(my_arg)
					let col_num_list =  matchlist( my_arg[1], '\([0-9]*\)')
					if !empty(col_num_list)
						let col_num = col_num_list[1]
					endif
				endif
			endif
		endif
	endif

	exec ":e " file_name
	if line_num != ''
		if col_num != ''
			exec ":call cursor(" . line_num . ", " . col_num . ")"
		else
			exec ":call cursor(" . line_num . ", 1)"
		endif
	endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Original plugin code.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"	" Accept file:line:column: or file:line:column and file:line also
"	let names =  matchlist( file, '\(.\{-1,}\):\%(\(\d\+\)\%(:\(\d*\):\?\)\?\)\?$')
"
"	if empty(names)
"		return
"	endif
"
"	let file_name = names[1]
"	let line_num  = names[2] == ''? '0' : names[2]
"	let  col_num  = names[3] == ''? '0' : names[3]
"
"	if filereadable(file_name)
"		let l:bufn = bufnr("%")
"		exec ":bwipeout " l:bufn
"
"		exec "keepalt edit " . file_name
"		exec ":" . line_num
"		exec "normal! " . col_num . '|'
"		if foldlevel(line_num) > 0
"			exec "normal! zv"
"		endif
"
"
"		exec "normal! zz"
"	endif

endfunction

autocmd! BufNewFile *:* nested call s:gotoline()
autocmd! BufRead *:* nested call s:gotoline()
