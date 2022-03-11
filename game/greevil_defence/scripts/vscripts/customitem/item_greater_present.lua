if item_greater_present == nil then
    item_greater_present = class({})
end

function item_greater_present:GetBehavior() 
    local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
    return behav
end

function item_greater_present:GetManaCost()
    return 0
end

function item_greater_present:OnSpellStart()
    local caster = self:GetCaster()

    for i=0,14 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_greater_present" then
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
	if (itemSeed > 0) and (itemSeed <= 200) then
		local item = CreateItem("item_wizard_cookie", nil, nil)
		item:SetPurchaseTime(0)
		caster:AddItem(item)
	elseif (itemSeed > 200) and (itemSeed <= 400) then
		local item = CreateItem("item_fruitbit_cake", nil, nil)
		item:SetPurchaseTime(0)
		caster:AddItem(item)
	elseif (itemSeed > 400) and (itemSeed <= 600) then
		local item = CreateItem("item_kringle", nil, nil)
		item:SetPurchaseTime(0)
		caster:AddItem(item)
	elseif (itemSeed > 600) and (itemSeed <= 800) then
		local item = CreateItem("item_fishbones", nil, nil)
		item:SetPurchaseTime(0)
		caster:AddItem(item)
	elseif (itemSeed > 800) and (itemSeed <= 1000) then
		local item = CreateItem("item_snow_mushroom", nil, nil)
		item:SetPurchaseTime(0)
		caster:AddItem(item)
	end

    EmitSoundOn("RoshanDT.BucketDrop", caster)
	EmitSoundOn("Item.TomeOfKnowledge", caster)
end