require "math"

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
    local gridSnap = 192
    local duration = 60.0

    local vPoint = self:GetCursorPosition()
    local x = ((math.floor((vPoint[1]) / gridSnap) * gridSnap) + 64)
    local y = (math.floor((vPoint[2]+64) / gridSnap) * gridSnap)
    local vPointCentre = Vector(x, y, vPoint[3])

    local vPoint1 = (vPointCentre + Vector(-32,32,0))
    local vPoint2 = (vPointCentre + Vector(0,32,0))
    local vPoint3 = (vPointCentre + Vector(32,32,0))
    local vPoint4 = (vPointCentre + Vector(-32,0,0))
    local vPoint6 = (vPointCentre + Vector(32,0,0))
    local vPoint7 = (vPointCentre + Vector(-32,-32,0))
    local vPoint8 = (vPointCentre + Vector(0,-32,0))
    local vPoint9 = (vPointCentre + Vector(32,-32,0))

    local ent1 = SpawnEntityFromTableSynchronous("point_simple_obstruction", {origin = vPoint1})
    local ent2 = SpawnEntityFromTableSynchronous("point_simple_obstruction", {origin = vPoint2})
    local ent3 = SpawnEntityFromTableSynchronous("point_simple_obstruction", {origin = vPoint3})
    local ent4 = SpawnEntityFromTableSynchronous("point_simple_obstruction", {origin = vPoint4})
    local ent5 = SpawnEntityFromTableSynchronous("point_simple_obstruction", {origin = vPointCentre})
    local ent6 = SpawnEntityFromTableSynchronous("point_simple_obstruction", {origin = vPoint6})
    local ent7 = SpawnEntityFromTableSynchronous("point_simple_obstruction", {origin = vPoint7})
    local ent8 = SpawnEntityFromTableSynchronous("point_simple_obstruction", {origin = vPoint8})
    local ent9 = SpawnEntityFromTableSynchronous("point_simple_obstruction", {origin = vPoint9})

    Timers:CreateTimer(duration, function()
				ent1:RemoveSelf()
				ent2:RemoveSelf()
				ent3:RemoveSelf()
				ent4:RemoveSelf()
				ent5:RemoveSelf()
				ent6:RemoveSelf()
				ent7:RemoveSelf()
				ent8:RemoveSelf()
				ent9:RemoveSelf()
			end)

    barrier = CreateTempTreeWithModel(vPointCentre + Vector(32,32,0), duration, "models/buildings/building_plain_reference.vmdl")
    barrier:SetForwardVector(Vector(100, 100, 0))
end