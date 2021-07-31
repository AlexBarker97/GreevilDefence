--AI States:
--IDLE = 0
--AGGRESSIVE = 1
--RETURNING = 2

AI_THINK_INTERVAL = 0.1

function Spawn( entityKeyValues )

	thisEntity.CFrost = thisEntity:FindAbilityByName("lich_chain_frost_lua")
	thisEntity.CNova = thisEntity:FindAbilityByName("greevil_crystal_nova")
	thisEntity.CFeet = thisEntity:FindAbilityByName("greevil_cold_feet")
	thisEntity.LIce = thisEntity:FindAbilityByName("greevil_liquid_ice")
	
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
	
	if thisEntity.CFrost:IsFullyCastable() then
		CastCFrost()
		return AI_THINK_INTERVAL
	end
			
	if thisEntity.CNova:IsFullyCastable() then
		CastCNova()
		return AI_THINK_INTERVAL
	end
			
	if thisEntity.CFeet:IsFullyCastable() then
		CastCFeet()
		return AI_THINK_INTERVAL
	end

	if thisEntity.LIce:IsFullyCastable() then
		CastLIce()
		return AI_THINK_INTERVAL
	end
	
	--thisEntity:MoveToTargetToAttack(units[1])
end

function ReturningThink()
	if (thisEntity.spawnPos - thisEntity:GetAbsOrigin()):Length() < 50 then
		thisEntity.state = 0
	else
		thisEntity:MoveToPosition(thisEntity.spawnPos)
	end
end

----------------- Abilities -----------------

function CastLIce()
	AI_THINK_INTERVAL = 0.9
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, false)
	
	thisEntity:CastAbilityOnTarget(units[1], thisEntity.LIce, -1)
end

function CastCFeet()
	AI_THINK_INTERVAL = 0.2
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, false)
	
	thisEntity:CastAbilityOnTarget(units[1], thisEntity.CFeet, -1)
end

function CastCFrost()
	AI_THINK_INTERVAL = 1.0
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, false)
	
	thisEntity:CastAbilityOnTarget(units[1], thisEntity.CFrost, -1)
end

function CastCNova()
	AI_THINK_INTERVAL = 0.05
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, false)
	
	thisEntity:CastAbilityOnPosition(thisEntity:GetAbsOrigin(), thisEntity.CNova, -1)
end