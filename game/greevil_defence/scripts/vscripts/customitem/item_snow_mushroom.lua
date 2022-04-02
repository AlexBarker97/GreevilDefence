if item_snow_mushroom == nil then
    item_snow_mushroom = class({})
end

function item_snow_mushroom:GetBehavior() 
    local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
    return behav
end

function item_snow_mushroom:GetManaCost()
    return 0
end

function item_snow_mushroom:OnSpellStart()
	local caster = self:GetCaster()

	local ability1 = caster:GetAbilityByIndex(0)
	local ability2 = caster:GetAbilityByIndex(1)
	local ability3 = caster:GetAbilityByIndex(2)
	local ability4 = caster:GetAbilityByIndex(3)
	local ability5 = caster:GetAbilityByIndex(4)
	local ability6 = caster:GetAbilityByIndex(5)
	local ability7 = caster:GetAbilityByIndex(6)
	local abilities = {ability1,ability2,ability3,ability4,ability5,ability6}

	for i=0,6 do
		local ability = caster:GetAbilityByIndex(i)
		if ability ~= nil then
			ability:EndCooldown()
		end
	end

    for i=0,14 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_snow_mushroom" then
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

	EmitSoundOn("RoshanDT.Gobble", caster)
end