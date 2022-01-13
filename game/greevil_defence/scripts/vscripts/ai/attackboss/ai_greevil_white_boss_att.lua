GreevilThink = 1.0

function Spawn( entityKeyValues )
	thisEntity:SetContextThink("GreevilThink", GreevilThink, 0.1)
	thisEntity.Puri = thisEntity:FindAbilityByName("greevil_purification")
	thisEntity.Spir = thisEntity:FindAbilityByName("wisp_spirits_datadriven")
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
		units = FindUnitsInLine(DOTA_TEAM_GOODGUYS, (Vector(-6400, 5760, 256)), (Vector(-6400, -3584, 256)), nil, 1400.0, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE)
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

			if thisEntity.Spir:IsFullyCastable() then
				CastSpir(target)
				GreevilThink = 0.3
				return GreevilThink
			end

			if thisEntity.Puri:IsFullyCastable() then
				CastPuri(target)
				GreevilThink = 0.3
				return GreevilThink
			end

  			thisEntity:MoveToTargetToAttack(target)
			GreevilThink = 1.5
			return GreevilThink
  		end
	end	
end

----------------- Abilities -----------------

function CastSpir()
	thisEntity:CastAbilityNoTarget(thisEntity.Spir, -1)
end

function CastPuri(target)
	thisEntity:CastAbilityOnTarget(thisEntity, thisEntity.Puri, -1)
end