Scriptname _REAL_EnableStarvationScript extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	_REAL_NutritionQuest.SetStarvationEnabled(pEnableStarvation)

	if (pEnableStarvation)
		Game.GetPlayer().AddSpell(_REAL_DisableStarvationSpell, false)
		Game.GetPlayer().EquipSpell(_REAL_DisableStarvationSpell, 2)
		Game.GetPlayer().RemoveSpell(_REAL_EnableStarvationSpell)
	else
		Game.GetPlayer().AddSpell(_REAL_EnableStarvationSpell, false)
		Game.GetPlayer().EquipSpell(_REAL_EnableStarvationSpell, 2)
		Game.GetPlayer().RemoveSpell(_REAL_DisableStarvationSpell)
	endIf
endEvent

_REAL_NutritionQuestScript Property _REAL_NutritionQuest  Auto  
SPELL Property _REAL_EnableStarvationSpell  Auto  
Bool Property pEnableStarvation  Auto  

SPELL Property _REAL_DisableStarvationSpell  Auto  
