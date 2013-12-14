Scriptname _REAL_NavigationEffectScript extends ActiveMagicEffect  
{Effect script used to update navigation properties.}

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Debug.Trace("Magic effect was started on " + akTarget)
	if (akTarget == Game.GetPlayer())
		RegisterForUpdate(0)
	endif
endEvent

Event OnUpdate()
	Game.EnableFastTravel(false)
endEvent