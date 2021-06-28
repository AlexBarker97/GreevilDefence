bossdrop_orange = class({})

function Activate(keys)
	local caster = keys.caster
	for i=0,8 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_boss_drop_orange" then
			caster:RemoveItem(item)
			caster:AddItemByName("item_bosstoken_orange")
			caster:AddItemByName("item_candy_orange")
		end
	end
end