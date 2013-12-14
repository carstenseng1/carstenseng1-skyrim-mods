Scriptname _REAL_NutritionMigration1QuestScript extends Quest  
{Restarts the main quest}

Quest Property _REAL_NutritionQuest  Auto  

Event OnInit()

Debug.Notification("Migration 1 quest init")
_REAL_NutritionQuest.reset()

endEvent