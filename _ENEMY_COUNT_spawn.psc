Scriptname _ENEMY_COUNT_spawn extends Actor  
{Spawn an actor on load}

ActorBase Property spawnedActorBase  Auto  

Int Property count  Auto  

Float Property chance Auto

ActorBase Property requiredActorBase  Auto 

Event OnLoad()

	bool doSpawn = true
	if (self.isDead())
		doSpawn = false
	endif

	if (requiredActorBase != NONE && self.GetActorBase() != requiredActorBase)
		doSpawn = false
	else
		;Debug.Notification("ActorBase does not match requirement")
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
				;Debug.Notification("Spawned Enemy chance:"+chance+" mult:"+chanceMult+" random:"+ random)
			endif
		endwhile
	endif


  
endevent
