--AI States:
--IDLE = 0
--AGGRESSIVE = 1
--RETURNING = 2

AI_THINK_INTERVAL = 0.8

function Spawn( entityKeyValues )

	thisEntity.Rage = thisEntity:FindAbilityByName("greevil_rage")
	thisEntity.TStone = thisEntity:FindAbilityByName("greevil_tombstone")
	thisEntity.Exorcism = thisEntity:FindAbilityByName("greevil_exorcism")
	thisEntity.Detonate = thisEntity:FindAbilityByName("detonate")
	
	thisEntity.state = 0 --Initial state
	
	aggroRange = 2800
	leashRange = 2800
	
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
	local pctHP = thisEntity:GetHealth()/thisEntity:GetMaxHealth()
	
	if #units > 0 then
		
		if pctHP < 0.5 and thisEntity.Rage:IsFullyCastable() then
			CastRage()
			return true
		end

		if thisEntity.Exorcism:IsFullyCastable() then
			CastExorcism()
			return true
		end
	
		if thisEntity.Exorcism:IsFullyCastable() then
			CastExorcism()
			return true
		end
	
		if thisEntity.Detonate:IsFullyCastable() then
			CastDetonate()
			return true
		end

		thisEntity:MoveToTargetToAttack(units[1])
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

function CastRage()
	thisEntity:CastAbilityNoTarget(thisEntity.Rage, -1)
end

function CastExorcism()
	thisEntity:CastAbilityNoTarget(thisEntity.Exorcism, -1)
end

function CastDetonate()
	thisEntity:CastAbilityNoTarget(thisEntity.Detonate, -1)
end