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

	local itemSeed = RandomInt(1, 1000)
	if (itemSeed > 0) and (itemSeed <= 200) then
		local item = CreateItem("item_gloves_of_travel", nil, nil)
		item:SetPurchaseTime(0)
		caster:AddItem(item)
	elseif (itemSeed > 200) and (itemSeed <= 400) then
		local item = CreateItem("item_vengeances_shadow", nil, nil)
		item:SetPurchaseTime(0)
		caster:AddItem(item)
	elseif (itemSeed > 400) and (itemSeed <= 600) then
		local item = CreateItem("item_oakheart", nil, nil)
		item:SetPurchaseTime(0)
		caster:AddItem(item)
	elseif (itemSeed > 600) and (itemSeed <= 800) then
		local item = CreateItem("item_light_robes", nil, nil)
		item:SetPurchaseTime(0)
		caster:AddItem(item)
	elseif (itemSeed > 800) and (itemSeed <= 1000) then
		local item = CreateItem("item_ancient_perseverance", nil, nil)
		item:SetPurchaseTime(0)
		caster:AddItem(item)
	end

    EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), "RoshanDT.BucketDrop", caster)
	EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), "Item.TomeOfKnowledge", caster)
end