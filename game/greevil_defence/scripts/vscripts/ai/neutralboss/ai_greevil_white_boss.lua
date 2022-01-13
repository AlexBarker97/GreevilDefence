--AI States:
--IDLE = 0
--AGGRESSIVE = 1
--RETURNING = 2

AI_THINK_INTERVAL = 0.1

function Spawn( entityKeyValues )

	thisEntity.Odds = thisEntity:FindAbilityByName("greevil_white_overwhelming_odds")
	thisEntity.LSA = thisEntity:FindAbilityByName("greevil_white_light_strike_array")
	thisEntity.ESlam = thisEntity:FindAbilityByName("greevil_white_echo_slam")
	thisEntity.Rav = thisEntity:FindAbilityByName("greevil_white_ravage")
	thisEntity.FBite = thisEntity:FindAbilityByName("greevil_white_frostbite")
	thisEntity.Vac = thisEntity:FindAbilityByName("greevil_white_vacuum")
	thisEntity.WoW = thisEntity:FindAbilityByName("greevil_white_will_o_wisp")
	
	thisEntity.state = 0 --Initial state
	
	aggroRange = 1500
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
	AI_THINK_INTERVAL = 1.2

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
	local pctHP = (thisEntity:GetHealth()/thisEntity:GetMaxHealth())
	if #units > 0 and pctHP > 0.92 then
		if thisEntity.Odds:IsFullyCastable() then
			CastOdds()
			return true
		end
	end
	
	if #units > 0 and pctHP < 0.92 and pctHP > 0.90 then
		if thisEntity.LSA:IsFullyCastable() then
			CastLSA()
			return true
		end
	end

	if #units > 0 and pctHP < 0.84 and pctHP > 0.82 then
		if thisEntity.ESlam:IsFullyCastable() then
			CastESlam()
			return true
		end
	end

	if #units > 0 and pctHP < 0.76 and pctHP > 0.74 then
		if thisEntity.Rav:IsFullyCastable() then
			CastRav()
			return true
		end
	end

	if #units > 0 and pctHP < 0.67 and pctHP > 0.65 then
		if thisEntity.FBite:IsFullyCastable() then
			CastFBite()
			return true
		end
	end

	if #units > 0 and pctHP < 0.59 and pctHP > 0.58 then
		if thisEntity.Vac:IsFullyCastable() then
			CastVac()
			return true
		end
	end

	if #units > 0 and pctHP < 0.51 then
		if thisEntity.WoW:IsFullyCastable() then
			CastWoW()
			return true
		end
	end

	local units = FindUnitsInRadius( thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		leashRange+200, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_CLOSEST, false )

	local spawnP = thisEntity.spawnPos
	local enemyP = units[1]:GetAbsOrigin()
	local distance = (spawnP - enemyP):Length()

	if distance < 250 then
		thisEntity:MoveToPositionAggressive(enemyP)
	else
		thisEntity:MoveToPosition((spawnP*2 + enemyP)/3)
	end

end

function ReturningThink()
	if (thisEntity.spawnPos - thisEntity:GetAbsOrigin()):Length() < 150 then
		thisEntity.state = 0
	else
		thisEntity:MoveToPosition(thisEntity.spawnPos)
	end
end

----------------- Abilities -----------------

function CastOdds()
	AI_THINK_INTERVAL = 2.0
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, false)
	
	thisEntity:CastAbilityOnPosition(units[1]:GetAbsOrigin(), thisEntity.Odds, -1)
end

function CastLSA()
	AI_THINK_INTERVAL = 2.0
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, false)
	
	thisEntity:CastAbilityOnPosition(units[1]:GetAbsOrigin(), thisEntity.LSA, -1)
end

function CastESlam()
	AI_THINK_INTERVAL = 2.0
	thisEntity:CastAbilityNoTarget(thisEntity.ESlam, -1)
end

function CastRav()
	AI_THINK_INTERVAL = 2.0
	thisEntity:CastAbilityNoTarget(thisEntity.Rav, -1)
end

function CastFBite()
	AI_THINK_INTERVAL = 2.0
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, false)
	
	thisEntity:CastAbilityOnTarget(units[1], thisEntity.FBite, -1)
end

function CastVac()
	AI_THINK_INTERVAL = 2.0
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, false)
	
	thisEntity:CastAbilityOnPosition(thisEntity:GetAbsOrigin(), thisEntity.Vac, -1)
end

function CastWoW()
	AI_THINK_INTERVAL = 2.0
	local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil,
		aggroRange, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
		FIND_ANY_ORDER, false)
	
	thisEntity:CastAbilityOnPosition(thisEntity:GetAbsOrigin(), thisEntity.WoW, -1)
end