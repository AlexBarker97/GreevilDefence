if item_kringle == nil then
    item_kringle = class({})
end

function item_kringle:GetBehavior() 
    local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
    return behav
end

function item_kringle:GetManaCost()
    return 0
end

function item_kringle:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local healAmount = 100
	local manaAmount = 64

    for i=0,14 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_kringle" then
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

	regen(target,healAmount,manaAmount)

	EmitSoundOn("RoshanDT.Gobble", target)
end

function regen(target,hp,mana)
	local currentHP = target:GetHealth()
	local maxHP = target:GetMaxHealth()
	local currentMP = target:GetMana()
	local maxMP = target:GetMaxMana()

	if (currentHP + hp) > maxHP then
		target:SetHealth(maxHP)
	else
		target:SetHealth(currentHP + hp)
	end

	if (currentMP + mana) > maxMP then
		target:SetMana(maxMP)
	else
		target:SetMana(currentMP + mana)
	end
end