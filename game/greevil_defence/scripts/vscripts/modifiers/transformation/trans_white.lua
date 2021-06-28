trans_white = class({})
LinkLuaModifier("transformation_mod", "modifiers/transformation/transformation_mod.lua", LUA_MODIFIER_MOTION_NONE)
require ("libraries/selection")

function CreateGreevil(keys)
	local caster = keys.caster
	local origin = caster:GetAbsOrigin()
	local playerid = caster:GetOwner():GetPlayerID()
	caster:GetOwner().greevil = CreateUnitByName("greevil_white_player", origin, true, caster:GetOwner(), caster:GetOwner(), caster:GetTeamNumber())
	caster:GetOwner().greevil.hero = 1
	local greevil = caster:GetOwner().greevil
	greevil:SetControllableByPlayer(playerid, true)
	whistle = CreateItem("item_white_return", greevil, greevil)
	local whistle = whistle
	whistle:SetPurchaseTime(0)
	greevil:AddItem(whistle)
	whistle = CreateItem("item_white_whistle", caster:GetOwner(), caster:GetOwner())
	local whistle = whistle
	whistle:SetPurchaseTime(0)
	caster:GetOwner():AddItem(whistle)
	caster:Destroy()
	PlayerResource:NewSelection(playerid, greevil)
end

function ToHero(keys)
	local caster = keys.caster
	local player = caster:GetOwner()
	local playerid = player:GetPlayerID()
	local origin = caster:GetAbsOrigin()
	player:RemoveNoDraw()
	player:RemoveModifierByName("transformation_mod")
	player:RemoveModifierByName("modifier_particles")
	player:SetAbsOrigin(origin)
	caster:AddNoDraw()
	caster:AddNewModifier(caster, nil, "transformation_mod", {duration = -1})
	caster:SetAbsOrigin(Vector(0, 0, -1000))
	PlayerResource:NewSelection(playerid, player)
end

function ToGreevil(keys)
	local caster = keys.caster
	local playerid = caster:GetPlayerID()
	local origin = caster:GetAbsOrigin()
	local greevil = caster.greevil
	caster:AddNoDraw()
	caster:AddNewModifier(caster, nil, "transformation_mod", {duration = -1})
	greevil:RemoveModifierByName("transformation_mod")
	greevil:RemoveModifierByName("modifier_particles")
	greevil:RemoveNoDraw()
	greevil:SetAbsOrigin(origin)
	PlayerResource:NewSelection(playerid, greevil)
end

