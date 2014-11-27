Scriptname _ENEMY_COUNT_MCMScript extends SKI_ConfigBase  

_ENEMY_COUNT_QuestScript Property _ENEMY_COUNT_Quest Auto

Int enabledOID
Int debugNotificationsOID
Int spawnCountOID
Int spawnChanceInteriorOID
Int spawnChanceExteriorOID

event OnPageReset(string page)
	{Called when a new page is selected, including the initial empty page}
	
	SetCursorFillMode(LEFT_TO_RIGHT)
	enabledOID = AddToggleOption("Enabled", _ENEMY_COUNT_Quest.enabled)
	AddEmptyOption()
	
	debugNotificationsOID = AddToggleOption("Debug Notifications", _ENEMY_COUNT_Quest.debugNotifications)
	AddEmptyOption()
	
	spawnCountOID = AddSliderOption("Spawn Count", _ENEMY_COUNT_Quest.spawnCount, "{0}")
	AddEmptyOption()
	
	spawnChanceInteriorOID = AddSliderOption("Interior Spawn Chance", _ENEMY_COUNT_Quest.spawnChanceInterior, "{2}")
	AddEmptyOption()
	
	spawnChanceExteriorOID = AddSliderOption("Exterior Spawn Chance", _ENEMY_COUNT_Quest.spawnChanceExterior, "{2}")
endEvent

event OnOptionDefault(int option)
	if (option == enabledOID)
		SetToggleOptionValue(enabledOID, _ENEMY_COUNT_Quest.enabled)
	elseIf (option == debugNotificationsOID)
		SetToggleOptionValue(debugNotificationsOID, _ENEMY_COUNT_Quest.debugNotifications)
	elseIf (option == spawnCountOID)
		SetSliderOptionValue(spawnCountOID, _ENEMY_COUNT_Quest.spawnCount, "{0}")
	elseIf (option ==spawnChanceInteriorOID)
		SetSliderOptionValue(spawnChanceInteriorOID, _ENEMY_COUNT_Quest.spawnChanceInterior, "{2}")
	elseIf (option ==spawnChanceExteriorOID)
		SetSliderOptionValue(spawnChanceExteriorOID, _ENEMY_COUNT_Quest.spawnChanceExterior, "{2}")
	endIf
endEvent

event OnOptionHighlight(int option)
	if (option == enabledOID)
		SetInfoText("Enable Enemizer.")
	elseIf (option == debugNotificationsOID)
		SetInfoText("Enable debug notifications for Enemizer.")
	elseIf (option == spawnCountOID)
		SetInfoText("Adjust the number of times each enemy will attempt to spawn a similar enemy.")
	elseIf (option == spawnChanceInteriorOID)
		SetInfoText("Adjust the chance that an enemy will spawn in an interior environment.")
	elseIf (option == spawnChanceExteriorOID)
		SetInfoText("Adjust the chance that an enemy will spawn in an exterior environment.")
	endIf
endEvent

event OnOptionSliderOpen(int option)
	 if (option == spawnCountOID)
       	 SetSliderDialogStartValue(_ENEMY_COUNT_Quest.spawnCount)
       	 SetSliderDialogDefaultValue(2)
       	 SetSliderDialogRange(1, 10)
       	 SetSliderDialogInterval(1)
	
	 elseIf (option == spawnChanceInteriorOID)
        	SetSliderDialogStartValue(_ENEMY_COUNT_Quest.spawnChanceInterior)
        	SetSliderDialogDefaultValue(0.5)
        	SetSliderDialogRange(0, 1)
        	SetSliderDialogInterval(0.1)

	 elseIf (option == spawnChanceExteriorOID)
       	 SetSliderDialogStartValue(_ENEMY_COUNT_Quest.spawnChanceExterior)
       	 SetSliderDialogDefaultValue(0.5)
       	 SetSliderDialogRange(0, 1)
       	 SetSliderDialogInterval(0.1)

    endIf
endEvent

event OnOptionSelect(int option)
	{Called when a non-interactive option has been selected}
	if (option == enabledOID)
		_ENEMY_COUNT_Quest.enabled = !_ENEMY_COUNT_Quest.enabled
		SetToggleOptionValue(enabledOID, _ENEMY_COUNT_Quest.enabled)
	elseIf (option == debugNotificationsOID)
		_ENEMY_COUNT_Quest.debugNotifications = !_ENEMY_COUNT_Quest.debugNotifications
		SetToggleOptionValue(debugNotificationsOID, _ENEMY_COUNT_Quest.debugNotifications)
	endIf
endEvent

event OnOptionSliderAccept(int option, float value)
	 if (option == spawnCountOID)
		 _ENEMY_COUNT_Quest.spawnCount = value as Int
		 SetSliderOptionValue(option, value, "{0}")

	 elseIf (option == spawnChanceInteriorOID)
      	  	_ENEMY_COUNT_Quest.spawnChanceInterior = value
        	SetSliderOptionValue(option, value, "{2}")
	
	elseIf (option == spawnChanceExteriorOID)
		 _ENEMY_COUNT_Quest.spawnChanceExterior = value
		SetSliderOptionValue(option, value, "{2}")

    endIf
endEvent