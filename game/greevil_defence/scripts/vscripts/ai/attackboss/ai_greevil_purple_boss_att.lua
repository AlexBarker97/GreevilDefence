GreevilThink = 1.0

function Spawn( entityKeyValues )
	thisEntity:SetContextThink("GreevilThink", GreevilThink, 0.1)
	thisEntity.Diss = thisEntity:FindAbilityByName("greevil_dissimilate")
	thisEntity.MPulse = thisEntity:FindAbilityByName("greevil_midnight_pulse")
	thisEntity.Vac = thisEntity:FindAbilityByName("greevil_vacuum")
	thisEntity.BHole = thisEntity:FindAbilityByName("greevil_black_hole")
end

function GreevilThink()
	local pctHP = thisEntity:GetHealth()/thisEntity:GetMaxHealth()

	if not IsServer() then
		return
	end

	if ( not thisEntity:IsAlive() ) then
		GreevilThink = -1
		return GreevilThink
	end

	if GameRules:IsGamePaused() == true then
		GreevilThink = 0.5
		return GreevilThink
	end

	local team = thisEntity:GetTeam()
	if team == DOTA_TEAM_GOODGUYS then
		units = FindUnitsInLine(DOTA_TEAM_BADGUYS, (Vector(6400, 5760, 256)), (Vector(6400, -3584, 256)), nil, 1400.0, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE)
	elseif team == DOTA_TEAM_BADGUYS then
		units = FindUnitsInLine(DOTA_TEAM_GOODGUYS, (Vector(6400, 5760, 256)), (Vector(6400, -3584, 256)), nil, 1400.0, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE)
	end

	local unitsdist = {}
	if #units ~= nil then
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

			if min <= 500 then
				if pctHP < 0.3 and thisEntity.BHole:IsFullyCastable() then
					CastBHole(target)
					GreevilThink = 5.5
					return GreevilThink
				elseif thisEntity.MPulse:IsFullyCastable() then
					CastMPulse(target)
					GreevilThink = 0.5
					return GreevilThink
				elseif thisEntity.Vac:IsFullyCastable() then
					CastVac(target)
					GreevilThink = 0.6
					return GreevilThink
				elseif thisEntity.Diss:IsFullyCastable() then
					CastDiss(target)
					GreevilThink = 0.6
					return GreevilThink
				end
			end
  			thisEntity:MoveToTargetToAttack(target)
			GreevilThink = 2.0
			return GreevilThink
  		end
	end	
end

----------------- Abilities -----------------

function CastBHole(target)
	local target = target
	
	thisEntity:CastAbilityOnPosition(target:GetAbsOrigin(), thisEntity.BHole, -1)
end

function CastMPulse(target)
	local target = target
	
	thisEntity:CastAbilityOnPosition(target:GetAbsOrigin(), thisEntity.MPulse, -1)
end

function CastVac(target)
	local target = target
	
	thisEntity:CastAbilityOnPosition(target:GetAbsOrigin(), thisEntity.Vac, -1)
end

function CastDiss()
	thisEntity:CastAbilityNoTarget(thisEntity.Diss, -1)
end