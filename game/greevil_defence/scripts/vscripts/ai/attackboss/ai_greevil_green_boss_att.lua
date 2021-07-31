AI_THINK_INTERVAL = 0.8

aggroRange = 1000

function Spawn( entityKeyValues )
	thisEntity:SetContextThink("GreevilThink", GreevilThink, AI_THINK_INTERVAL)

	thisEntity.HBoulder = thisEntity:FindAbilityByName("greevil_hurl_boulder")
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
		units = FindUnitsInLine(DOTA_TEAM_BADGUYS, (Vector(6400, 5760, 256)), (Vector(6400, -3584, 256)), nil, 1400.0, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE)
	elseif team == DOTA_TEAM_BADGUYS then
		units = FindUnitsInLine(DOTA_TEAM_GOODGUYS, (Vector(6400, 5760, 256)), (Vector(6400, -3584, 256)), nil, 1400.0, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE)
	end
	local unitsdist = {}
	
  	if units ~= nil then
  		if #units >= 1 then
			for i=1,#units do
				table.insert(unitsdist, (units[i]:GetAbsOrigin() - thisEntity:GetAbsOrigin()):Length())
			end
			local key, min = 1, unitsdist[1]
			for k, v in ipairs(unitsdist) do
				if unitsdist[k] < min then
					key, min = k, v
				end
			end
			target = units[key]
  			thisEntity:MoveToTargetToAttack(target)
  		end
		return true
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
		if thisEntity.HBoulder:IsFullyCastable() then
			CastHBoulder()
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

function CastHBoulder()
	AI_THINK_INTERVAL = 0.6
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		400, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, false)
	
	thisEntity:CastAbilityOnTarget(units[1], thisEntity.HBoulder, -1)
end