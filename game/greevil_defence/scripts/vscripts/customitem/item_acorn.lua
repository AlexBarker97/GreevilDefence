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

function item_acorn:OnSpellStart()
    local duration = 45.0
    local vPoint = self:GetCursorPosition()
    local caster = self:GetCaster()

    if vPoint[1] < 0 then
        vPoint1 = Vector(-6960, vPoint[2], 256)
        vPoint2 = Vector(-6778, vPoint[2], 256)
        vPoint3 = Vector(-6596, vPoint[2], 256)
        vPoint4 = Vector(-6414, vPoint[2], 256)
        vPoint5 = Vector(-6232, vPoint[2], 256)
        vPoint6 = Vector(-6050, vPoint[2], 256)
        vPoint7 = Vector(-5868, vPoint[2], 256)
    else
        vPoint1 = Vector(6956, vPoint[2], 256)
        vPoint2 = Vector(6774, vPoint[2], 256)
        vPoint3 = Vector(6592, vPoint[2], 256)
        vPoint4 = Vector(6410, vPoint[2], 256)
        vPoint5 = Vector(6228, vPoint[2], 256)
        vPoint6 = Vector(6046, vPoint[2], 256)
        vPoint7 = Vector(5864, vPoint[2], 256)
    end

    barrier1 = CreateTempTreeWithModel(vPoint1, duration, "models/buildings/building_plain_reference.vmdl")
    barrier2 = CreateTempTreeWithModel(vPoint2, duration, "models/buildings/building_plain_reference.vmdl")
    barrier3 = CreateTempTreeWithModel(vPoint3, duration, "models/buildings/building_plain_reference.vmdl")
    barrier4 = CreateTempTreeWithModel(vPoint4, duration, "models/buildings/building_plain_reference.vmdl")
    barrier5 = CreateTempTreeWithModel(vPoint5, duration, "models/buildings/building_plain_reference.vmdl")
    barrier6 = CreateTempTreeWithModel(vPoint6, duration, "models/buildings/building_plain_reference.vmdl")
    barrier7 = CreateTempTreeWithModel(vPoint7, duration, "models/buildings/building_plain_reference.vmdl")
    barrier1:SetForwardVector(Vector(100, 100, 0))
    barrier2:SetForwardVector(Vector(100, 100, 0))
    barrier3:SetForwardVector(Vector(100, 100, 0))
    barrier4:SetForwardVector(Vector(100, 100, 0))
    barrier5:SetForwardVector(Vector(100, 100, 0))
    barrier6:SetForwardVector(Vector(100, 100, 0))
    barrier7:SetForwardVector(Vector(100, 100, 0))

    EmitSoundOn("Damage.Building", caster)
end