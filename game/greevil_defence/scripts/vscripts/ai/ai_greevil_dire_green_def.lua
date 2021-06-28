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
	
	local position = Vector(5872, -2896, 304) + (Vector(RandomInt(0,1056), RandomInt(0,944), 0))
	thisEntity:MoveToPositionAggressive(position)
	return RandomInt(5,10)
end
--------------------------------------------------------------------------------
