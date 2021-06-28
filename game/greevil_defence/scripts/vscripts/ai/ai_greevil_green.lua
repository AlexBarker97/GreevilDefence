--AI States:
--IDLE = 0
--AGGRESSIVE = 1
--RETURNING = 2

AI_THINK_INTERVAL = 1

function Spawn( entityKeyValues )

	thisEntity.HBoulder = thisEntity:FindAbilityByName("greevil_hurl_boulder")
	
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
	local units = FindUnitsInRadius( thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, false )
	thisEntity.aggroTarget = units[1]
	if #units > 0 then
		thisEntity.state = 1
	end
end

function AggressiveThink()

	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST, false)

	thisEntity:MoveToTargetToAttack(units[1])

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

	if thisEntity.HBoulder:IsFullyCastable() and (thisEntity:GetHealth()/thisEntity:GetMaxHealth()) < 0.8 then
		CastHBoulder()
		return true
	end

end

function ReturningThink()
	if (thisEntity.spawnPos - thisEntity:GetAbsOrigin()):Length() < 20 then
		thisEntity.state = 0
	else
		thisEntity:MoveToPosition(thisEntity.spawnPos)
	end
end

function CastHBoulder()
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, false)
	
	thisEntity:CastAbilityOnTarget(units[1], thisEntity.HBoulder, -1)
end