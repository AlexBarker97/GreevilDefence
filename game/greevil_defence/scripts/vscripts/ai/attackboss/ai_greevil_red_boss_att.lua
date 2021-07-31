AI_THINK_INTERVAL = 1

function Spawn( entityKeyValues )
	thisEntity:SetContextThink("GreevilThink", GreevilThink, AI_THINK_INTERVAL)
	thisEntity.BTrance = thisEntity:FindAbilityByName("greevil_red_boss_battle_trance")
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
  	end

	local pctHP = thisEntity:GetHealth()/thisEntity:GetMaxHealth()
	if pctHP < 0.3 and thisEntity.BTrance:IsFullyCastable() then
		CastBTrance()
	end
	
	if thisEntity:GetAggroTarget() then
		return 2.0
	end
	
	return 0.5
end

----------------- Abilities -----------------

function CastBTrance()
	thisEntity:CastAbilityNoTarget(thisEntity.BTrance, -1)
end