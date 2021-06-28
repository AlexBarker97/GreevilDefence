--AI States:
--IDLE = 0
--AGGRESSIVE = 1
--RETURNING = 2

AI_THINK_INTERVAL = 0.1

function Spawn( entityKeyValues )

	thisEntity.BFire = thisEntity:FindAbilityByName("greevil_breathe_fire")
	thisEntity.LSA = thisEntity:FindAbilityByName("greevil_light_strike_array")
	thisEntity.IBlade = thisEntity:FindAbilityByName("greevil_infernal_blade")
	thisEntity.SNova = thisEntity:FindAbilityByName("greevil_supernova")
	
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
		if (thisEntity:GetHealth()/thisEntity:GetMaxHealth()) < 0.30 and thisEntity.SNova:IsFullyCastable() == true then
			CastSNova()
			return true
		else
		
			if thisEntity.LSA:IsFullyCastable() then
				CastLSA()
				return true
			end
			
			if thisEntity.BFire:IsFullyCastable() then
				CastBFire()
				return true
			end
			
			if thisEntity.IBlade:IsFullyCastable() then
				CastIBlade()
				return true
			end
			
		end
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

function CastLSA()
	AI_THINK_INTERVAL = 0.55
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, false)
	
	thisEntity:CastAbilityOnPosition(units[1]:GetAbsOrigin(), thisEntity.LSA, -1)
end

function CastBFire()
	AI_THINK_INTERVAL = 0.35
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, false)
	
	thisEntity:CastAbilityOnPosition(units[1]:GetAbsOrigin(), thisEntity.BFire, -1)
end

function CastIBlade()
	AI_THINK_INTERVAL = 1.0
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, false)
	
	thisEntity:CastAbilityOnTarget(units[1], thisEntity.IBlade, -1)
end

function CastSNova()
	AI_THINK_INTERVAL = 6.5
	thisEntity:CastAbilityNoTarget(thisEntity.SNova, -1)
end