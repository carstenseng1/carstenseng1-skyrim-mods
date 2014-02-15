Scriptname _ENEMY_COUNT_spawn extends Actor  
{Spawn an actor on load}

ActorBase Property spawnedActorBase  Auto  
Int Property count  Auto  
Float Property chance Auto
ActorBase Property requiredActorBase  Auto 

Event OnLoad()
	if (true)
		Spawn()
	endIf
endevent

Function Spawn()
	bool doSpawn = true
	if (self.isDead())
		doSpawn = false
	endif

	if (doSpawn)
		if (requiredActorBase == NONE || self.GetActorBase() == requiredActorBase)
			
		else
			doSpawn = false
			Notification("Did not spawn. Required ActorBase does not match.")
		endif
	endif
	
	float chanceMult = 1.0
	if (self.isInInterior())
		chanceMult *= 2
	endif
	
	if (doSpawn)
		while count
			count -= 1
			float random = Utility.RandomFloat()
			if (chance * chanceMult >= random)
				self.PlaceActorAtMe(spawnedActorBase)
				Notification("Spawned enemy. chance:"+chance+" mult:"+chanceMult+" random:"+random)
			endif
		endwhile
	endif
endFunction

Function Notification(string aNotification)
	if (false)
		Debug.Notification(aNotification)
	endIf
endFunction
