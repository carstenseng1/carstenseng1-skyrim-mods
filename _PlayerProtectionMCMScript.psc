Scriptname _PlayerProtectionMCMScript extends SKI_ConfigBase  

_PlayerProtectionPlayerAliasScript Property PlayerAlias  Auto  

Int enabledOID
Int debugNotificationsOID
bool enabled = true
bool debugNotifications = true

event OnPageReset(string page)
	{Called when a new page is selected, including the initial empty page}
	
	SetCursorFillMode(LEFT_TO_RIGHT)
	enabledOID = AddToggleOption("Enabled", enabled)
	AddEmptyOption()
	debugNotificationsOID = AddToggleOption("Debug Notifications", debugNotifications)
endEvent

event OnOptionSelect(int option)
	{Called when a non-interactive option has been selected}
	if (option == enabledOID)
		enabled = !enabled
		SetToggleOptionValue(enabledOID, enabled)
		PlayerAlias.EnableImmortalDragonborn(enabled)
	elseIf (option == debugNotificationsOID)
		debugNotifications = !debugNotifications
		SetToggleOptionValue(debugNotificationsOID, debugNotifications)
		if (debugNotifications)
			Debug.Notification("Debug notifications enabled for Immortal Dragonborn")
		endIf
	endIf
endEvent

event OnOptionDefault(int option)
	if (option == enabledOID)
		enabled = PlayerAlias.enabled
		SetToggleOptionValue(enabledOID, enabled)
	elseIf (option == debugNotificationsOID)
		debugNotifications = false
		SetToggleOptionValue(debugNotificationsOID, debugNotifications)
	endIf
endEvent

event OnOptionHighlight(int option)
	if (option == enabledOID)
		SetInfoText("Enable Immortal Dragonborn.  Use this to disable the mod before uninstalling.")
	elseIf (option == debugNotificationsOID)
		SetInfoText("Enable debug notifications for Immortal Dragonborn.")
	endIf
endEvent

bool Function IsDebugNotificationsEnabled()
	return debugNotifications
endFunction 

Function Notification(string aNotification)
	if (debugNotifications)
		Debug.Notification(aNotification)
	endIf
endFunction
