Scriptname _REAL_SleepQuestScript extends Quest  
{This quest script is used to manage conditions for the REAL Sleep mod.}

float sleepStartTime ;Used to calculate time slept when player wakes.
float lastUpdateTime ;Used to calculate elapsed time between updates
float sleepValue ;Amount of applied sleep int hours on a scale of 0 to [Max hours property].
float exhaustion ;Cached value representing the current exhaustion state

Event OnInit()
	sleepStartTime = 0
	sleepValue = sleepInitValue
	exhaustion = -1
	SetObjectiveDisplayed(10, false)
	RegisterForSleep() ; Before we can use OnSleepStart we must register.
	RegisterForUpdate(10) ; Update every 10 seconds to reduce sleep value.
endEvent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	;Debug.Trace("Player went to sleep at: " + Utility.GameTimeToString(afSleepStartTime))
	;Debug.Trace("Player wants to wake up at: " + Utility.GameTimeToString(afDesiredSleepEndTime))
	;Debug.Trace("The current time is: " + Utility.GetCurrentGameTime() + " in game days passed")
	sleepStartTime = Utility.GetCurrentGameTime()
endEvent

Event OnSleepStop(bool abInterrupted)
	float currentTime = Utility.GetCurrentGameTime()
	lastUpdateTime = currentTime
	sleepValue += (currentTime - sleepStartTime) * 24
	if (sleepValue > sleepMaxHours)
		;The player has over the maximum hours of applied sleep
		sleepValue = sleepMaxHours
	endIf
	if (sleepValue > sleepWarnValue)
		SetExhaustion(0)
	else
		SetExhaustion(1)
	endIf
endEvent

Event OnUpdate()
	
	float currentTime = Utility.GetCurrentGameTime()
	
	;Init last update time if needed
	if (lastUpdateTime == 0)
		Debug.Notification("Rest for the Wicked")
		SetObjectiveDisplayed(10, false)
		lastUpdateTime = currentTime
	endIf
	
	if (Game.GetPlayer().GetSleepState() == 0)
		; Calculate and apply sleep loss
		float elapsedTime = (currentTime - lastUpdateTime) * 24
		if (elapsedTime > 1)
			sleepValue -= sleepLossPerHour * elapsedTime
			lastUpdateTime = currentTime
			;Debug.Notification("Update sleep " + sleepValue)
		endIf
		
		;Apply exhaustion state
		if (sleepValue <= 0)
			;The player is running on 0 hours of applied sleep
			sleepValue = 0
			SetExhaustion(2)
		elseif (sleepValue <= sleepWarnValue)
			;The player's sleep value is below the warning value
			SetExhaustion(1)
		endif
	endif
	
endEvent

Function SetExhaustion(int aiValue)
	if (exhaustion != aiValue)
		exhaustion = aiValue
		if (exhaustion == 0)
			;Set rested state
			Game.GetPlayer().RemoveSpell(_REAL_Exhausted)
		elseIf (exhaustion == 1)
			;Set warning state
			Game.GetPlayer().RemoveSpell(_REAL_Exhausted)
			Debug.Notification("You are somewhat tired.")
		elseIf (exhaustion == 2)
			;Set exhausted state
			Game.GetPlayer().AddSpell(_REAL_Exhausted, false)
			Debug.Notification("You are exhausted and need to rest.")
		endIf
	endIf
endFunction

;PROPERTIES
float Property sleepInitValue Auto
float Property sleepWarnValue Auto
float Property sleepLossPerHour Auto
float Property sleepMaxHours Auto
SPELL Property _REAL_Exhausted  Auto  
