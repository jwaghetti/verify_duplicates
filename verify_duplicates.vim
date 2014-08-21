
function! RemoveUniqueEntries() 

	let l:hasDuplicate = 0
	let l:currentMd5Sum = 0
	let l:nextMd5Sum = 0
	let l:line = 1
	let l:totalLines = line ('$') 
	
	execute "%!sort"

	while l:line <= l:totalLines
	
		let l:totalLines = line('$')

		execute line

		let l:currentMd5Sum = expand("<cword>")

		let l:line = l:line + 1
		if l:line > l:totalLines
			execute "d"
			return	
		endif
		execute l:line

		let l:nextMd5Sum = expand("<cword>")

		if l:currentMd5Sum == l:nextMd5Sum
			let l:hasDuplicate = 1
		else
			let l:hasDuplicate = 0
			execute "-d"
			let l:line = l:line - 1
		endif	

		while l:hasDuplicate !~ 0

			let l:line = l:line + 1
			if l:line > l:totalLines
				return
			endif
			execute line

			let l:nextMd5Sum = expand("<cword>")

			if l:currentMd5Sum == l:nextMd5Sum
				let l:hasDuplicate = 1
			else
				let l:hasDuplicate = 0
			endif

		endwhile

	endwhile

	execute "%s:\V^\\(.*\\) \\(.*\\)$:\\2:"

endfunction

