LinkLuaModifier("modifier_greevil_red", "scripts/vscripts/modifiers/modifier_greevil_red", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_greevil_test", "scripts/vscripts/modifiers/modifier_greevil_test", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_greevil_orange", "scripts/vscripts/modifiers/modifier_greevil_orange", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_greevil_yellow", "scripts/vscripts/modifiers/modifier_greevil_yellow", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_greevil_green", "scripts/vscripts/modifiers/modifier_greevil_green", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_greevil_blue", "scripts/vscripts/modifiers/modifier_greevil_blue", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_greevil_purple", "scripts/vscripts/modifiers/modifier_greevil_purple", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_greevil_white", "scripts/vscripts/modifiers/modifier_greevil_white", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_greevil_black", "scripts/vscripts/modifiers/modifier_greevil_black", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_greevil_naked", "scripts/vscripts/modifiers/modifier_greevil_naked", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_greevil_boss_sres", "scripts/vscripts/modifiers/modifier_greevil_boss_sres", LUA_MODIFIER_MOTION_NONE)

--[[
	Basic Barebones
]]

require('barebones')
require('libraries/player_resource')
require('libraries/timers')

function Precache( context )
	-- NOTE: IT IS RECOMMENDED TO USE A MINIMAL AMOUNT OF LUA PRECACHING, AND A MAXIMAL AMOUNT OF DATADRIVEN PRECACHING.
	-- Precaching guide: https://moddota.com/forums/discussion/119/precache-fixing-and-avoiding-issues

	--[[
	This function is used to precache resources/units/items/abilities that will be needed
	for sure in your game and that cannot or should not be precached asynchronously or 
	after the game loads.

	See GameMode:PostLoadPrecache() in barebones.lua for more information
	]]

	print("Performing pre-load precache")

	-- Particles can be precached individually or by folder
	-- It it likely that precaching a single particle system will precache all of its children, but this may not be guaranteed
	--PrecacheResource("particle", "particles/econ/generic/generic_aoe_explosion_sphere_1/generic_aoe_explosion_sphere_1.vpcf", context)
	--PrecacheResource("particle_folder", "particles/test_particle", context)

	-- Models can also be precached by folder or individually
	-- PrecacheModel should generally used over PrecacheResource for individual models
	--PrecacheResource("model_folder", "particles/heroes/antimage", context)
	--PrecacheResource("model", "particles/heroes/viper/viper.vmdl", context)
	--PrecacheModel("models/heroes/viper/viper.vmdl", context)

	-- Sounds can precached here like anything else
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_furion.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_ui_imported.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/voscripts/game_sounds_vo_siltbreaker.vsndevts", context)

	-- Entire items can be precached by name
	-- Abilities can also be precached in this way despite the name
	--PrecacheItemByNameSync("example_ability", context)
	--PrecacheItemByNameSync("item_example_item", context)

	-- Entire heroes (sound effects/voice/models/particles) can be precached with PrecacheUnitByNameSync
	-- Custom units from npc_units_custom.txt can also have all of their abilities and precache{} blocks precached in this way
	--PrecacheUnitByNameSync("npc_dota_hero_ancient_apparition", context)
	--PrecacheUnitByNameSync("npc_dota_hero_enigma", context)
	PrecacheModel("models/courier/greevil/greevil.vmdl", context)
	PrecacheUnitByNameSync("greevil_red", context)
	PrecacheUnitByNameSync("greevil_orange", context)
	PrecacheUnitByNameSync("greevil_yellow", context)
	PrecacheUnitByNameSync("greevil_green", context)
	PrecacheUnitByNameSync("greevil_blue", context)
	PrecacheUnitByNameSync("greevil_purple", context)
	PrecacheUnitByNameSync("greevil_white", context)
	PrecacheUnitByNameSync("greevil_black", context)
	PrecacheUnitByNameSync("greevil_naked_rad", context)
	PrecacheUnitByNameSync("greevil_naked_dire", context)
end

-- Create the game mode when we activate
function Activate()
	GameMode = GameMode()
	GameMode:InitGameMode()
	require('libraries/filters')
	EntitySpawn()		--Listener for entity spawns
	EntityKilled()		--Listener for entities killed
	GameStart()			--Listener for game start (timers)
end

function EntitySpawn()
	ListenToGameEvent("npc_spawned", function(params)
		local unit = EntIndexToHScript(params.entindex)
		
		--RED NEUTRAL BOSS
		if unit:GetUnitName() == "greevil_red" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_red", {})
			unit:AddNewModifier(nil, nil, "modifier_greevil_boss_sres", {})
			unit:AddItemByName("item_boss_drop_red")
			local colour = "red"
			Timers:CreateTimer(0.01, function()
				local team = FindTeam(unit)
				BossSpawn(colour, team)
			end)
			BossSpawn(colour, team)
		elseif unit:GetUnitName() == "greevil_white_red" or unit:GetUnitName() == "greevil_red_rad_att" or unit:GetUnitName() == "greevil_red_dire_att" or unit:GetUnitName() == "greevil_red_rad_def" or unit:GetUnitName() == "greevil_red_dire_def" or unit:GetUnitName() == "greevil_red_player" or unit:GetUnitName() == "greevil_red_boss_att" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_red", {})

		--ORANGE NEUTRAL BOSS
		elseif unit:GetUnitName() == "greevil_orange" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_orange", {})
			unit:AddNewModifier(nil, nil, "modifier_greevil_boss_sres", {})
			unit:AddItemByName("item_boss_drop_orange")
			local colour = "orange"
			Timers:CreateTimer(0.02, function()
				local team = FindTeam(unit)
				BossSpawn(colour, team)
			end)
		elseif unit:GetUnitName() == "greevil_white_orange" or unit:GetUnitName() == "greevil_orange_rad_att" or unit:GetUnitName() == "greevil_orange_dire_att" or unit:GetUnitName() == "greevil_orange_rad_def" or unit:GetUnitName() == "greevil_orange_dire_def" or unit:GetUnitName() == "greevil_orange_player" or unit:GetUnitName() == "greevil_orange_boss_att" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_orange", {})

		--YELLOW NEUTRAL BOSS
		elseif unit:GetUnitName() == "greevil_yellow" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_yellow", {})
			unit:AddNewModifier(nil, nil, "modifier_greevil_boss_sres", {})
			unit:AddItemByName("item_boss_drop_yellow")
			local colour = "yellow"
			Timers:CreateTimer(0.03, function()
				local team = FindTeam(unit)
				BossSpawn(colour, team)
			end)
		elseif unit:GetUnitName() == "greevil_white_yellow" or unit:GetUnitName() == "greevil_yellow_rad_att" or unit:GetUnitName() == "greevil_yellow_dire_att" or unit:GetUnitName() == "greevil_yellow_rad_def" or unit:GetUnitName() == "greevil_yellow_dire_def" or unit:GetUnitName() == "greevil_yellow_player" or unit:GetUnitName() == "greevil_yellow_boss_att" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_yellow", {})
		elseif unit:GetUnitName() == "greevil_turret" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_yellow", {})

		--GREEN NEUTRAL BOSS
		elseif unit:GetUnitName() == "greevil_green" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_green", {})
			unit:AddNewModifier(nil, nil, "modifier_greevil_boss_sres", {})
			unit:AddItemByName("item_boss_drop_green")
			local colour = "green"
			Timers:CreateTimer(0.04, function()
				local team = FindTeam(unit)
				BossSpawn(colour, team)
			end)
		elseif unit:GetUnitName() == "greevil_white_green" or unit:GetUnitName() == "greevil_green_rad_att" or unit:GetUnitName() == "greevil_green_dire_att" or unit:GetUnitName() == "greevil_green_rad_def" or unit:GetUnitName() == "greevil_green_dire_def" or unit:GetUnitName() == "greevil_green_player" or unit:GetUnitName() == "greevil_green_boss_att" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_green", {})	
		elseif unit:GetUnitName() == "greevil_green_2" or unit:GetUnitName() == "greevil_green_3" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_green", {})

		--BLUE NEUTRAL BOSS
		elseif unit:GetUnitName() == "greevil_blue" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_blue", {})
			unit:AddNewModifier(nil, nil, "modifier_greevil_boss_sres", {})
			unit:AddItemByName("item_boss_drop_blue")
			local colour = "blue"
			Timers:CreateTimer(0.05, function()
				local team = FindTeam(unit)
				BossSpawn(colour, team)
			end)
		elseif unit:GetUnitName() == "greevil_white_blue" or unit:GetUnitName() == "greevil_blue_rad_att" or unit:GetUnitName() == "greevil_blue_dire_att" or unit:GetUnitName() == "greevil_blue_rad_def" or unit:GetUnitName() == "greevil_blue_dire_def" or unit:GetUnitName() == "greevil_blue_player" or unit:GetUnitName() == "greevil_blue_boss_att" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_blue", {})

		--PURPLE NEUTRAL BOSS
		elseif unit:GetUnitName() == "greevil_purple" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_purple", {})
			unit:AddNewModifier(nil, nil, "modifier_greevil_boss_sres", {})
			unit:AddItemByName("item_boss_drop_purple")
			local colour = "purple"
			Timers:CreateTimer(0.06, function()
				local team = FindTeam(unit)
				BossSpawn(colour, team)
			end)
		elseif unit:GetUnitName() == "greevil_white_purple" or unit:GetUnitName() == "greevil_purple_rad_att" or unit:GetUnitName() == "greevil_purple_dire_att" or unit:GetUnitName() == "greevil_purple_rad_def" or unit:GetUnitName() == "greevil_purple_dire_def" or unit:GetUnitName() == "greevil_purple_player" or unit:GetUnitName() == "greevil_purple_boss_att" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_purple", {})
			
		--WHITE	NEUTRAL BOSS
		elseif unit:GetUnitName() == "greevil_white" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_white", {})
			unit:AddNewModifier(nil, nil, "modifier_greevil_boss_sres", {})
			unit:AddItemByName("item_boss_drop_white")
			local colour = "white"
			Timers:CreateTimer(0.07, function()
				local team = FindTeam(unit)
				BossSpawn(colour, team)
			end)
		elseif unit:GetUnitName() == "greevil_white_rad_att" or unit:GetUnitName() == "greevil_white_dire_att" or unit:GetUnitName() == "greevil_white_rad_def" or unit:GetUnitName() == "greevil_white_dire_def" or unit:GetUnitName() == "greevil_white_player" or unit:GetUnitName() == "greevil_white_boss_att" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_white", {})
			
		--BLACK NEUTRAL BOSS
		elseif unit:GetUnitName() == "greevil_black" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_black", {})
			unit:AddNewModifier(nil, nil, "modifier_greevil_boss_sres", {})
			unit:AddItemByName("item_boss_drop_black")
			local colour = "black"
			Timers:CreateTimer(0.08, function()
				local team = FindTeam(unit)
				BossSpawn(colour, team)
			end)
		elseif unit:GetUnitName() == "greevil_black_rad_att" or unit:GetUnitName() == "greevil_black_dire_att" or unit:GetUnitName() == "greevil_black_rad_def" or unit:GetUnitName() == "greevil_black_dire_def" or unit:GetUnitName() == "greevil_black_player" or unit:GetUnitName() == "greevil_black_boss_att" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_black", {})		
	
		elseif unit:GetUnitName() == "greevil_naked_dire" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_naked", {})
		elseif unit:GetUnitName() == "greevil_naked_rad" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_naked", {})
		end
	end, self)
end

function EntityKilled()
	ListenToGameEvent("entity_killed", function(params)
		local unit = EntIndexToHScript(params.entindex_killed)
		local unitName = unit:GetUnitName()
		local team = FindTeam(unit)
		if unitName == "greevil_red" 
		or unitName == "greevil_orange"
		or unitName == "greevil_yellow"
		or unitName == "greevil_green"
		or unitName == "greevil_blue"
		or unitName == "greevil_purple"
		or unitName == "greevil_white"
		or unitName == "greevil_black" then
			local colour = string.sub(unitName, 9)
			BossDie(colour, team)
		end
	end, self)
end

function GameStart()
	ListenToGameEvent("game_rules_state_change", function(params)
		if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		
			local pointr = Entities:FindAllByName("spawnerino_boss")
			for k,v in pairs(pointr) do
				local location = v:GetAbsOrigin()
				local unit = CreateUnitByName("greevil_boss", location, false, nil, nil, DOTA_TEAM_NEUTRALS)
			end		
			
			count = 0;
			Timers:CreateTimer(0, function()
			
				if count == 5 then
					SpawnBot()
				end
				if math.fmod(count,5) == 0 then
					SpawnFrostWard()
				end
				if math.fmod(count,60) == 0 then
					SpawnBosses()
				end
				if math.fmod(count,120) == 0 and count ~= 0 then
					LevelGreevils()
				end
				if math.fmod(count,30) == 0 then
					SpawnCreeps()
				end
				count = count + 1;
				
			return 1
			end)
		elseif GameRules:State_Get() == DOTA_GAMERULES_STATE_PRE_GAME then
			local radgate = CreateUnitByName("door", Vector(-3712, 1920, 128), false, nil, nil, DOTA_TEAM_NEUTRALS)
			local particle1 = ParticleManager:CreateParticle("particles/units/heroes/hero_arc_warden/arc_warden_flux_tgt.vpcf", PATTACH_ABSORIGIN_FOLLOW, radgate)
			local diregate = CreateUnitByName("door", Vector(3712, 1920, 128), false, nil, nil, DOTA_TEAM_NEUTRALS)
			local particle2 = ParticleManager:CreateParticle("particles/units/heroes/hero_arc_warden/arc_warden_flux_tgt.vpcf", PATTACH_ABSORIGIN_FOLLOW, diregate)
			radgate.disabled = 0
			diregate.disabled = 0	
		end
	end, self)
end

function SpawnBot()
	local PlayerCountOnRad = PlayerResource:GetPlayerCountForTeam(DOTA_TEAM_GOODGUYS)
	local PlayerCountOnDire = PlayerResource:GetPlayerCountForTeam(DOTA_TEAM_BADGUYS)
	if PlayerCountOnRad < 1 then
		local unit = CreateUnitByName("npc_dota_hero_necrolyte", Vector(-6400,-2944,256), true, nil, nil, DOTA_TEAM_GOODGUYS)
		unit:AddExperience(90000,0,false,false)
		local HStopper = unit:FindAbilityByName("necrolyte_heartstopper_aura")
		unit:AddAbility("bot_ability")
		local BotAbility = unit:FindAbilityByName("bot_ability")
		HStopper:SetLevel(4)
		BotAbility:SetLevel(1)
		Say(unit, "0 rad players", false)
	elseif PlayerCountOnDire < 1 then
		local unit = CreateUnitByName("npc_dota_hero_necrolyte", Vector(6400,-2944,256), true, nil, nil, DOTA_TEAM_BADGUYS)
		unit:AddExperience(90000,0,false,false)
		local HStopper = unit:FindAbilityByName("necrolyte_heartstopper_aura")
		unit:AddAbility("bot_ability")
		local BotAbility = unit:FindAbilityByName("bot_ability")
		HStopper:SetLevel(4)
		BotAbility:SetLevel(1)
		Say(unit, "0 dire players", false)
	end
end

function SpawnFrostWard()
	local point = Entities:FindAllByName("spawnerino_frost")
	for k,v in pairs(point) do				
		local location = v:GetAbsOrigin()
		local findUnits = FindUnitsInRadius(
			DOTA_TEAM_GOODGUYS,
            location,
            nil,
            100,
            DOTA_UNIT_TARGET_TEAM_BOTH + DOTA_UNIT_TARGET_TEAM_NONE,
            DOTA_UNIT_TARGET_ALL,
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER,
            false)
		if #findUnits == 0 then
			unit = CreateUnitByName("frost_ward", location, false, nil, nil, DOTA_TEAM_NEUTRALS)
			unit:StartGestureWithPlaybackRate(ACT_DOTA_FLAIL, 0.5)
		end
	end
end

function SpawnBosses()
	local pointr = Entities:FindAllByName("spawnerino_red")
	for k,v in pairs(pointr) do				
		local location = v:GetAbsOrigin()
		local findUnits = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, location, nil, 3000, 
			DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER, false)
		local filtUnits = 0
		for i=1,#findUnits do
			if findUnits[i]:GetUnitName() == "greevil_red" then
				filtUnits = 1
			end
		end
		if filtUnits == 0 then
			unit = CreateUnitByName("greevil_red", location, false, nil, nil, DOTA_TEAM_NEUTRALS)
			unit.spawnPos = location
		end
	end
	
	local pointr = Entities:FindAllByName("spawnerino_orange")
	for k,v in pairs(pointr) do				
		local location = v:GetAbsOrigin()
		local findUnits = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, location, nil, 3000, 
			DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER, false)
		local filtUnits = 0
		for i=1,#findUnits do
			if findUnits[i]:GetUnitName() == "greevil_orange" then
				filtUnits = 1
			end
		end
		if filtUnits == 0 then
			unit = CreateUnitByName("greevil_orange", location, false, nil, nil, DOTA_TEAM_NEUTRALS)
			unit.spawnPos = location
		end
	end
	
	local pointr = Entities:FindAllByName("spawnerino_yellow")
	for k,v in pairs(pointr) do				
		local location = v:GetAbsOrigin()
		local findUnits = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, location, nil, 3000, 
			DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER, false)
		local filtUnits = 0
		for i=1,#findUnits do
			if findUnits[i]:GetUnitName() == "greevil_yellow" then
				filtUnits = 1
			end
		end
		if filtUnits == 0 then
			unit = CreateUnitByName("greevil_yellow", location, false, nil, nil, DOTA_TEAM_NEUTRALS)
			unit.spawnPos = location
		end
	end
	
	local pointr = Entities:FindAllByName("spawnerino_green")
	for k,v in pairs(pointr) do				
		local location = v:GetAbsOrigin()
		local findUnits = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, location, nil, 3000, 
			DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER, false)
		local filtUnits = 0
		for i=1,#findUnits do
			if findUnits[i]:GetUnitName() == "greevil_green" then
				filtUnits = 1
			end
		end
		if filtUnits == 0 then
			unit = CreateUnitByName("greevil_green", location, false, nil, nil, DOTA_TEAM_NEUTRALS)
			unit.spawnPos = location
		end
	end
	
	local pointr = Entities:FindAllByName("spawnerino_blue")
	for k,v in pairs(pointr) do				
		local location = v:GetAbsOrigin()
		local findUnits = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, location, nil, 3000, 
			DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER, false)
		local filtUnits = 0
		for i=1,#findUnits do
			if findUnits[i]:GetUnitName() == "greevil_blue" then
				filtUnits = 1
			end
		end
		if filtUnits == 0 then
			unit = CreateUnitByName("greevil_blue", location, false, nil, nil, DOTA_TEAM_NEUTRALS)
			unit.spawnPos = location
		end
	end
	
	local pointr = Entities:FindAllByName("spawnerino_purple")
	for k,v in pairs(pointr) do				
		local location = v:GetAbsOrigin()
		local findUnits = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, location, nil, 3000, 
			DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER, false)
		local filtUnits = 0
		for i=1,#findUnits do
			if findUnits[i]:GetUnitName() == "greevil_purple" then
				filtUnits = 1
			end
		end
		if filtUnits == 0 then
			unit = CreateUnitByName("greevil_purple", location, false, nil, nil, DOTA_TEAM_NEUTRALS)
			unit.spawnPos = location
		end
	end
	
	local pointr = Entities:FindAllByName("spawnerino_white")
	for k,v in pairs(pointr) do				
		local location = v:GetAbsOrigin()
		local findUnits = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, location, nil, 3000, 
			DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER, false)
		local filtUnits = 0
		for i=1,#findUnits do
			if findUnits[i]:GetUnitName() == "greevil_white" then
				filtUnits = 1
			end
		end
		if filtUnits == 0 then
			unit = CreateUnitByName("greevil_white", location, false, nil, nil, DOTA_TEAM_NEUTRALS)
			unit.spawnPos = location
		end
	end
	
	local pointr = Entities:FindAllByName("spawnerino_black")
	for k,v in pairs(pointr) do				
		local location = v:GetAbsOrigin()
		local findUnits = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, location, nil, 3000, 
			DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER, false)
		local filtUnits = 0
		for i=1,#findUnits do
			if findUnits[i]:GetUnitName() == "greevil_black" then
				filtUnits = 1
			end
		end
		if filtUnits == 0 then
			unit = CreateUnitByName("greevil_black", location, false, nil, nil, DOTA_TEAM_NEUTRALS)
			unit.spawnPos = location
		end
	end
end

function LevelGreevils()
	playerGreevils = FindUnitsInRadius(DOTA_TEAM_BADGUYS,
		Vector(0, 0, 0),
		nil,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false)
	for k,v in pairs(playerGreevils) do
		if v:GetUnitName() == "greevil_red_player" or
		v:GetUnitName() == "greevil_orange_player" or
		v:GetUnitName() == "greevil_yellow_player" or
		v:GetUnitName() == "greevil_green_player" or
		v:GetUnitName() == "greevil_blue_player" or
		v:GetUnitName() == "greevil_purple_player" or
		v:GetUnitName() == "greevil_white_player" or
		v:GetUnitName() == "greevil_black_player" then
			local currLvl = v:GetLevel()
			if currLvl < 6 then
				v:CreatureLevelUp(1)
			end
		end
	end
	--PrintTable(playerGreevils)
	--print(playerGreevils)
	--print(playerGreevils[0])
end

function SpawnCreeps()
	local pointr = Entities:FindAllByName("spawnerino_naked_dire")
	local pointd = Entities:FindAllByName("spawnerino_naked_rad")
	
	if count < 240 then		-- 0-4 mins
		x = 5
	elseif count < 480 then	-- 4-8 mins
		x = 6
	elseif count < 720 then	-- 8-12 mins
		x = 7
	elseif count < 960 then	-- 12-16 mins
		x = 8
	else					-- 16+ mins
		x = 10
	end

	for i=1,x do
		vr = pointr[i]
		vd = pointd[i]
		local locationr = vr:GetAbsOrigin()
		local locationd = vd:GetAbsOrigin()
		local unit = CreateUnitByName("greevil_naked_dire", locationr, false, nil, nil, DOTA_TEAM_BADGUYS)
		local unit = CreateUnitByName("greevil_naked_rad", locationd, false, nil, nil, DOTA_TEAM_GOODGUYS)
	end
end

function BossSpawn(colour, team)
	local data = {
		colour = colour,
		team = team,
	}
	CustomGameEventManager:Send_ServerToAllClients("BossSpawned", data)
end

function BossDie(colour, team)
	local data = {
		colour = colour,
		team = team,
	}
	CustomGameEventManager:Send_ServerToAllClients("BossDied", data)
end

function FindTeam(unit)
	local unit = unit
	if unit:GetAbsOrigin()[1] < 0 then
		return "radiant"
	else
		return "dire"
	end
end