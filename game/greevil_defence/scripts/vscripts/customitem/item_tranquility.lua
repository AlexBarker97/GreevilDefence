if item_tranquility == nil then
    item_tranquility = class({})
end

function item_tranquility:GetBehavior() 
    local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
    return behav
end

function item_tranquility:GetManaCost()
    return 0
end

function item_tranquility:OnSpellStart()
    local caster = self:GetCaster()

    for i=0,14 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_tranquility" then
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

	local effectDuration = 5
	caster:AddNewModifier(caster, nil, "modifier_rune_super_regen", { duration = effectDuration})
	caster:AddNewModifier(caster, nil, "modifier_terrorblade_fear", { duration = effectDuration})
	caster:AddNewModifier(caster, nil, "modifier_treant_living_armor", { duration = effectDuration})
	caster:AddNewModifier(caster, nil, "modifier_no_healthbar", { duration = effectDuration})

    EmitSoundOn("DOTA_Item.TranquilBoots.Activate", caster)
    EmitSoundOn("DOTA_Item.ClarityPotion.Activate", caster)
end