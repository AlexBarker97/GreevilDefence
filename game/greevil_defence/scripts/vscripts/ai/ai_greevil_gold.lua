function Spawn( entityKeyValues )
	thisEntity.Ownership = thisEntity:FindAbilityByName("Ownership")
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

	if ( not thisEntity:GetAggroTarget() ) then
		return 1.0
	end

	if thisEntity.Ownership:IsFullyCastable() then
		CastOwnership()
		return 0.5
	end
	
	return 1
end
--------------------------------------------------------------------------------
function CastOwnership()
	thisEntity:CastAbilityOnTarget(thisEntity:GetAttackTarget(),thisEntity:FindAbilityByName("Ownership"), -1)
end