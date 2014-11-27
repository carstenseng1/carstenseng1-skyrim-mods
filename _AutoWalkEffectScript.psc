Scriptname _AutoWalkEffectScript extends activemagiceffect  
{Magic effect script to make the target path to a location}


Event OnEffectStart(Actor akTarget, Actor akCaster)

	if (akTarget == Game.GetPlayer())
		
		;_AutoWalkQuest.BeginAutoWalk(NONE)
		
	else
		
		Debug.Notification("AutoWalk target is not player")
		
	endIf
	
endEvent
Quest Property _AutoWalkQuest  Auto  
