function Spawn( entityKeyValues )
	thisEntity:SetContextThink("GreevilThink", GreevilThink, 0.5)
end

function GreevilThink()
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
	
	local position = Vector(-6928, -2896, 304) + (Vector(RandomInt(0,1056), RandomInt(0,300), 0))
	thisEntity:MoveToPositionAggressive(position)
	GreevilThink = RandomInt(5,10)
	return GreevilThink
end