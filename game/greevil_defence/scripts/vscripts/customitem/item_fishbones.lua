if item_fishbones == nil then
    item_fishbones = class({})
end

function item_fishbones:GetBehavior() 
    local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
    return behav
end

function item_fishbones:GetManaCost()
    return 0
end

function item_fishbones:OnSpellStart()
	local caster = self:GetCaster()
	local effectDuration = 15

	caster:AddNewModifier(caster, item_fishbones,"modifier_rune_doubledamage", {duration = effectDuration})

    for i=0,14 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_fishbones" then
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