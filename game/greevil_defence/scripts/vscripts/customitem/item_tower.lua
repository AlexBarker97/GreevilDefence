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
    local duration = 45.0
    local vPoint = self:GetCursorPosition()
    local caster = self:GetCaster()
    local team = caster:GetTeam()

    unit = CreateUnitByName("npc_dota_badguys_tower4", vPoint, true, nil, nil, team)
    unit:SetAbsOrigin(vPoint)
    unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, 100, 0))

    EmitSoundOn("Damage.Building", caster)
end