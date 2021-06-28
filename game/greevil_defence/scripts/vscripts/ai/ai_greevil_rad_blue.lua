function Spawn( entityKeyValues )
	thisEntity:SetContextThink("GreevilThink", GreevilThink, 0.5)
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

	local units = FindUnitsInLine(DOTA_TEAM_GOODGUYS, (Vector(6400, 5760, 256)), (Vector(6400, -3584, 256)), nil, 1400.0, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE)

  	if units ~= nil then
  		if #units >= 1 then
			target = units[1]
  			thisEntity:MoveToPositionAggressive(target:GetOrigin())
  			return 1
  		end
  	end

	if ( not thisEntity:GetAggroTarget() ) then
		return 1.0
	end
	
	return 1
end
--------------------------------------------------------------------------------
