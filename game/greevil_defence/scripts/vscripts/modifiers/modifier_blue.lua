modifier_red = class({})
require ("libraries/selection")
require ("libraries/timers")

function OnUsed(keys)
	local caster = keys.caster
	local origin = caster:GetAbsOrigin()
	local playerid = caster:GetPlayerID()

	if origin[1] <= 0 then -- radiant
		origin = (Vector(-7168, -5504, 128)) + (Vector(RandomInt(0,1536),RandomInt(0,896), 0))
	else -- dire
		origin = (Vector(5632, -5504, 128)) + (Vector(RandomInt(0,1536),RandomInt(0,896), 0))
	end
    caster:SetAbsOrigin(origin)

	PlayerResource:SetCameraTarget(playerid, caster)
	Timers:CreateTimer({endTime = 0.15,
		callback = function()
		PlayerResource:SetCameraTarget(playerid, nil)
	end})

    caster.material = tostring(5)
    caster:SetMaterialGroup(caster.material)

	caster:RemoveAbility("red")
	caster:RemoveAbility("orange")
	caster:RemoveAbility("yellow")
	caster:RemoveAbility("green")
	caster:RemoveAbility("blue")
	caster:RemoveAbility("purple")
	caster:RemoveAbility("white")
	caster:RemoveAbility("black")
	caster:AddAbility("greevil_magic_missile_custom")
	caster:AddAbility("greevil_frost_armor_custom")
	caster:AddAbility("greevil_chain_frost_player_custom")
	caster:AddAbility("greevil_brilliance_aura_custom")
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_freezing_field_custom")

	local particle1 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_blue/courier_greevil_blue_ambient_1.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	local particle2 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_blue/courier_greevil_blue_ambient_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	local particle3 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_blue/courier_greevil_blue_ambient_c.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	local particle4 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_blue/courier_greevil_blue_ambient_d.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	local particle4 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_blue/courier_greevil_blue_ambient_e.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	local particle4 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_blue/courier_greevil_blue_ambient_g.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)

    EmitSoundOn("DOTA_Item.Sheepstick.Activate", caster)
end