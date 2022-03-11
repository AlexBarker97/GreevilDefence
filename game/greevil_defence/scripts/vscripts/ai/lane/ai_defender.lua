function Spawn( entityKeyValues )
	thisEntity:SetContextThink("GreevilThink", GreevilThink, 0.1)
end

function GreevilThink()
	local position
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
		position = Vector(-6928, -2600, 304) + (Vector(RandomInt(0,1056), RandomInt(0,150), 0))
	elseif team == DOTA_TEAM_BADGUYS then
		position = Vector(5872, -2600, 304) + (Vector(RandomInt(0,1056), RandomInt(0,150), 0))
	end
	
	thisEntity:MoveToPositionAggressive(position)
	GreevilThink = RandomInt(5,10)
	return GreevilThink
end