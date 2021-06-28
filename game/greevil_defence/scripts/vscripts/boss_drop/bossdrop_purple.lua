bossdrop_purple = class({})

function Activate(keys)
	local caster = keys.caster
	for i=0,8 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_boss_drop_purple" then
			caster:RemoveItem(item)
			caster:AddItemByName("item_bosstoken_purple")
			caster:AddItemByName("item_candy_purple")
		end
	end
end