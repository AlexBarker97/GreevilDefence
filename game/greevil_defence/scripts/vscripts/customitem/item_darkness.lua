if item_darkness == nil then
    item_darkness = class({})
end

function item_darkness:GetBehavior() 
    local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
    return behav
end

function item_darkness:GetManaCost()
    return 0
end

function item_darkness:OnSpellStart()
	local caster = self:GetCaster()
	local casterteam = caster:GetTeam()

	for i=0,14 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_darkness" then
			local curr = item:GetCurrentCharges()
			if curr > 1 then
				item:SetCurrentCharges(curr-1)
			else
				if item:GetContainer() ~= nil then
					item:GetContainer():Destroy()
				end
				caster:RemoveItem(item)
			end
		end
	end

	local enemyvision
	if casterteam == 2 then --radiant
		enemyvision = FindUnitsInRadius(DOTA_TEAM_BADGUYS, Vector(0, 0, 128), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
										DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
	elseif casterteam == 3 then --dire
		enemyvision = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, Vector(0, 0, 128), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
										DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
	end

	local filtList = {}
	for i=1,#enemyvision do
		if enemyvision[i]:GetUnitName() == "vision" then
			filtList[#filtList+1] = enemyvision[i]
		end
	end

	for i=1,#filtList do
		local unit = filtList[i]

		unit:RemoveAbility("vision_vision")
		unit:RemoveModifierByName("vision_modifier")

		unit:AddAbility("vision_novision")
		local ab = unit:FindAbilityByName('vision_novision')
		ab:UpgradeAbility(true)
	end

	EmitGlobalSound("Hero_NightStalker.Pick")
	EmitGlobalSound("Tutorial.Tidehunter.Escape")
	

	Timers:CreateTimer({endTime = 60.0,
	callback = function()

		for i=1,#filtList do
			local unit = filtList[i]
			unit:RemoveAbility("vision_novision")
			unit:RemoveModifierByName("novision_modifier")

			unit:AddAbility("vision_vision")
			local ab = unit:FindAbilityByName('vision_vision')
			ab:UpgradeAbility(true)

			EmitGlobalSound("Tutorial.Quest.complete_01")
		end
	end})
end