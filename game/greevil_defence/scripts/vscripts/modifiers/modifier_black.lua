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

    caster.material = tostring(8)
    caster:SetMaterialGroup(caster.material)
	caster.eyes:SetMaterialGroup(caster.material)
	caster.ears:SetMaterialGroup(caster.material)
	caster.horns:SetMaterialGroup(caster.material)
	caster.hair:SetMaterialGroup(caster.material)
	caster.nose:SetMaterialGroup(caster.material)
	caster.tail:SetMaterialGroup(caster.material)
	caster.teeth:SetMaterialGroup(caster.material)

	caster:RemoveAbility("red")
	caster:RemoveAbility("orange")
	caster:RemoveAbility("yellow")
	caster:RemoveAbility("green")
	caster:RemoveAbility("blue")
	caster:RemoveAbility("purple")
	caster:RemoveAbility("white")
	caster:RemoveAbility("black")
	caster:AddAbility("greevil_brain_sap_custom")
	caster:AddAbility("greevil_devour")
	caster:AddAbility("greevil_possession")
	caster:AddAbility("greevil_pact_custom")
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_consume_custom")

	local particle1 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_black/courier_greevil_black_ambient_1.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	local particle2 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_black/courier_greevil_black_ambient_3_a.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	local particle3 = ParticleManager:CreateParticle("particles/econ/courier/courier_babyroshan_ti10/courier_babyroshan_ti10_dire_ambient_smoke_c.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	local particle3 = ParticleManager:CreateParticle("particles/econ/courier/courier_babyroshan_ti10/courier_babyroshan_ti10_dire_ambient_smoke_a.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	local particle4 = ParticleManager:CreateParticle("particles/econ/courier/courier_babyroshan_ti10/courier_babyroshan_ti10_dire_ambient_hallucination.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)

    EmitSoundOn("DOTA_Item.Sheepstick.Activate", caster)
end