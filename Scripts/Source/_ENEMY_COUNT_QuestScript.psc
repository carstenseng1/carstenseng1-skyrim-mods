Scriptname _ENEMY_COUNT_QuestScript extends Quest  

Bool Property enabled  Auto  
Bool Property debugNotifications  Auto  
Int Property spawnCount  Auto  
Float Property spawnChanceInterior  Auto  
Float Property spawnChanceExterior  Auto  

Event OnInit()
	Debug.Notification("Enemizer")
endEvent