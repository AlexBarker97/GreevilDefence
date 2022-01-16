LinkLuaModifier("modifier_candy_red", "scripts/vscripts/modifiers/candy/modifier_candy_red", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_candy_orange", "scripts/vscripts/modifiers/candy/modifier_candy_orange", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_candy_yellow", "scripts/vscripts/modifiers/candy/modifier_candy_yellow", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_candy_green", "scripts/vscripts/modifiers/candy/modifier_candy_green", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_candy_blue", "scripts/vscripts/modifiers/candy/modifier_candy_blue", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_candy_purple", "scripts/vscripts/modifiers/candy/modifier_candy_purple", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_candy_white", "scripts/vscripts/modifiers/candy/modifier_candy_white", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_candy_black", "scripts/vscripts/modifiers/candy/modifier_candy_black", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_candy_god", "scripts/vscripts/modifiers/candy/modifier_candy_god", LUA_MODIFIER_MOTION_NONE)

candy = class({})

function Red(keys)
	local BONUS_DAMAGE = 10
	local caster = keys.caster
	local target = keys.target
	local myModifier = target:FindModifierByName("modifier_candy_red")
	if not myModifier then
		myModifier = target:AddNewModifier(target, nil, "modifier_candy_red", {})
	end
	myModifier:SetStackCount(myModifier:GetStackCount() + BONUS_DAMAGE)
	
	for i=0,8 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_candy_red" then
			caster:RemoveItem(item)
			break
		end
	end
end

function Orange(keys)
	local STATUS_RES = 5
	local caster = keys.caster
	local target = keys.target
	local myModifier = target:FindModifierByName("modifier_candy_orange")
	if not myModifier then
		myModifier = target:AddNewModifier(target, nil, "modifier_candy_orange", {})
	end
	if myModifier:GetStackCount() ~= 100 then
		myModifier:SetStackCount(myModifier:GetStackCount() + STATUS_RES)
	end
	
	for i=0,8 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_candy_orange" then
			caster:RemoveItem(item)
			break
		end
	end
end

function Yellow(keys)
	local ARMOUR = 2
	local caster = keys.caster
	local target = keys.target
	local myModifier = target:FindModifierByName("modifier_candy_yellow")
	if not myModifier then
		myModifier = target:AddNewModifier(target, nil, "modifier_candy_yellow", {})
	end
	myModifier:SetStackCount(myModifier:GetStackCount() + ARMOUR)
	
	for i=0,8 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_candy_yellow" then
			caster:RemoveItem(item)
			break
		end
	end
end

function Green(keys)
	local HP_REGEN = 3
	local caster = keys.caster
	local target = keys.target
	local myModifier = target:FindModifierByName("modifier_candy_green")
	if not myModifier then
		myModifier = target:AddNewModifier(target, nil, "modifier_candy_green", {})
	end
	myModifier:SetStackCount(myModifier:GetStackCount() + HP_REGEN)
	
	for i=0,8 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_candy_green" then
			caster:RemoveItem(item)
			break
		end
	end
end

function Blue(keys)
	local MP_REGEN = 2
	local caster = keys.caster
	local target = keys.target
	local myModifier = target:FindModifierByName("modifier_candy_blue")
	if not myModifier then
		myModifier = target:AddNewModifier(target, nil, "modifier_candy_blue", {})
	end
	myModifier:SetStackCount(myModifier:GetStackCount() + MP_REGEN)
	
	for i=0,8 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_candy_blue" then
			caster:RemoveItem(item)
			break
		end
	end
end

function Purple(keys)
	local SPELL_AMP = 5
	local caster = keys.caster
	local target = keys.target
	local myModifier = target:FindModifierByName("modifier_candy_purple")
	if not myModifier then
		myModifier = target:AddNewModifier(target, nil, "modifier_candy_purple", {})
	end
	myModifier:SetStackCount(myModifier:GetStackCount() + SPELL_AMP)
	
	for i=0,8 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_candy_purple" then
			caster:RemoveItem(item)
			break
		end
	end
end

function White(keys)
	local MOVE_SPEED = 20
	local caster = keys.caster
	local target = keys.target
	local myModifier = target:FindModifierByName("modifier_candy_white")
	if not myModifier then
		myModifier = target:AddNewModifier(target, nil, "modifier_candy_white", {})
	end
	myModifier:SetStackCount(myModifier:GetStackCount() + MOVE_SPEED)
	
	for i=0,8 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_candy_white" then
			caster:RemoveItem(item)
			break
		end
	end
end

function Black(keys)
	local MAGIC_RES = 25
	local caster = keys.caster
	local target = keys.target
	local myModifier = target:FindModifierByName("modifier_candy_black")
	if not myModifier then
		myModifier = target:AddNewModifier(target, nil, "modifier_candy_black", {})
	end
	myModifier:SetStackCount(myModifier:GetStackCount() + MAGIC_RES)
	
	for i=0,8 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_candy_black" then
			caster:RemoveItem(item)
			break
		end
	end
end

function God(keys)
	local BONUS = 5000
	local caster = keys.caster
	local target = keys.target
	local myModifier = target:FindModifierByName("modifier_candy_god")
	if not myModifier then
		myModifier = target:AddNewModifier(target, nil, "modifier_candy_god", {})
	end

	myModifier:SetStackCount(myModifier:GetStackCount() + BONUS)
	
	for i=0,8 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_candy_god" then
			caster:RemoveItem(item)
			break
		end
	end
end