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

    caster.material = tostring(7)
    caster:SetMaterialGroup(caster.material)

	caster:RemoveAbility("red")
	caster:RemoveAbility("orange")
	caster:RemoveAbility("yellow")
	caster:RemoveAbility("green")
	caster:RemoveAbility("blue")
	caster:RemoveAbility("purple")
	caster:RemoveAbility("white")
	caster:RemoveAbility("black")
	caster:AddAbility("greevil_purification_custom")
	caster:AddAbility("greevil_dream_coil_custom")
	caster:AddAbility("greevil_overcharge_custom")
	caster:AddAbility("generic_hidden")
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_guardian_angel_custom")

	ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_white/courier_greevil_white_ambient_1.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_white/courier_greevil_white_ambient_1b.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	-- appears broken ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_white/courier_greevil_white_ambient_3_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_white/courier_greevil_white_ambient_3_c.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_white/courier_greevil_white_ambient_3_d.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_white/courier_greevil_white_ambient_3_e.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_white/courier_greevil_white_ambient_3_f.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_white/courier_greevil_white_ambient_3_g.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_white/courier_greevil_white_ambient_3_h.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_white/courier_greevil_white_ambient_3_i.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_white/courier_greevil_white_ambient_3_j.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)

    EmitSoundOn("DOTA_Item.Sheepstick.Activate", caster)
end