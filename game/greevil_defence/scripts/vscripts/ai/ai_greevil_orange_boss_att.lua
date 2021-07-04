AI_THINK_INTERVAL = 0.8

aggroRange = 1000

function Spawn( entityKeyValues )
	thisEntity:SetContextThink("GreevilThink", GreevilThink, AI_THINK_INTERVAL)

	thisEntity.IBlade = thisEntity:FindAbilityByName("greevil_infernal_blade")
	thisEntity.SNova = thisEntity:FindAbilityByName("greevil_supernova")
end
--------------------------------------------------------------------------------
function GreevilThink()
	if not IsServer() then
		return
	end

	if ( not thisEntity:IsAlive() ) then
		return -1
	end

	if GameRules:IsGamePaused() == true then
		return 0.5
	end

	local team = thisEntity:GetTeam()
	
	if team == DOTA_TEAM_GOODGUYS then
		units = FindUnitsInLine(DOTA_TEAM_GOODGUYS, (Vector(6400, 5760, 256)), (Vector(6400, -3584, 256)), nil, 1400.0, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE)
	elseif team == DOTA_TEAM_BADGUYS then
		units = FindUnitsInLine(DOTA_TEAM_BADGUYS, (Vector(6400, 5760, 256)), (Vector(6400, -3584, 256)), nil, 1400.0, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE)
	end
	
	local unitsClose = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, false)

	if #unitsClose == 0 then
	  	if #units >= 1 then
			target = units[1]
  			thisEntity:MoveToPositionAggressive(target:GetOrigin())
  		end
		return true
	else 
		if thisEntity.IBlade:IsFullyCastable() then
			CastIBlade()
			return AI_THINK_INTERVAL
		end
		local pctHP = thisEntity:GetHealth()/thisEntity:GetMaxHealth()
		if pctHP < 0.3 and thisEntity.SNova:IsFullyCastable() then
			CastSNova()
			return AI_THINK_INTERVAL
		end
		if #units >= 1 then
			AI_THINK_INTERVAL = 2.5
			target = units[1]
  			thisEntity:MoveToPositionAggressive(target:GetOrigin())
			return AI_THINK_INTERVAL
  		end
	end	
end

----------------- Abilities -----------------

function CastIBlade()
	AI_THINK_INTERVAL = 0.8
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST, false)
	
	thisEntity:CastAbilityOnTarget(units[1], thisEntity.IBlade, -1)
end

function CastSNova()
	AI_THINK_INTERVAL = 6.5
	thisEntity:CastAbilityNoTarget(thisEntity.SNova, -1)
end