Scriptname _REAL_NutritionQuestScript extends Quest  
{This quest script is used to manage the hunger mechanic of the _REAL_Nutrition mod.}


float hunger ;the current hunger state
float lastUpdateTime ;game time of the last update to hunger
float lastUpdateNutrition ;Amount of applied nutrition in days on a scale of 0 to 1 at the time of the last update (when the player eats).
Actor Player

Event OnInit()

	Player = Game.GetPlayer()
	hunger = -1
	
	Debug.Notification("The Belly Rules the Mind")
	SetObjectiveDisplayed(0, false)

	float currentGameTime =  Utility.GetCurrentGameTime()
	lastUpdateTime = currentGameTime
	lastUpdateNutrition = nutritionHungerValue
	;Debug.Notification("Initialized time " + lastUpdateTime)
	;Debug.Notification("Initialized nutrition " + lastUpdateNutrition)
	
	RegisterForUpdate(5) ; Update every 10 seconds to reduce nutrition  value.
	
	Player.AddSpell(_REAL_EnableStarvationSpell, false)
endEvent


Event OnUpdate()

	; Update nutrition if at least an hour has passed and the player is not sleeping
	float currentGameTime =  Utility.GetCurrentGameTime()
	
	if (lastUpdateTime == 0)
		lastUpdateTime = currentGameTime
	endIf
	
	float elapsedTime = currentGameTime - lastUpdateTime
	
	if (elapsedTime * 24 >= 1 && Player.GetSleepState() == 0)
		float nutritionLoss =  nutritionLossPerDay * elapsedTime
		float currentNutrition = lastUpdateNutrition - nutritionLoss
		;Debug.Notification("Elapsed time " + elapsedTime)
		;Debug.Notification("Nutrition loss " + nutritionLoss)
		UpdateWithCurrentNutrition(currentNutrition)
	endIf

endEvent

Function AddNutrition(float afNutrition)

	;Debug.Notification("Added "+afNutrition+" Nutrition")
	float currentNutrition = lastUpdateNutrition - nutritionLossPerDay * (Utility.GetCurrentGameTime() - lastUpdateTime)
	currentNutrition += afNutrition

	if (currentNutrition < minNutritionAfterEating)
		currentNutrition = minNutritionAfterEating
	endIf

	if (currentNutrition >= nutritionMax)
		;The player has over the maximum nutrition value
		Debug.Notification("You are completely full.")
		currentNutrition = nutritionMax
	endIf

	UpdateWithCurrentNutrition(currentNutrition)

endFunction


Function UpdateWithCurrentNutrition(float aCurrentNutrition)

	;Debug.Notification("Current nutrition is " + aCurrentNutrition)
	if (aCurrentNutrition <= nutritionDeathValue)
		;Debug.Notification("Current nutrition is at or below the minimum: " + nutritionDeathValue)
		SetHunger(4)
	elseIf (aCurrentNutrition <= nutritionStarvationValue)
		SetHunger(3)
	elseIf (aCurrentNutrition <= nutritionHungerValue)
		SetHunger(2)
	elseIf (aCurrentNutrition <= nutritionWarnValue)
		SetHunger(1)
	else
		SetHunger(0)
	endIf
	
	lastUpdateTime = Utility.GetCurrentGameTime()
	lastUpdateNutrition = aCurrentNutrition

endFunction


Function SetHunger(int aiValue)
	
	;Limit hunger value
	if (hunger > 2 && isStarvationEnabled == false)
		aiValue = 2
	endIf

	if (hunger != aiValue)
		hunger = aiValue
		if (hunger == 0)
			Player.RemoveSpell(_AbNutritionDetriment)
			Player.RemoveSpell(_AbNutritionDetrimentMajor)
			Player.RemoveSpell(_AbNutritionDetrimentSevere)
			Debug.Notification("Your hunger is sated.")
		elseIf (hunger == 1)
			;Set warning state
			Player.RemoveSpell(_AbNutritionDetriment)
			Player.RemoveSpell(_AbNutritionDetrimentMajor)
			Player.RemoveSpell(_AbNutritionDetrimentSevere)
			Debug.Notification("You are somewhat hungry.")
		elseIf (hunger == 2)
			Player.RemoveSpell(_AbNutritionDetrimentMajor)
			Player.RemoveSpell(_AbNutritionDetrimentSevere)
			Player.AddSpell(_AbNutritionDetriment, false)
			Debug.Notification("You are hungry and need to eat.")
		elseif (hunger == 3)
			Player.RemoveSpell(_AbNutritionDetriment)
			Player.RemoveSpell(_AbNutritionDetrimentSevere)
			Player.AddSpell(_AbNutritionDetrimentMajor, false)
			Debug.Notification("You are weak with starvation.")
		elseif (hunger == 4)
			Player.RemoveSpell(_AbNutritionDetriment)
			Player.RemoveSpell(_AbNutritionDetrimentMajor)
			Player.AddSpell(_AbNutritionDetrimentSevere, false)
			Debug.Notification("You are dying from starvation.")
		endIf
	endIf
endFunction

Function SetStarvationEnabled(bool enabled)
	isStarvationEnabled = enabled
	if (isStarvationEnabled)
		Debug.Notification("Starvation is enabled.")
	else
		Debug.Notification("Starvation is disabled.")
	endIf
endFunction

;PROPERTIES
SPELL Property _AbNutritionDetriment Auto
SPELL Property _AbNutritionDetrimentMajor  Auto
SPELL Property _AbNutritionDetrimentSevere  Auto
SPELL Property _REAL_EnableStarvationSpell  Auto
Float Property nutritionInitValue Auto
Float Property nutritionWarnValue Auto
Float Property nutritionHungerValue Auto
Float Property nutritionStarvationValue  Auto
Float Property nutritionDeathValue  Auto
Float Property nutritionLossPerDay  Auto
Float Property nutritionMax  Auto
Bool Property isStarvationEnabled = False Auto  
Float Property minNutritionAfterEating  Auto   
