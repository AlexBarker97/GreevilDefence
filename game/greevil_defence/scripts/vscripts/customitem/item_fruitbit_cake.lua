if item_fruitbit_cake == nil then
    item_fruitbit_cake = class({})
end

function item_fruitbit_cake:GetBehavior() 
    local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
    return behav
end

function item_fruitbit_cake:GetManaCost()
    return 0
end

function item_fruitbit_cake:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local healAmount = 20
	local manaAmount = 8
	local effectDuration = 10
	local interval = 0.25

	target:AddNewModifier(caster, item_fruitbit_cake,"modifier_movespeed_percentage", {duration = effectDuration, isHidden = false})

    for i=0,14 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_fruitbit_cake" then
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

	local counter = 0
	local timer1 = Timers:CreateTimer(0, function()
		if counter <= effectDuration then
			regen(target,healAmount,manaAmount)
			counter = counter + interval;
		else
			Timers:RemoveTimer(timer1)
		end
		return interval
	end)

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