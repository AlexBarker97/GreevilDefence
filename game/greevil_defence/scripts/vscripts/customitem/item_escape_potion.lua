if item_escape_potion == nil then
    item_escape_potion = class({})
end

function item_escape_potion:GetBehavior() 
    local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
    return behav
end

function item_escape_potion:GetManaCost()
    return 0
end

function item_escape_potion:OnSpellStart()
    local caster = self:GetCaster()

    for i=0,14 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_escape_potion" then
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

	local effectDuration = 15
	caster:AddNewModifier(caster, nil, "modifier_invisible", { duration = effectDuration })
	caster:AddNewModifier(caster, nil, "modifier_phased", { duration = effectDuration })
	caster:AddNewModifier(caster, nil, "modifier_disarmed", { duration = effectDuration })
	caster:AddNewModifier(caster, nil, "modifier_no_healthbar", { duration = effectDuration})
	caster:AddNewModifier(caster, nil, "modifier_doom_bringer_doom", { duration = effectDuration})

    EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), "DOTA_Item.SmokeOfDeceit.Activate", caster)
    EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), "DOTA_Item.ClarityPotion.Activate", caster)
end