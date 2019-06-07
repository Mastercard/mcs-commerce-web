--  notification.scpt
--  MerchantServices
--
--  Created by Adeyenuwo, Paul on 12/04/16.
--  Copyright (c) 2016 MasterCard. All rights reserved.

tell application "Finder"
	set current_path to container of container of (container of (path to me)) as alias
end tell

tell application "Microsoft Outlook"
	activate
	set newMessage to make new outgoing message with properties {subject:"Jenkins Build Failure", content:"The last changeset to MerchantServices has broken or will break the build after merge. If not already merged, please do not merge this pull request until build is successful. See attached Jenkins Build Log for more details."}
	(make new recipient at newMessage with properties {email address:{name:"Asguardians", address:"paul.adeyenuwo@mastercard.com"}})
	
	set xcodebuild_log to (current_path as Unicode text) & "xcodebuild.log" as alias
	set console_log to (current_path as Unicode text) & "console.log" as alias
	
	make new attachment at the end of newMessage with properties {file:xcodebuild_log}
	make new attachment at the end of newMessage with properties {file:console_log}
	
	send newMessage
end tell
