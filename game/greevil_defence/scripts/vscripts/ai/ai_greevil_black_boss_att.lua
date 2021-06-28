function Spawn( entityKeyValues )
	thisEntity:SetContextThink("GreevilThink", GreevilThink, 0.1)
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
		units = FindUnitsInRadius(team, thisEntity:GetOrigin(), nil, 6000.0, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)
	elseif team == DOTA_TEAM_BADGUYS then
		units = FindUnitsInRadius(team, thisEntity:GetOrigin(), nil, 6000.0, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)
	end
	
  	if units ~= nil then
  		if #units >= 1 then
			target = units[1]
  			thisEntity:MoveToPositionAggressive(target:GetOrigin())
  		end
  	end
	
	if ( thisEntity:GetAggroTarget() ) then
		return 2.0
	end
	
	return 0.5
end
--------------------------------------------------------------------------------