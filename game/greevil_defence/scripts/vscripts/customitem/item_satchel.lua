if item_satchel_custom == nil then
    item_satchel_custom = class({})
end

function item_satchel_custom:GetBehavior() 
    local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
    return behav
end

function item_satchel_custom:GetManaCost()
    return 0
end

function item_satchel_custom:OnSpellStart()
    local caster = self:GetCaster()

    for i=0,14 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_satchel_custom" then
			if item:GetContainer() ~= nil then
				item:GetContainer():Destroy()
			end
			caster:RemoveItem(item)
		end
	end

	local itemSeed = RandomInt(1, 800)
	if (itemSeed > 0) and (itemSeed <= 200) then
		local item = CreateItem("item_gloves_of_travel", nil, nil)
		item:SetPurchaseTime(0)
		caster:AddItem(item)
	elseif (itemSeed > 200) and (itemSeed <= 400) then
		local item = CreateItem("item_venom_gland", nil, nil)
		item:SetPurchaseTime(0)
		caster:AddItem(item)
		itemSeed = itemSeed - 200
	elseif (itemSeed > 400) and (itemSeed <= 600) then
		local item = CreateItem("item_oakheart", nil, nil)
		item:SetPurchaseTime(0)
		caster:AddItem(item)
		itemSeed = itemSeed - 400
	elseif (itemSeed > 600) and (itemSeed <= 800) then
		local item = CreateItem("item_ancient_perseverance", nil, nil)
		item:SetPurchaseTime(0)
		caster:AddItem(item)
		itemSeed = itemSeed - 600
	end

	if (itemSeed > 0) and (itemSeed <= 40) then
		local item = CreateItem("item_wizard_cookie", nil, nil)
		item:SetPurchaseTime(0)
		caster:AddItem(item)
	elseif (itemSeed > 40) and (itemSeed <= 80) then
		local item = CreateItem("item_fruitbit_cake", nil, nil)
		item:SetPurchaseTime(0)
		caster:AddItem(item)
	elseif (itemSeed > 80) and (itemSeed <= 120) then
		local item = CreateItem("item_kringle", nil, nil)
		item:SetPurchaseTime(0)
		caster:AddItem(item)
	elseif (itemSeed > 120) and (itemSeed <= 160) then
		local item = CreateItem("item_fishbones", nil, nil)
		item:SetPurchaseTime(0)
		caster:AddItem(item)
	elseif (itemSeed > 160) and (itemSeed <= 200) then
		local item = CreateItem("item_snow_mushroom", nil, nil)
		item:SetPurchaseTime(0)
		caster:AddItem(item)
	end

    EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), "RoshanDT.BucketDrop", caster)
	EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), "Item.TomeOfKnowledge", caster)
end