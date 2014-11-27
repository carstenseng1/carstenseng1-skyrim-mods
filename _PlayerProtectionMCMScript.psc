Scriptname _PlayerProtectionMCMScript extends SKI_ConfigBase  

_PlayerProtectionPlayerAliasScript Property PlayerAlias  Auto  
GlobalVariable Property _player_protection_enabled Auto
GlobalVariable Property _player_protection_stunEnabled  Auto  
GlobalVariable Property _player_protection_debugNotifications Auto

Int enabledOID
Int stunEnabledOID
Int debugNotificationsOID

event OnPageReset(string page)
	{Called when a new page is selected, including the initial empty page}
	
	SetCursorFillMode(LEFT_TO_RIGHT)
	enabledOID = AddToggleOption("Enabled", _player_protection_enabled.GetValue())
	AddEmptyOption()
	
	stunEnabledOID = AddToggleOption("Soul Blast Effect", _player_protection_stunEnabled.GetValue())
	AddEmptyOption()

	debugNotificationsOID = AddToggleOption("Debug Notifications", _player_protection_debugNotifications.GetValue())
endEvent

event OnOptionSelect(int option)
	{Called when a non-interactive option has been selected}
	if (option == enabledOID)
		if (_player_protection_enabled.GetValue())
			_player_protection_enabled.SetValue(0)
		else
			_player_protection_enabled.SetValue(1)
		endIf
		SetToggleOptionValue(enabledOID, _player_protection_enabled.GetValue())
		PlayerAlias.EnableImmortalDragonborn(_player_protection_enabled.GetValue())
	elseIf (option == stunEnabledOID)
		if (_player_protection_stunEnabled.GetValue())
			_player_protection_stunEnabled.SetValue(0)
		else
			_player_protection_stunEnabled.SetValue(1)
		endIf
		SetToggleOptionValue(stunEnabledOID, _player_protection_stunEnabled.GetValue())
	elseIf (option == debugNotificationsOID)
		if (_player_protection_debugNotifications .GetValue())
			_player_protection_debugNotifications .SetValue(0)
		else
			_player_protection_debugNotifications .SetValue(1)
		endIf
		SetToggleOptionValue(debugNotificationsOID, _player_protection_debugNotifications.GetValue())
		if (_player_protection_debugNotifications.GetValue())
			Debug.Notification("Debug notifications enabled for Immortal Dragonborn")
		endIf
	endIf
endEvent

event OnOptionDefault(int option)
	if (option == enabledOID)
		SetToggleOptionValue(enabledOID, _player_protection_enabled.GetValue())
	elseIf (option == stunEnabledOID)
		SetToggleOptionValue(stunEnabledOID, _player_protection_stunEnabled.GetValue())
	elseIf (option == debugNotificationsOID)
		SetToggleOptionValue(debugNotificationsOID, _player_protection_debugNotifications.GetValue())
	endIf
endEvent

event OnOptionHighlight(int option)
	if (option == enabledOID)
		SetInfoText("Enable Immortal Dragonborn.  Use this to disable the mod before uninstalling.")
	elseIf (option == stunEnabledOID)
		SetInfoText("Cast a powerful stunning blast when you revive.")
	elseIf (option == debugNotificationsOID)
		SetInfoText("Enable debug notifications for Immortal Dragonborn.")
	endIf
endEvent

Function Notification(string aNotification)
	if (_player_protection_debugNotifications.GetValue())
		Debug.Notification(aNotification)
	endIf
endFunction
