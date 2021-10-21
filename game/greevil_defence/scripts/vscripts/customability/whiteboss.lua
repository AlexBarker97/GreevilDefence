if whiteboss == nil then
	print ( '[WhiteBoss] creating whiteboss lua' )
	whiteboss = {}
	whiteboss.__index = whiteboss
end

function whiteboss:OOds(caster)
	
	nearEnemies = FindUnitsInRadius(caster:GetTeam(), caster:GetAbsOrigin(), nil,
		1500, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST, false)

	closestEnemy = nearEnemies[1]

	local unit = CreateUnitByName("greevil_white_red", closestEnemy:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
	local side = closestEnemy:GetAbsOrigin()[1] < 0
	if side == true then
		unit.side = "rad"
	elseif side == false then
		unit.side = "dire"
	end
end

function whiteboss:LSA(caster)
	
	nearEnemies = FindUnitsInRadius(caster:GetTeam(), caster:GetAbsOrigin(), nil,
		1500, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST, false)

	closestEnemy = nearEnemies[1]

	local unit = CreateUnitByName("greevil_white_orange", closestEnemy:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
	local side = closestEnemy:GetAbsOrigin()[1] < 0
	if side == true then
		unit.side = "rad"
	elseif side == false then
		unit.side = "dire"
	end
end

function whiteboss:ESlam(caster)
	
	nearEnemies = FindUnitsInRadius(caster:GetTeam(), caster:GetAbsOrigin(), nil,
		1500, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST, false)

	closestEnemy = nearEnemies[1]

	local unit = CreateUnitByName("greevil_white_yellow", closestEnemy:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
	local side = closestEnemy:GetAbsOrigin()[1] < 0
	if side == true then
		unit.side = "rad"
	elseif side == false then
		unit.side = "dire"
	end
end

function whiteboss:Rav(caster)
	
	nearEnemies = FindUnitsInRadius(caster:GetTeam(), caster:GetAbsOrigin(), nil,
		1500, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST, false)

	closestEnemy = nearEnemies[1]

	local unit = CreateUnitByName("greevil_white_green", closestEnemy:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
	local side = closestEnemy:GetAbsOrigin()[1] < 0
	if side == true then
		unit.side = "rad"
	elseif side == false then
		unit.side = "dire"
	end
end

function whiteboss:FBite(caster)
	
	nearEnemies = FindUnitsInRadius(caster:GetTeam(), caster:GetAbsOrigin(), nil,
		1500, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST, false)

	closestEnemy = nearEnemies[1]

	local unit = CreateUnitByName("greevil_white_blue", closestEnemy:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
	local side = closestEnemy:GetAbsOrigin()[1] < 0
	if side == true then
		unit.side = "rad"
	elseif side == false then
		unit.side = "dire"
	end
end

function whiteboss:Vac(caster)
	
	nearEnemies = FindUnitsInRadius(caster:GetTeam(), caster:GetAbsOrigin(), nil,
		1500, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST, false)

	closestEnemy = nearEnemies[1]

	local unit = CreateUnitByName("greevil_white_purple", closestEnemy:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
	local side = closestEnemy:GetAbsOrigin()[1] < 0
	if side == true then
		unit.side = "rad"
	elseif side == false then
		unit.side = "dire"
	end
end

function whiteboss:WoW(caster)
	
	nearEnemies = FindUnitsInRadius(caster:GetTeam(), caster:GetAbsOrigin(), nil,
		2000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST, false)

	closestEnemy = nearEnemies[1]
	local side = closestEnemy:GetAbsOrigin()[1] < 0

	local unit = CreateUnitByName("greevil_white_red", closestEnemy:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
	if side == true then
		unit.side = "rad"
	elseif side == false then
		unit.side = "dire"
	end
	local unit = CreateUnitByName("greevil_white_orange", closestEnemy:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
	if side == true then
		unit.side = "rad"
	elseif side == false then
		unit.side = "dire"
	end
	local unit = CreateUnitByName("greevil_white_yellow", closestEnemy:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
	if side == true then
		unit.side = "rad"
	elseif side == false then
		unit.side = "dire"
	end
	local unit = CreateUnitByName("greevil_white_green", closestEnemy:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
	if side == true then
		unit.side = "rad"
	elseif side == false then
		unit.side = "dire"
	end
	local unit = CreateUnitByName("greevil_white_blue", closestEnemy:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
	if side == true then
		unit.side = "rad"
	elseif side == false then
		unit.side = "dire"
	end
	local unit = CreateUnitByName("greevil_white_purple", closestEnemy:GetAbsOrigin(), true, caster, caster, caster:GetTeamNumber())
	if side == true then
		unit.side = "rad"
	elseif side == false then
		unit.side = "dire"
	end
end