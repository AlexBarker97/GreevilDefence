summon_turret = class({})

LinkLuaModifier( "lifeline_lua", "modifiers/lifeline_lua", LUA_MODIFIER_MOTION_NONE )

function Summon(event)
	local point = event.target_points[1]
	local caster = event.caster
	local unit = CreateUnitByName("greevil_turret", point, true, caster:GetOwner(), caster:GetOwner(), caster:GetTeamNumber())
	unit:AddNewModifier(caster, nil, "modifier_neutral_spell_immunity_visible", { duration = 30 })
	unit:AddNewModifier(caster, nil, "lifeline_lua", { duration = 30 })
end