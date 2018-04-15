Scriptname _REAL_NutritionAddScript extends ReferenceAlias  
{Reference alias script to add nutrition when the player consumes an item of the given list.}

FormList Property _FoodVeryLargeList Auto
FormList Property _FoodLargeList Auto
FormList Property _FoodList Auto
FormList Property _DrinkList Auto

Float Property FoodVeryLargeValue = 1.0 Auto
Float Property FoodLargeValue = 0.5 Auto
Float Property FoodValue = 0.25 Auto
Float Property DrinkValue = 0.1 Auto

_REAL_NutritionQuestScript Property _REAL_NutritionQuest Auto

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	if _FoodVeryLargeList.Find(akBaseObject) >= 0
		_REAL_NutritionQuest.AddNutrition(FoodVeryLargeValue)
	elseIf _FoodLargeList.Find(akBaseObject) >= 0
		_REAL_NutritionQuest.AddNutrition(FoodLargeValue)
	elseIf _FoodList.Find(akBaseObject) >= 0
		_REAL_NutritionQuest.AddNutrition(FoodValue)
	elseIf _DrinkList.Find(akBaseObject) >= 0
		_REAL_NutritionQuest.AddNutrition(DrinkValue)
	endIf
endEvent
