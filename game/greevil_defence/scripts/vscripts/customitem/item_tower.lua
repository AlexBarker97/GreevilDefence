LinkLuaModifier("modifier_tower", "scripts/vscripts/modifiers/modifier_tower", LUA_MODIFIER_MOTION_NONE)

if item_tower == nil then
    item_tower = class({})
end

function item_tower:GetBehavior() 
    local behav = DOTA_ABILITY_BEHAVIOR_POINT
    return behav
end

function item_tower:GetManaCost()
    return 0
end

function item_tower:OnSpellStart()
    local duration = 30.0
    local vPoint = self:GetCursorPosition()
    local caster = self:GetCaster()
    local team = caster:GetTeam()

    unit = CreateUnitByName("npc_dota_badguys_tower2_mid", vPoint, true, nil, nil, team)
    unit:SetAbsOrigin(vPoint)

    unit:RemoveModifierByName("modifier_invulnerable")
    unit:AddNewModifier(caster, nil, "modifier_neutral_spell_immunity_visible", { duration = duration })
	unit:AddNewModifier(caster, nil, "lifeline_lua", { duration = duration })
	unit:AddNewModifier(caster, nil, "modifier_tower", { duration = duration })

    EmitSoundOn("Damage.Building", caster)
end