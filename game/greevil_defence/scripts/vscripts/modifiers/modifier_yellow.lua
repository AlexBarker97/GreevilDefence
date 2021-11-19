modifier_red = class({})
require ("libraries/selection")
require ("libraries/timers")
LinkLuaModifier("modifier_generic_charges", "scripts/vscripts/lua_abilities/generic/modifier_generic_charges", LUA_MODIFIER_MOTION_NONE)

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

    caster.material = tostring(3)
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
	caster:AddAbility("greevil_penitence_custom")
	caster:AddAbility("greevil_shadow_wave_custom")
	caster:AddAbility("greevil_surge_custom")
	caster:AddAbility("greevil_summon_turret_custom")
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_poison_nova_custom")
	local abilitySurge = caster:FindAbilityByName('greevil_surge_custom')
	caster:AddNewModifier(caster, abilitySurge, "modifier_generic_charges", {})

	local particle1 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_yellow/courier_greevil_yellow_ambient_1.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	local particle2 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_yellow/courier_greevil_yellow_ambient_3_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	local particle3 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_yellow/courier_greevil_yellow_ambient_3_c.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	local particle4 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_yellow/courier_greevil_yellow_ambient_3_d.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	local particle5 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_yellow/courier_greevil_yellow_ambient_arcs_parent.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)

    EmitSoundOn("DOTA_Item.Sheepstick.Activate", caster)
end