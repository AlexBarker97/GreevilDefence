GreevilThink = 1.0

function Spawn( entityKeyValues )
	thisEntity:SetContextThink("GreevilThink", GreevilThink, 0.1)
	thisEntity.Rage = thisEntity:FindAbilityByName("greevil_rage")
	thisEntity.CFear = thisEntity:FindAbilityByName("greevil_crippling_fear")
	thisEntity.DZeal = thisEntity:FindAbilityByName("greevil_demon_zeal")
	thisEntity.Tomb = thisEntity:FindAbilityByName("greevil_tombstone")
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

			if thisEntity.CFear:IsFullyCastable() then
				CastCFear(target)
				GreevilThink = 0.3
				return GreevilThink
			elseif thisEntity.DZeal:IsFullyCastable() then
				CastDZeal(target)
				GreevilThink = 1.0
				return GreevilThink
			end

			if min <= 500 then
				if pctHP < 0.5 and thisEntity.Rage:IsFullyCastable() then
					CastRage(target)
					GreevilThink = 0.3
					return GreevilThink
				elseif thisEntity.Tomb:IsFullyCastable() then
					CastTomb(target)
					GreevilThink = 1.0
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

function CastRage()
	thisEntity:CastAbilityNoTarget(thisEntity.Rage, -1)
end

function CastCFear()
	thisEntity:CastAbilityNoTarget(thisEntity.CFear, -1)
end

function CastDZeal()
	thisEntity:CastAbilityNoTarget(thisEntity.DZeal, -1)
end

function CastTomb(target)
	local target = target
	
	thisEntity:CastAbilityOnPosition(target:GetAbsOrigin(), thisEntity.Tomb, -1)
end