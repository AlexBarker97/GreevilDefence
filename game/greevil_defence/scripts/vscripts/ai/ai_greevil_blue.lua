--AI States:
--IDLE = 0
--AGGRESSIVE = 1
--RETURNING = 2

AI_THINK_INTERVAL = 0.5

function Spawn( entityKeyValues )

	--thisEntity.abilityname = thisEntity:FindAbilityByName("abilityname")
	
	thisEntity.state = 0 --Initial state

	aggroRange = 1200
	leashRange = 1600
	
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
	thisEntity.prevstate = thisEntity.state

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
	
	if thisEntity.state ~= thisEntity.prevstate then
		thisEntity.prevstate = thisEntity.state
		print("AttackMove")
		thisEntity:MoveToTargetToAttack(units[1])
		return true
	end
		
	--if thisEntity.sgaze:IsFullyCastable() then
	--	CastSGaze()
	--	return true
	--end
end

function ReturningThink()
	thisEntity.prevstate = thisEntity.state
	
	if (thisEntity.spawnPos - thisEntity:GetAbsOrigin()):Length() < 20 then
		thisEntity.state = 0
	end
end

----------------- Abilities -----------------

--function CastSGaze()
--	thisEntity:CastAbilityNoTarget(thisEntity.sgaze, -1)
--	print("stone gaze")
--end