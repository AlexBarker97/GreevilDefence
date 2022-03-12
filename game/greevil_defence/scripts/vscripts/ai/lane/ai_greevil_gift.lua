AI_THINK_INTERVAL = 0.45

function Spawn( entityKeyValues )
	thisEntity:SetContextThink("GreevilThink", GreevilThink, 0.1)
	thisEntity.Ice = thisEntity:FindAbilityByName("greevil_ice_wall_ad")
	thisEntity.state = -1
end

function GreevilThink()
	if not IsServer() then
		return
	end

	if ( not thisEntity:IsAlive() ) then
		AI_THINK_INTERVAL = -1
		return AI_THINK_INTERVAL
	end

	if GameRules:IsGamePaused() == true then
		AI_THINK_INTERVAL = 0.5
		return AI_THINK_INTERVAL
	end
	if thisEntity.state == -1 then
		StateN1()
	elseif thisEntity.state == 0 then
		State0()
	elseif thisEntity.state == 1 then
		State1()
	elseif thisEntity.state == 2 then
		State2()
	end
	return AI_THINK_INTERVAL
end

function StateN1()
	if thisEntity:GetAbsOrigin()[2] > 5900 then
		local team = thisEntity:GetTeam()
		if team == DOTA_TEAM_GOODGUYS then
			thisEntity:MoveToPosition(Vector(-6400, -3000, 256))
		elseif team == DOTA_TEAM_BADGUYS then
			thisEntity:MoveToPosition(Vector(6400, -3000, 256))
		end
	else
		thisEntity.state = 0
	end
	return true
end

function State0()
	if thisEntity:GetAbsOrigin()[2] > -2500 then
		local team = thisEntity:GetTeam()
		if team == DOTA_TEAM_GOODGUYS then
			thisEntity:MoveToPosition(Vector(-6400, -3000, 256))
		elseif team == DOTA_TEAM_BADGUYS then
			thisEntity:MoveToPosition(Vector(6400, -3000, 256))
		end
		thisEntity:CastAbilityNoTarget(thisEntity.Ice, -1)
	else
		thisEntity.state = 1
	end
	return true
end

function State1()
	if thisEntity:GetAbsOrigin()[2] < 3900 then
		local team = thisEntity:GetTeam()
		if team == DOTA_TEAM_GOODGUYS then
			thisEntity:MoveToPosition(Vector(-6400, 4000, 256))
		elseif team == DOTA_TEAM_BADGUYS then
			thisEntity:MoveToPosition(Vector(6400, 4000, 256))
		end
	else
		thisEntity.state = 2
	end
	return true
end

function State2()
	if thisEntity:GetAbsOrigin()[2] > -2800 then
		local team = thisEntity:GetTeam()
		if team == DOTA_TEAM_GOODGUYS then
			thisEntity:MoveToPosition(Vector(-6400, -3000, 256))
		elseif team == DOTA_TEAM_BADGUYS then
			thisEntity:MoveToPosition(Vector(6400, -3000, 256))
		end
	else
		thisEntity.state = 1
	end
	return true
end