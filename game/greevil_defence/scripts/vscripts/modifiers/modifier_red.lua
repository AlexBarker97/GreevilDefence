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

    caster.material = tostring(1)
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
	caster:AddAbility("greevil_sticky_bomb")
	caster:AddAbility("greevil_tag_team_custom")
	caster:AddAbility("greevil_berserkers_blood_custom")
	caster:AddAbility("greeil_feast_custom")
	caster:AddAbility("generic_hidden")
	--local ability1 = caster:AddAbility("invoker_chaos_meteor_lua")
	--caster:UpgradeAbility(ability1)
	caster:AddAbility("greevil_unleash_custom")

	local particle1 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_red/courier_greevil_red_ambient_1.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	local particle1 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_red/courier_greevil_red_ambient_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	local particle1 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_red/courier_greevil_red_ambient_c.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	local particle1 = ParticleManager:CreateParticle("particles/econ/courier/courier_greevil_red/courier_greevil_red_ambient_d.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)

    EmitSoundOn("DOTA_Item.Sheepstick.Activate", caster)
end