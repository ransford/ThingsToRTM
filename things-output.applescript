property crlf : (ASCII character 13) & (ASCII character 10)

tell application "Things"
	(* Prompt the user to choose a todo list from Things *)
	set allLists to name of every list
	choose from list allLists with prompt "Which todo list would you like to export?"
	if the result is not false then
		set whichList to item 1 of the result
	end if
	
	(* Prompt for a filename and open the resulting file *)
	set newFile to choose file name with prompt Â
		"Output todos to file:" default name ("Things Todos - " & whichList & ".txt") Â
		default location (path to desktop folder)
	try
		set fh to (open for access newFile with write permission)
	on error errmsg number errno
		display dialog "Error (" & errno & ") opening file: " & errmsg
	end try
	
	(* Write the todos to the output file, one per line *)
	repeat with todo in to dos of list whichList
		set nm to name of todo & crlf
		try
			write nm to fh
		on error errmsg number errno
			display dialog "Error (" & errno & "): " & errmsg
		end try
	end repeat
	
	(* Close the output file *)
	close access fh
end tell
