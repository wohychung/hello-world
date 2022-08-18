colo torte

filetype on
filetype plugin on
syntax on

set nobackup
set bs=2
set ai
set si
set ruler
set sw=2
set ts=2
set tw=1000
set nowrap
set background=dark
set nu
set hlsearch

set cursorline
highlight CursorLine ctermfg=NONE ctermbg=54 cterm=bold

function! Add_timestamp()
	let current_time = strftime('%Y%m%d_%H%M%S')
	let current_file_name = expand('%:r')
	let current_file_extension = expand('%:e')
	let new_filename = join([current_file_name, '_', current_time, '.', current_file_extension], '')
	let current_line = line('.')
	exec "w ".new_filename
	exec "e! ".new_filename
	exec current_line
endfunction

function! Write_with_timestamp()
	exec "w"
	let current_time = strftime('%Y%m%d_%H%M%S')
	let current_file_name = expand('%:r')
	let current_file_extension = expand('%:e')
	let new_filename = join(['history/', current_file_name, '_', current_time, '.', current_file_extension], '')
	exec "w ".new_filename
endfunction

function! Save_to_archive(comment)
	exec "w"
	let current_time = strftime('%Y%m%d_%H%M%S')
	let current_file_name = expand('%:r')
	let current_file_extension = expand('%:e')
	let new_filename = join([current_file_name, '_', current_time, '.', current_file_extension], '')
	let archive_filename = join([current_file_name, '_', current_time, '_', a:comment, '.', current_file_extension], '')
	let current_line = line('.')
	exec "w Archive/".archive_filename
endfunction

function! Execute_python()
	call Write_with_timestamp()
	exec "!python ".@%
endfunction
	
:nnoremap <F5> "=strftime("[%Y/%m/%d %H:%M:%S][wohychung] ")<CR>P
:inoremap <F5> <C-R>=strftime("[%Y/%m/%d %H:%M:%S][wohychung] ")<CR>

command! WW :call Add_timestamp()
command! W :call Write_with_timestamp()
command! -nargs=+ A call Save_to_archive(<q-args>)
command! Py :call Execute_python()

