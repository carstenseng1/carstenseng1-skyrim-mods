Scriptname _REAL_Water extends activemagiceffect  
{Adds the spell to slow player speed when swimming or wading}

SPELL Property waterSpell  Auto  
{Spell applied when player enters water}

EVENT OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.addSpell(waterSpell)
ENDEVENT
	
Event OnEffectFinish(Actor akTarget, Actor akCaster)
	akTarget.removeSpell(waterSpell)
ENDEVENT