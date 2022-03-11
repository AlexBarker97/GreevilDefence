if item_present == nil then
    item_present = class({})
end

function item_present:GetBehavior() 
    local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
    return behav
end

function item_present:GetManaCost()
    return 0
end

function item_present:OnSpellStart()
    local caster = self:GetCaster()

    for i=0,14 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_present" then
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

	local itemSeed = RandomInt(1, 1000)
	if itemSeed > 500 then
		local escapePot = CreateItem("item_escape_potion", nil, nil)
		escapePot:SetPurchaseTime(0)
		caster:AddItem(escapePot)
	else
		local tranquility = CreateItem("item_tranquility", nil, nil)
		tranquility:SetPurchaseTime(0)
		caster:AddItem(tranquility)
	end

    EmitSoundOn("RoshanDT.BucketDrop", caster)
	EmitSoundOn("Item.TomeOfKnowledge", caster)
end