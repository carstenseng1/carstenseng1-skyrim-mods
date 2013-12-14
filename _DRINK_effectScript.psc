Scriptname _DRINK_effectScript extends activemagiceffect  
{Adds scripted functionality to the alcohol magic effect.}

Actor target

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Debug.Notification("Magic effect was started on " + akTarget)
	
	target = akTarget
	
	if (akTarget.GetSitState() == 0)
		akTarget.PlayIdle(pIdle)
	elseIf (akTarget.GetSitState() == 3)
		;akTarget.PlayIdle()
	endIf
	
	RegisterForUpdate(pUpdateTime)
	
endEvent

Event OnUpdate()
	;Debug.Notification("Starve effect update")
	target.PlayIdle(pIdleEnd)
	UnregisterForUpdate()
endEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	;Debug.Notification("Magic effect was ended on " + akTarget)
endEvent


Idle Property pIdle  Auto  

Idle Property IdleDrink  Auto  

Idle Property IdleDrunkStart  Auto  

Idle Property IdleDrunkStop  Auto  

Idle Property pIdleEnd  Auto  

Int Property pUpdateTime  Auto  
