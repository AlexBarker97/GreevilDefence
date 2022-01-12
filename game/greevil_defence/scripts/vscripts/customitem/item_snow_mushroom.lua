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
	local ability5 = caster:GetAbilityByIndex(5)
	ability1:EndCooldown()
	ability2:EndCooldown()
	ability3:EndCooldown()
	ability4:EndCooldown()
	ability5:EndCooldown()

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