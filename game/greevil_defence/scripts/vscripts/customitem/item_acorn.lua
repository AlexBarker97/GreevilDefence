if item_acorn == nil then
    item_acorn = class({})
end

function item_acorn:GetBehavior() 
    local behav = DOTA_ABILITY_BEHAVIOR_POINT
    return behav
end

function item_acorn:GetManaCost()
    return 0
end

function item_acorn:GetCooldown(nLevel)
    return 2
end

function item_acorn:OnSpellStart()
    local vPoint = self:GetCursorPosition()
    CreateTempTreeWithModel(vPoint, 60.0, "models/props_tree/dire_tree003.vmdl")
end