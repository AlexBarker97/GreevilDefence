trans_blue = class({})
LinkLuaModifier("transformation_mod", LUA_MODIFIER_MOTION_NONE)
require ("libraries/selection")
require ("libraries/timers")

function ToGreevil(keys)
	local caster = keys.caster
	local player = caster:GetPlayerID()
	local origin = caster:GetAbsOrigin()
	if origin[1] <= 0 then -- radiant
		local origin = (Vector(-7872, -5440, 128)) + (Vector(RandomInt(0,2944),RandomInt(0,896), 0))
		caster.greevil = CreateUnitByName("greevil_selection", origin, true, caster, caster, caster:GetTeamNumber())
		caster.greevil.hero = 1
		local greevil = caster.greevil
		greevil:SetControllableByPlayer(player, true)
		for i=0,10 do
			local item = caster:GetItemInSlot(i)
			if item ~= nil then
				caster:RemoveItem(item)
			end
		end
		caster:AddNoDraw()
		caster:AddNewModifier(caster, nil, "transformation_mod", {duration = -1})
		greevil:RemoveModifierByName("transformation_mod")
		greevil:RemoveModifierByName("modifier_particles")
		greevil:RemoveNoDraw()
		greevil:SetAbsOrigin(origin)
		PlayerResource:NewSelection(player, greevil)
		PlayerResource:SetCameraTarget(player, greevil)
		Timers:CreateTimer({endTime = 0.1,
			callback = function()
			PlayerResource:SetCameraTarget(player, nil)
		end})
	else -- dire
		local origin = (Vector(4800, -5440, 128)) + (Vector(RandomInt(0,1600),RandomInt(0,896), 0))
		caster.greevil = CreateUnitByName("greevil_selection", origin, true, caster, caster, caster:GetTeamNumber())
		caster.greevil.hero = 1
		local greevil = caster.greevil
		greevil:SetControllableByPlayer(player, true)
		for i=0,10 do
			local item = caster:GetItemInSlot(i)
			if item ~= nil then
				caster:RemoveItem(item)
			end
		end
		caster:AddNoDraw()
		caster:AddNewModifier(caster, nil, "transformation_mod", {duration = -1})
		greevil:RemoveModifierByName("transformation_mod")
		greevil:RemoveModifierByName("modifier_particles")
		greevil:RemoveNoDraw()
		greevil:SetAbsOrigin(origin)
		PlayerResource:NewSelection(player, greevil)
		PlayerResource:SetCameraTarget(player, greevil)
		Timers:CreateTimer({endTime = 0.1,
			callback = function()
			PlayerResource:SetCameraTarget(player, nil)
		end})
	end
end