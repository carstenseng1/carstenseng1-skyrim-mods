Scriptname _REAL_AddNutritionEffectScript extends activemagiceffect  
{This script calls the nutrition quest scripts function to add to the nutrition value.}

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;Debug.Notification("Add Nutrition effect started on " + akTarget)
	if (akTarget == Game.GetPlayer())
		_REAL_NutritionQuest.AddNutrition(NutritionValue)
	endIf
endEvent

;PROPERTIES
float Property NutritionValue Auto
{Value used to represent current nutrition level}

_REAL_NutritionQuestScript Property _REAL_NutritionQuest  Auto  
{The quest used to manage nutrition logic.}
