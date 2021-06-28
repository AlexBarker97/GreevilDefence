--AI States:
--IDLE = 0
--AGGRESSIVE = 1
--RETURNING = 2

AI_THINK_INTERVAL = 0.5

function Spawn( entityKeyValues )

	thisEntity.Spear = thisEntity:FindAbilityByName("greevil_spear")
	thisEntity.BTrance = thisEntity:FindAbilityByName("greevil_battle_trance")
	thisEntity.Arena = thisEntity:FindAbilityByName("greevil_arena_of_blood")
	
	thisEntity.state = 0 --Initial state
	
	aggroRange = 1100
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
	
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, false)
	
	if #units > 0 then
		if thisEntity.Arena:IsFullyCastable() and (thisEntity:GetAbsOrigin() - units[1]:GetAbsOrigin()):Length() < 400 then
			thisEntity:Stop()
			CastArena()
			return true
		end	
	end
	
	if thisEntity.Spear:IsFullyCastable() and not thisEntity.Arena:IsFullyCastable() and (thisEntity:GetHealth()/thisEntity:GetMaxHealth()) < 0.3 then
		thisEntity:Stop()
		CastSpear()
		return true
	end
	
	if thisEntity.BTrance:IsFullyCastable() and not thisEntity.Arena:IsFullyCastable() then
		thisEntity:Stop()
		CastBTrance()
		return true
	end
	
	thisEntity:MoveToTargetToAttack(units[1])
end

function ReturningThink()
	if (thisEntity.spawnPos - thisEntity:GetAbsOrigin()):Length() < 50 then
		thisEntity.state = 0
	else
		thisEntity:MoveToPosition(thisEntity.spawnPos)
	end
end

----------------- Abilities -----------------

function CastSpear()
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
			aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
			FIND_ANY_ORDER, false)
	if #units > 0 then
		thisEntity:CastAbilityOnPosition(units[1]:GetAbsOrigin(), thisEntity.Spear, -1)
	end
end

function CastBTrance()
	thisEntity:CastAbilityNoTarget(thisEntity.BTrance, -1)
end

function CastArena()
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, false)
	thisEntity:CastAbilityOnPosition(units[1]:GetAbsOrigin(), thisEntity.Arena, -1)
end