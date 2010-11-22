--
--  converterAppDelegate.applescript
--  converter
--
--  Created by 黒澤 隆之 on 10/11/20.
--  Copyright 2010 Renesas Technology Corp. All rights reserved.
--

script converterAppDelegate
	property parent : class "NSObject"
	property srccurr : missing value -- source currency code
	property dstcurr : missing value -- distination currency code
	property srctext : missing value
	property dsttext : missing value
	property ratelabel : missing value
	property rate : 1
	
	on applicationWillFinishLaunching_(aNotification)
		my currencyChanged_(aNotification)
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
	on dstchanged_(sender)
		set the c to dsttext's floatValue()
		tell srctext to setFloatValue_(c / rate)
	end dstchanged_
	
	on srcChanged_(sender)
		set the c to srctext's floatValue()
		tell dsttext to setFloatValue_(c * rate)
	end srcChanged_
	
	on currencyChanged_(sender)
		set src to title of srccurr as string
		set dst to title of dstcurr as string
		
		tell application "Finder"
			activate
			set temp to ((path to temporary items folder from user domain) as string) & "exchangerate.tmp"
		end tell
		
		tell application "URL Access Scripting"
			activate
			try
				download "http://www.exchangerate-api.com/" & dst & "/" & src & "?k=aQ8fO-K26MB-gnBsY" to file temp ¬
					replacing yes with progress
			on error errMsg
				display dialog errMsg
			end try
			
			quit
		end tell
		--		close access file rateFile
		tell application "Finder"
			activate
			try
				set rate to read file temp
				delete file temp
			on error errMsg
				display dialog "error" & errMsg
			end try
			tell ratelabel to setStringValue_("1" & src & "=" & (rate as string) & dst)
		end tell
		
	end currencyChanged_
	
end script
