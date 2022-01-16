--AI States:
--IDLE = 0
--AGGRESSIVE = 1
--RETURNING = 2

AI_THINK_INTERVAL = 0.1

function Spawn( entityKeyValues )

	thisEntity.Diss = thisEntity:FindAbilityByName("greevil_dissimilate")
	thisEntity.MPulse = thisEntity:FindAbilityByName("greevil_midnight_pulse")
	thisEntity.Vac = thisEntity:FindAbilityByName("greevil_vacuum")
	thisEntity.SScreen = thisEntity:FindAbilityByName("greevil_smoke_screen")
	
	thisEntity.state = 0 --Initial state
	
	aggroRange = 1000
	leashRange = 2000
	
	thisEntity:SetContextThink("GreevilThink", GreevilThink, AI_THINK_INTERVAL)
end

function GreevilThink()
	if not thisEntity:IsAlive() then
		return nil
	end

	if thisEntity.state == 0 then
		IdleThink()
	elseif thisEntity.state == 1 then
		AggressiveThink()
	elseif thisEntity.state == 2 then
		ReturningThink()
	end
	
	return AI_THINK_INTERVAL
end

function IdleThink()
	local units = FindUnitsInRadius( thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, false )
	thisEntity.aggroTarget = units[1]
	if #units > 0 then
		thisEntity.state = 1
	end
end

function AggressiveThink()
	AI_THINK_INTERVAL = 0.1

	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST, false)

	--If target leaves leash range
	if ( thisEntity.spawnPos - thisEntity:GetAbsOrigin() ):Length() > leashRange then
		thisEntity:MoveToPosition( thisEntity.spawnPos )
		thisEntity.state = 2
		return true
	end

	--If target dies
	if not thisEntity.aggroTarget:IsAlive() then
		thisEntity:MoveToPosition( thisEntity.spawnPos )
		thisEntity.state = 2
		return true
	end

	--------------------------------------------------------------------------------------
	--					Ability Logic													--
	--------------------------------------------------------------------------------------
	
	if #units > 0 then
		if thisEntity.MPulse:IsFullyCastable() then
			CastMPulse()
			return true
		end
		
		if thisEntity.Vac:IsFullyCastable() then
			CastVac()
			return true
		end	
		
		if thisEntity.Diss:IsFullyCastable() then
			CastDiss()
			return true
		end
		
		if thisEntity.SScreen:IsFullyCastable() then
			CastSScreen()
			return true
		end
	end

	for i=1,#units do
		if not units[i]:IsInvisible() then
			thisEntity:MoveToTargetToAttack(units[1])
			return
		end
	end
end

function ReturningThink()
	if (thisEntity.spawnPos - thisEntity:GetAbsOrigin()):Length() < 50 then
		thisEntity.state = 0
	else
		thisEntity:MoveToPosition(thisEntity.spawnPos)
	end
end

----------------- Abilities -----------------

function CastMPulse()
	AI_THINK_INTERVAL = 0.3
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST, false)

	for i=1,#units do
		if not units[i]:IsInvisible() then
			thisEntity:CastAbilityOnPosition(units[1]:GetAbsOrigin(), thisEntity.MPulse, -1)
			return
		end
	end
end

function CastDiss()
	AI_THINK_INTERVAL = 0.4
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST, false)
	
	for i=1,#units do
		if not units[i]:IsInvisible() then
			thisEntity:CastAbilityOnPosition(units[1]:GetAbsOrigin(), thisEntity.Diss, -1)
			return
		end
	end
end

function CastVac()
	AI_THINK_INTERVAL = 0.7
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST, false)
	
	for i=1,#units do
		if not units[i]:IsInvisible() then
			thisEntity:CastAbilityOnPosition((thisEntity:GetAbsOrigin()+thisEntity:GetAbsOrigin()+units[1]:GetAbsOrigin())/3, thisEntity.Vac, -1)
			return
		end
	end
end

function CastSScreen()
	AI_THINK_INTERVAL = 0.4
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST, false)
	
	for i=1,#units do
		if not units[i]:IsInvisible() then
			thisEntity:CastAbilityOnPosition(thisEntity:GetAbsOrigin(), thisEntity.SScreen, -1)
			return
		end
	end
end