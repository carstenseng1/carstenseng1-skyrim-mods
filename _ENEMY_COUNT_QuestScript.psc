Scriptname _ENEMY_COUNT_QuestScript extends Quest  

bool enabled
bool debugEnabled

Event OnInit()
	enabled = true;
	debugEnabled = false;
endEvent

bool Function IsEnabled()
	return enabled
endFunction

Function SetEnabled(bool aEnabled)
	enabled = aEnabled
endFunction

bool Function IsDebugEnabled()
	return debugEnabled
endFunction

Function SetDebugEnabled(bool aDebugEnabled)
	debugEnabled = aDebugEnabled
endFunction

Function Notification(string aNotification)
	if (debugEnabled)
		Debug.Notification(aNotification)
	endIf
endFunction