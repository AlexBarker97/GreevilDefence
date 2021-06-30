bossdrop_black = class({})

function Activate(keys)
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

function Summon(keys)
	local caster = keys.caster
	local team = caster:GetTeam()
	if team == DOTA_TEAM_GOODGUYS then
		location = (Vector(5872, 3500, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
	elseif team == DOTA_TEAM_BADGUYS then
		location = (Vector(-6928, 3500, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
	end
	local unit = CreateUnitByName("greevil_black_boss_att", location, true, nil, nil, team)
end