Scriptname _REAL_NutritionPlayerScript extends ReferenceAlias  

GlobalVariable Property _REAL_NutritionDebugEnabled Auto
_REAL_NutritionQuestScript Property _REAL_NutritionQuest Auto

Event OnInit()
	if _REAL_NutritionDebugEnabled.GetValue() == 1
		Debug.Notification("REAL Nu: Player Init")
	endIf
	_REAL_NutritionQuest.Maintenance()
endEvent

Event OnPlayerLoadGame()
	if _REAL_NutritionDebugEnabled.GetValue() == 1
		Debug.Notification("REAL Nu: Player Load Game")
	endIf
	_REAL_NutritionQuest.Maintenance()
endEvent
