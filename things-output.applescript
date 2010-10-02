property crlf : (ASCII character 13) & (ASCII character 10)

property whichList: "Someday"

set newFile to (path to desktop as Unicode text) & text returned of (display dialog "Output todos to file:" default answer "")
set fh to (open for access file newFile with write permission)

tell application "Things"
	repeat with todo in to dos of list whichList
		set nm to name of todo & crlf
		write nm to fh
	end repeat
end tell

close access fh
