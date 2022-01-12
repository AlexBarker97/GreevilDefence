if item_meteor_shower == nil then
    item_meteor_shower = class({})
end

function item_meteor_shower:GetBehavior() 
    local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
    return behav
end

function item_meteor_shower:GetManaCost()
    return 0
end

function item_meteor_shower:OnSpellStart()
    local caster = self:GetCaster()
	EmitGlobalSound("RoshanDT.Halloween_Apocalypse")
    for i=0,14 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_meteor_shower" then
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
end