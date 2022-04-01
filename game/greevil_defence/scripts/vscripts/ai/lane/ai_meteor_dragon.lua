AI_THINK_INTERVAL = 0.25
offset = 200
count = 0
timer = 0

function Spawn( entityKeyValues )
	thisEntity:SetContextThink("GreevilThink", GreevilThink, 0.1)
	thisEntity.Meteor = thisEntity:FindAbilityByName("invoker_chaos_meteor_lua")
end

function GreevilThink()
	if not IsServer() then
		return
	end

	if ( not thisEntity:IsAlive() ) then
		AI_THINK_INTERVAL = -1
		return AI_THINK_INTERVAL
	end

	if GameRules:IsGamePaused() == true then
		AI_THINK_INTERVAL = 0.5
		return AI_THINK_INTERVAL
	end

	local team = thisEntity:GetTeam()
	
	if count <= 38 then
		count = count + 1
		MeteorScript(team)
	else
		if team == DOTA_TEAM_GOODGUYS then
			thisEntity:SetAbsOrigin(Vector(6400, -3600, 256))
		else
			thisEntity:SetAbsOrigin(Vector(-6400, -3600, 256))
		end
		KillScript()
	end
	
	return AI_THINK_INTERVAL
end

function MeteorScript(team)

	local ypos = RandomInt(-2500, 6000)
	local xpos
	
	if team == DOTA_TEAM_GOODGUYS then
		xpos = 7200
	else
		xpos = -5600
	end

	local offsetx = RandomInt(-600, -200)
	local offsety = RandomInt(-500, -300)

	thisEntity:SetAbsOrigin(Vector(xpos, ypos, 256))
	local target = Vector(xpos + offsetx, ypos + offsety, 256)
	thisEntity:CastAbilityOnPosition(target, thisEntity.Meteor, -1)
		
	return true
end

function KillScript()

	if timer <= 3 then
		timer = timer + 1
	else
		thisEntity:ForceKill(false)
	end
		
	return true
end