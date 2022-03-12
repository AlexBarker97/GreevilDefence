LinkLuaModifier("modifier_farm", "scripts/vscripts/modifiers/modifier_farm", LUA_MODIFIER_MOTION_NONE)

if item_farm == nil then
    item_farm = class({})
end

function item_farm:GetBehavior() 
    local behav = DOTA_ABILITY_BEHAVIOR_POINT
    return behav
end

function item_farm:GetManaCost()
    return 0
end

function item_farm:OnSpellStart()
    local vPoint = self:GetCursorPosition()
    local caster = self:GetCaster()
    local team = caster:GetTeam()

    unit = CreateUnitByName("npc_dota_creep_badguys_melee_upgraded_mega", vPoint, true, nil, nil, team)
    unit:SetAbsOrigin(vPoint)
    unit:FaceTowards(unit:GetAbsOrigin()+Vector(RandomInt(-50,50), 100, 0))
    ability1 = unit:GetAbilityByIndex(0)
    abilityname1 = ability1:GetAbilityName()
    unit:RemoveAbility(abilityname1)
    unit:AddAbility("farm_gold")

    unit:RemoveModifierByName("modifier_invulnerable")
	unit:AddNewModifier(caster, nil, "modifier_farm", {})
	unit:AddNewModifier(caster, nil, "modifier_harpy_scout_take_off", {})
	unit:AddNewModifier(caster, nil, "modifier_disarmed", {})

    EmitSoundOn("Damage.Building", caster)
end