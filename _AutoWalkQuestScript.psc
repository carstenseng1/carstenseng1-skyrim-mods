Scriptname _AutoWalkQuestScript extends Quest  
{Quest script to manage auto walk}


SPELL Property _AutoWalkPower  Auto  

Bool Property IsAutoWalkOn Auto

ObjectReference Property Destination Auto

Actor Property CameraTarget Auto


; This is within the "empty" state
Event OnInit() ; This event will run once, when the script is initialized

	;Debug.Notification("AutoWalkQuest init")
	Game.GetPlayer().AddSpell(_AutoWalkPower, false)

EndEvent


Event OnUpdate()
	
	if (IsAutoWalkOn)
		if (CanAutoWalk())
			; All is still good
		else
			; Check failed
			EndAutoWalk()
		endIf
	else
		; Should not get here, but unregister to be safe
		UnregisterForUpdate()
	endIf
	
endEvent


Bool Function CanAutoWalk()
	
	Actor Player = Game.GetPlayer()
	
	if (Player.IsInCombat())
	;
		Debug.Notification("You cannot journey while in combat.")
		return false
	endIf
	
	; Ensure the player has control
	if (!Player.GetPlayerControls())
		return false
	endIf
	
	return true
	
endFunction


Bool Function CanStartAutoWalk()
	
	if (IsAutoWalkOn)
		return false
	endIf
	
	if (!Destination)
	;
		Debug.Notification("You must set a destination to journey.")
		return false
	endIf
	
	if (!CameraTarget)
	;
		Debug.Notification("No camera target set")
		return false
	endIf
	
	; Cancel auto walk if any control is disabled
	if (!Game.IsMovementControlsEnabled())
		return false
	endIf
	if (!Game.IsFightingControlsEnabled())
		return false
	endIf
	if (!Game.IsCamSwitchControlsEnabled())
		return false
	endIf
	if (!Game.IsLookingControlsEnabled())
		return false
	endIf
	if (!Game.IsSneakingControlsEnabled())
		return false
	endIf
	if (!Game.IsMenuControlsEnabled())
		return false
	endIf
	if (!Game.IsActivateControlsEnabled())
		return false
	endIf
	if (!Game.IsJournalControlsEnabled())
		return false
	endIf
	if (!Game.IsFastTravelControlsEnabled())
		return false
	endIf
	
	; All checks passed
	return true
	
endFunction

Function BeginAutoWalk(ObjectReference akDestination)
	
	Destination = Game.GetPlayersLastRiddenHorse()
	CameraTarget = Game.GetPlayersLastRiddenHorse()
	
	if (!CanStartAutoWalk() || !CanAutoWalk())
		return
	endIf
	
	; Convenience reference to player
	Actor Player = Game.GetPlayer()
	
	; Set the camera target to another actor set to follow player to correct camera control issue
	Game.SetCameraTarget(CameraTarget)
	Game.ForceThirdPerson()
	
	; Disable all but looking
	;(abMovement, abFighting, abCamSwitch, abLooking, abSneaking, abMenu, abActivate, abJournalTabs)
	Game.DisablePlayerControls(true, true, false, false, true, false, false, false)
	
	; Set player not player-controlled so path can be given
	Player.SetPlayerControls(false)
	
	; Find a path to the destination and begin walking
	; Pathing will suspend this script, so set up everything before beginning
	IsAutoWalkOn = true
	
	; Register for update to check conditions while auto walk is running
	RegisterForUpdate(1)
	
	if (Player.PathToReference(Destination, 1.0))
	;
		Debug.Notification("You reached your destination.")
	else
	;
		Debug.Notification("You cannot journey to the desired destination.")
	endIf
	
	; Call cleanup function
	DidEndAutoWalk()
	
endFunction


Function EndAutoWalk()
	
	Actor Player = Game.GetPlayer()
	
	; Path to self to end pathing
	Player.PathToReference(Player, 1.0)
	
	; Call cleanup function
	DidEndAutoWalk()
	
endFunction


Function DidEndAutoWalk()
	
	IsAutoWalkOn = false
	
	Actor Player = Game.GetPlayer()
	
	; Re-enable the player controls
	Game.EnablePlayerControls()
	
	; Set the Player back to being player-controlled
	Player.SetPlayerControls(true)
	
	; Stop receiving update
	UnregisterForUpdate()
	
endFunction


Function ToggleAutoWalk()
	
	if (IsAutoWalkOn)
		EndAutoWalk()
	else
		BeginAutoWalk(NONE)
	endIf
endFunction