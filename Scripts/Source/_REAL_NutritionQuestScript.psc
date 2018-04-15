Scriptname _REAL_NutritionQuestScript extends Quest  
{This quest script is used to manage the hunger mechanic of the _REAL_Nutrition mod.}

GlobalVariable Property _REAL_NutritionVersion Auto
GlobalVariable Property _REAL_NutritionDebugEnabled Auto

Float Property nutritionWarnValue Auto
Float Property nutritionDetrimentValue Auto
Float Property nutritionDetrimentMajorValue  Auto
Float Property nutritionDetrimentSevereValue  Auto
Float Property nutritionLossPerDay  Auto
Float Property nutritionMax  Auto
Float Property minNutritionAfterEating  Auto  

SPELL Property _AbHunger Auto
SPELL Property _AbHungerMajor Auto
SPELL Property _AbHungerSevere Auto

float modVersion ;Last run version of the mod which is checked to restart when an updated version is run
bool debugEnabled
float hunger ;the current hunger state
float lastUpdateTime ;game time of the last update to hunger
float nutrition ;Amount of applied nutrition in days on a scale of 0 to 1 at the time of the last update (when the player eats).


Event OnInit()
	Maintenance()
endEvent


Event OnUpdateGameTime()
	
	; Update nutrition if at least an hour has passed and the player is not sleeping
	float currentGameTime =  Utility.GetCurrentGameTime()
	
	if (lastUpdateTime == 0)
		lastUpdateTime = currentGameTime
	else
		float elapsedTime = currentGameTime - lastUpdateTime
		
		; Only Update if the elapsed time is at least 1 hour in game time
		; Do not update when the player is sleeping. A single update will occur when the player wakes.
		if (elapsedTime * 24 >= 1 && Game.GetPlayer().GetSleepState() == 0)
			float nutritionLoss =  nutritionLossPerDay * elapsedTime
			if (debugEnabled)
				Debug.Notification("Elapsed time " + elapsedTime)
				Debug.Notification("Nutrition loss " + nutritionLoss)
			endIf

			SetNutrition(nutrition - nutritionLoss)

		endIf
	endIf

endEvent


Function Maintenance()

	debugEnabled = _REAL_NutritionDebugEnabled.GetValue() == 1.0
	if (modVersion == _REAL_NutritionVersion.GetValue())
		return
	endIf

	modVersion = _REAL_NutritionVersion.GetValue()
	Debug.Notification("The Belly Rules the Mind")
	
	; Stop updating when the game time changes
	UnregisterForUpdateGameTime()

	; Restart quest in case it has been started from a previous version of the mod
	Reset()	

	lastUpdateTime = Utility.GetCurrentGameTime()
	nutrition = nutritionDetrimentValue
	if (debugEnabled)
		Debug.Notification("Initialized time " + lastUpdateTime)
		Debug.Notification("Initialized nutrition " + nutrition)
	endIf

	; Initialize hunger based on initial nutrition
	UpdateHunger()

	; Register to update every in-game hour
	RegisterForUpdateGameTime(1.0)

endFunction


Function AddNutrition(float aValue)
	if debugEnabled
		Debug.Notification("Added " + aValue + " Nutrition")
	endIf
	
	float newNutrition = nutrition + aValue
	
	if newNutrition >= nutritionMax
		Debug.Notification("You are completely full.")
	elseIf newNutrition < minNutritionAfterEating
		newNutrition = minNutritionAfterEating
	endIf

	SetNutrition(newNutrition)

endFunction


Function SetNutrition(float aValue)

	; Limit value to min and max
	if (aValue < 0)
		aValue = 0
	elseIf (aValue > nutritionMax)
		aValue = nutritionMax
	endIf

	; Set nutrition and keep track of the time that this update occurred
	nutrition = aValue
	lastUpdateTime = Utility.GetCurrentGameTime()
	
	if (debugEnabled)
		Debug.Notification("Updated nutrition is " + nutrition )
	endIf

	; Update hunger status with the current nutrition
	UpdateHunger()

endFunction


Function UpdateHunger()

	if (nutrition <= nutritionDetrimentSevereValue)
		SetHunger(4)
	elseIf (nutrition <= nutritionDetrimentMajorValue)
		SetHunger(3)
	elseIf (nutrition <= nutritionDetrimentValue)
		SetHunger(2)
	elseIf (nutrition <= nutritionWarnValue)
		SetHunger(1)
	else
		SetHunger(0)
	endIf

endFunction


Function SetHunger(int aiValue)

	Bool valueChanged = false
	if (hunger != aiValue)
		hunger = aiValue
		valueChanged = true
	endIf

	Actor Player = Game.GetPlayer()

	Player.RemoveSpell(_AbHunger)
	Player.RemoveSpell(_AbHungerMajor)
	Player.RemoveSpell(_AbHungerSevere)
	
	if (hunger == 0)
		if (valueChanged)
			Debug.Notification("Your hunger is sated.")
		endIf
	elseIf (hunger == 1)
		;Set warning state
		if (valueChanged)
			Debug.Notification("You are somewhat hungry.")
		endIf
	elseIf (hunger == 2)
		Player.AddSpell(_AbHunger, false)
		if (valueChanged)
			Debug.Notification("You are hungry.")
		endIf
	elseif (hunger == 3)
		Player.AddSpell(_AbHungerMajor, false)
		if (valueChanged)
			Debug.Notification("You are very hungry.")
		endIf
	elseif (hunger == 4)
		Player.AddSpell(_AbHungerSevere, false)
		Debug.Notification("You are starving.")
	endIf

endFunction

