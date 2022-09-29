bossloot = class({})

function ActivateRed(keys)
	local caster = keys.caster
	for i=0,8 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_boss_drop_red" then
			caster:RemoveItem(item)
			caster:AddItemByName("item_bosstoken_red")
			caster:AddItemByName("item_candy_red")
		end
	end
end

function ActivateOrange(keys)
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

function ActivateYellow(keys)
	local caster = keys.caster
	for i=0,8 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_boss_drop_yellow" then
			caster:RemoveItem(item)
			caster:AddItemByName("item_bosstoken_yellow")
			caster:AddItemByName("item_candy_yellow")
		end
	end
end

function ActivateGreen(keys)
	local caster = keys.caster
	for i=0,8 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_boss_drop_green" then
			caster:RemoveItem(item)
			caster:AddItemByName("item_bosstoken_green")
			caster:AddItemByName("item_candy_green")
		end
	end
end

function ActivateBlue(keys)
	local caster = keys.caster
	for i=0,8 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_boss_drop_blue" then
			caster:RemoveItem(item)
			caster:AddItemByName("item_bosstoken_blue")
			caster:AddItemByName("item_candy_blue")
		end
	end
end

function ActivatePurple(keys)
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

function ActivateWhite(keys)
	local caster = keys.caster
	for i=0,8 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_boss_drop_white" then
			caster:RemoveItem(item)
			caster:AddItemByName("item_bosstoken_white")
			caster:AddItemByName("item_candy_white")
		end
	end
end

function ActivateBlack(keys)
	local caster = keys.caster
	for i=0,8 do
		local item = caster:GetItemInSlot(i)
		if item ~= nil and item:GetAbilityName() == "item_boss_drop_black" then
			caster:RemoveItem(item)
			caster:AddItemByName("item_bosstoken_black")
			caster:AddItemByName("item_candy_black")
		end
	end
end

function SummonRed(keys)
	local caster = keys.caster
	local team = caster:GetTeam()
	if team == DOTA_TEAM_GOODGUYS then
		location = (Vector(5872, 3500, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
	elseif team == DOTA_TEAM_BADGUYS then
		location = (Vector(-6928, 3500, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
	end
	local unit = CreateUnitByName("greevil_red_boss_att", location, true, nil, nil, team)
end

function SummonOrange(keys)
	local caster = keys.caster
	local team = caster:GetTeam()
	if team == DOTA_TEAM_GOODGUYS then
		location = (Vector(5872, 3500, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
	elseif team == DOTA_TEAM_BADGUYS then
		location = (Vector(-6928, 3500, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
	end
	local unit = CreateUnitByName("greevil_orange_boss_att", location, true, nil, nil, team)
end

function SummonYellow(keys)
	local caster = keys.caster
	local team = caster:GetTeam()
	if team == DOTA_TEAM_GOODGUYS then
		location = (Vector(5872, 3500, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
	elseif team == DOTA_TEAM_BADGUYS then
		location = (Vector(-6928, 3500, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
	end
	local unit = CreateUnitByName("greevil_yellow_boss_att", location, true, nil, nil, team)
end

function SummonGreen(keys)
	local caster = keys.caster
	local team = caster:GetTeam()
	if team == DOTA_TEAM_GOODGUYS then
		location = (Vector(5872, 3500, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
	elseif team == DOTA_TEAM_BADGUYS then
		location = (Vector(-6928, 3500, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
	end
	local unit = CreateUnitByName("greevil_green_boss_att", location, true, nil, nil, team)
end

function SummonBlue(keys)
	local caster = keys.caster
	local team = caster:GetTeam()
	if team == DOTA_TEAM_GOODGUYS then
		location = (Vector(5872, 3500, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
	elseif team == DOTA_TEAM_BADGUYS then
		location = (Vector(-6928, 3500, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
	end
	local unit = CreateUnitByName("greevil_blue_boss_att", location, true, nil, nil, team)
end

function SummonPurple(keys)
	local caster = keys.caster
	local team = caster:GetTeam()
	if team == DOTA_TEAM_GOODGUYS then
		location = (Vector(5872, 3500, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
	elseif team == DOTA_TEAM_BADGUYS then
		location = (Vector(-6928, 3500, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
	end
	local unit = CreateUnitByName("greevil_purple_boss_att", location, true, nil, nil, team)
end

function SummonWhite(keys)
	local caster = keys.caster
	local team = caster:GetTeam()
	if team == DOTA_TEAM_GOODGUYS then
		location = (Vector(5872, 3500, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
	elseif team == DOTA_TEAM_BADGUYS then
		location = (Vector(-6928, 3500, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
	end
	local unit = CreateUnitByName("greevil_white_boss_att", location, true, nil, nil, team)
end

function SummonBlack(keys)
	local caster = keys.caster
	local team = caster:GetTeam()
	if team == DOTA_TEAM_GOODGUYS then
		location = (Vector(5872, 3500, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
	elseif team == DOTA_TEAM_BADGUYS then
		location = (Vector(-6928, 3500, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
	end
	local unit = CreateUnitByName("greevil_black_boss_att", location, true, nil, nil, team)
end