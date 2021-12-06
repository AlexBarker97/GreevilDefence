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
require('libraries/selection')
require('libraries/filters')
require "math"

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
	-- PrecacheResource("particle", "particles/econ/generic/generic_aoe_explosion_sphere_1/generic_aoe_explosion_sphere_1.vpcf", context)
	-- PrecacheResource("particle_folder", "particles/test_particle", context)

	-- Models can also be precached by folder or individually
	-- PrecacheModel should generally used over PrecacheResource for individual models
	-- PrecacheResource("model_folder", "particles/heroes/antimage", context)
	-- PrecacheResource("model", "particles/heroes/viper/viper.vmdl", context)
	-- PrecacheModel("models/heroes/viper/viper.vmdl", context)

	-- Sounds can precached here like anything else
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_furion.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_ui_imported.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/voscripts/game_sounds_vo_siltbreaker.vsndevts", context)

	-- Entire items can be precached by name
	-- Abilities can also be precached in this way despite the name
	-- PrecacheItemByNameSync("example_ability", context)
	-- PrecacheItemByNameSync("item_example_item", context)

	-- Entire heroes (sound effects/voice/models/particles) can be precached with PrecacheUnitByNameSync
	-- Custom units from npc_units_custom.txt can also have all of their abilities and precache{} blocks precached in this way
	-- PrecacheUnitByNameSync("npc_dota_hero_ancient_apparition", context)
	-- PrecacheUnitByNameSync("npc_dota_hero_enigma", context)
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
	EntitySpawn()		--Listener for entity spawns
	EntityKilled()		--Listener for entities killed
	GameStart()			--Listener for game start (timers)
	SpawnInitialGreevils()
end

function EntitySpawn()
	ListenToGameEvent("npc_spawned", function(params)
		local unit = EntIndexToHScript(params.entindex)

		if unit:GetUnitName() == "npc_dota_hero_beastmaster" and unit:FindAbilityByName("red") ~= nil then

			local playerid = unit:GetPlayerID()

			unit:AddNewModifier(nil, nil, "modifier_greevil_naked", {})
			ability1 = unit:GetAbilityByIndex(0)
			ability2 = unit:GetAbilityByIndex(1)
			ability3 = unit:GetAbilityByIndex(2)
			ability4 = unit:GetAbilityByIndex(3)
			ability5 = unit:GetAbilityByIndex(4)
			ability6 = unit:GetAbilityByIndex(5)
			ability7 = unit:GetAbilityByIndex(6)
			ability8 = unit:GetAbilityByIndex(7)
			unit:UpgradeAbility(ability1)
			unit:UpgradeAbility(ability2)
			unit:UpgradeAbility(ability3)
			unit:UpgradeAbility(ability4)
			unit:UpgradeAbility(ability5)
			unit:UpgradeAbility(ability6)
			unit:UpgradeAbility(ability7)
			unit:UpgradeAbility(ability8)
			unit:SetAbilityPoints(1)
			
			Timers:CreateTimer({endTime = 0.5,
				callback = function()

				local origin = unit:GetAbsOrigin()
				if origin[1] <= 0 then -- radiant
					origin = (Vector(-6900, -7480, 384)) + (Vector(RandomInt(0,800),RandomInt(0,400), 0))
				else -- dire
					origin = (Vector(5788, -7480, 384)) + (Vector(RandomInt(0,800),RandomInt(0,400), 0))
				end
				unit:SetAbsOrigin(origin)
				
				PlayerResource:SetCameraTarget(playerid, unit)
				Timers:CreateTimer({endTime = 0.3,
					callback = function()
					PlayerResource:SetCameraTarget(playerid, nil)
				end})
			end})

		--RED NEUTRAL BOSS
		elseif unit:GetUnitName() == "greevil_red" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_red", {})
			unit:AddNewModifier(nil, nil, "modifier_greevil_boss_sres", {})
			unit:AddItemByName("item_boss_drop_red")
			local colour = "red"
			Timers:CreateTimer(0.01, function()
				local team = FindTeam(unit)
				BossSpawn(colour, team)
			end)
			BossSpawn(colour, team)
		elseif unit:GetUnitName() == "greevil_red_showcase" or unit:GetUnitName() == "greevil_white_red" or unit:GetUnitName() == "greevil_red_rad_att" or unit:GetUnitName() == "greevil_red_dire_att" or unit:GetUnitName() == "greevil_red_rad_def" or unit:GetUnitName() == "greevil_red_dire_def" or unit:GetUnitName() == "greevil_red_player" or unit:GetUnitName() == "greevil_red_boss_att" then
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
		elseif unit:GetUnitName() == "greevil_orange_showcase" or unit:GetUnitName() == "greevil_white_orange" or unit:GetUnitName() == "greevil_orange_rad_att" or unit:GetUnitName() == "greevil_orange_dire_att" or unit:GetUnitName() == "greevil_orange_rad_def" or unit:GetUnitName() == "greevil_orange_dire_def" or unit:GetUnitName() == "greevil_orange_player" or unit:GetUnitName() == "greevil_orange_boss_att" then
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
		elseif unit:GetUnitName() == "greevil_yellow_showcase" or unit:GetUnitName() == "greevil_white_yellow" or unit:GetUnitName() == "greevil_yellow_rad_att" or unit:GetUnitName() == "greevil_yellow_dire_att" or unit:GetUnitName() == "greevil_yellow_rad_def" or unit:GetUnitName() == "greevil_yellow_dire_def" or unit:GetUnitName() == "greevil_yellow_player" or unit:GetUnitName() == "greevil_yellow_boss_att" then
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
		elseif unit:GetUnitName() == "greevil_green_showcase" or unit:GetUnitName() == "greevil_white_green" or unit:GetUnitName() == "greevil_green_rad_att" or unit:GetUnitName() == "greevil_green_dire_att" or unit:GetUnitName() == "greevil_green_rad_def" or unit:GetUnitName() == "greevil_green_dire_def" or unit:GetUnitName() == "greevil_green_player" or unit:GetUnitName() == "greevil_green_boss_att" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_green", {})	
		elseif unit:GetUnitName() == "greevil_green_boss_att_2" or unit:GetUnitName() == "greevil_green_boss_att_3" then
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
		elseif unit:GetUnitName() == "greevil_blue_showcase" or unit:GetUnitName() == "greevil_white_blue" or unit:GetUnitName() == "greevil_blue_rad_att" or unit:GetUnitName() == "greevil_blue_dire_att" or unit:GetUnitName() == "greevil_blue_rad_def" or unit:GetUnitName() == "greevil_blue_dire_def" or unit:GetUnitName() == "greevil_blue_player" or unit:GetUnitName() == "greevil_blue_boss_att" then
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
		elseif unit:GetUnitName() == "greevil_purple_showcase" or unit:GetUnitName() == "greevil_white_purple" or unit:GetUnitName() == "greevil_purple_rad_att" or unit:GetUnitName() == "greevil_purple_dire_att" or unit:GetUnitName() == "greevil_purple_rad_def" or unit:GetUnitName() == "greevil_purple_dire_def" or unit:GetUnitName() == "greevil_purple_player" or unit:GetUnitName() == "greevil_purple_boss_att" then
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
		elseif unit:GetUnitName() == "greevil_white_showcase" or unit:GetUnitName() == "greevil_white_rad_att" or unit:GetUnitName() == "greevil_white_dire_att" or unit:GetUnitName() == "greevil_white_rad_def" or unit:GetUnitName() == "greevil_white_dire_def" or unit:GetUnitName() == "greevil_white_player" or unit:GetUnitName() == "greevil_white_boss_att" then
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
		elseif unit:GetUnitName() == "greevil_black_showcase" or unit:GetUnitName() == "greevil_black_rad_att" or unit:GetUnitName() == "greevil_black_dire_att" or unit:GetUnitName() == "greevil_black_rad_def" or unit:GetUnitName() == "greevil_black_dire_def" or unit:GetUnitName() == "greevil_black_player" or unit:GetUnitName() == "greevil_black_boss_att" then
			unit:AddNewModifier(nil, nil, "modifier_greevil_black", {})		
	
		elseif unit:GetUnitName() == "greevil_naked_dire" or unit:GetUnitName() == "greevil_naked_rad" then
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
				if (math.fmod(count,60) == 0) and (count >= 120) then
					SpawnBosses()
				end
				if math.fmod(count,30) == 0 then
					SpawnCreeps()
				end
				count = count + 1;
				
			return 1
			end)
		elseif GameRules:State_Get() == DOTA_GAMERULES_STATE_PRE_GAME then
			local radgate = CreateUnitByName("door", Vector(-3712, 1920, 128), false, nil, nil, DOTA_TEAM_NEUTRALS)
			local diregate = CreateUnitByName("door", Vector(3712, 1920, 128), false, nil, nil, DOTA_TEAM_NEUTRALS)
			radgate.disabled = 0
			diregate.disabled = 0
			local particle1 = ParticleManager:CreateParticle("particles/units/heroes/hero_arc_warden/arc_warden_flux_tgt.vpcf", PATTACH_ABSORIGIN_FOLLOW, radgate)
			local particle2 = ParticleManager:CreateParticle("particles/units/heroes/hero_arc_warden/arc_warden_flux_tgt.vpcf", PATTACH_ABSORIGIN_FOLLOW, diregate)
			local jump1 = CreateUnitByName("jump", Vector(-6950, 60, 280), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local jump2 = CreateUnitByName("jump", Vector(-5852, 60, 280), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local jump3 = CreateUnitByName("jump", Vector(5846, 60, 280), false, nil, nil, DOTA_TEAM_BADGUYS)
			local jump4 = CreateUnitByName("jump", Vector(6944, 60, 280), false, nil, nil, DOTA_TEAM_BADGUYS)
			jump1.disabled = 0
			jump2.disabled = 0
			jump3.disabled = 0
			jump4.disabled = 0
			local particle3 = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_earth_ambient_glow_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, jump1)
			local particle4 = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_earth_ambient_glow_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, jump2)
			local particle5 = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_earth_ambient_glow_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, jump3)
			local particle6 = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_earth_ambient_glow_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, jump4)
			jump1:AddNewModifier(nil, nil,"modifier_invulnerable", {})
			jump2:AddNewModifier(nil, nil,"modifier_invulnerable", {})
			jump3:AddNewModifier(nil, nil,"modifier_invulnerable", {})
			jump4:AddNewModifier(nil, nil,"modifier_invulnerable", {})
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
		unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, 100, 0))
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
			unit:FaceTowards(unit:GetAbsOrigin()+Vector(-100, 100, 0))
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
			unit:FaceTowards(unit:GetAbsOrigin()+Vector(100, -70, 0))
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
			unit:FaceTowards(unit:GetAbsOrigin()+Vector(30, 100, 0))
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
			unit:FaceTowards(unit:GetAbsOrigin()+Vector(100, 100, 0))
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
			local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_purifyingflames_heal_flame.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
			unit:FaceTowards(unit:GetAbsOrigin()+Vector(-100, 60, 0))
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
			unit:FaceTowards(unit:GetAbsOrigin()+Vector(-100, 60, 0))
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
			unit:FaceTowards(unit:GetAbsOrigin()+Vector(-100, 35, 0))
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
			local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_fairy/fairy_flight_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
			local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_keeper_of_the_light/keeper_dazzling_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
			
			unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, -100, 0))
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
			local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
			unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, -100, 0))
			unit.spawnPos = location
		end
	end
end

function SpawnCreeps()
	local PlayerCountOnRad = PlayerResource:GetPlayerCountForTeam(DOTA_TEAM_GOODGUYS)
	local PlayerCountOnDire = PlayerResource:GetPlayerCountForTeam(DOTA_TEAM_BADGUYS)
	local totalPlayerCount = PlayerCountOnRad + PlayerCountOnDire

	if math.fmod(totalPlayerCount,2) ~= 0 then
		adjPlayerCount = totalPlayerCount + 1
	end

	local waveType = RandomInt(1, 14)
	local waveType2 = RandomInt(1, 8)

	if count < 120 then		-- 0-1.5 mins 120
		x = adjPlayerCount + 2
		xC = adjPlayerCount - 1
		xC2 = 0
	elseif count < 240 then	-- 2-3.5 mins 240
		x = adjPlayerCount + 2
		xC = adjPlayerCount
		xC2 = 0
	elseif count < 480 then	-- 4-7.5 mins 480
		x = adjPlayerCount + 3
		xC = adjPlayerCount
		xC2 = 0
	elseif count < 720 then	-- 8-11.5 mins 720
		x = adjPlayerCount + 4
		xC = adjPlayerCount - 1
		xC2 = adjPlayerCount - 1
	elseif count < 960 then	-- 12-15.5 mins 960
		x = adjPlayerCount + 5
		xC = adjPlayerCount
		xC2 = adjPlayerCount - 1
	else					-- 16+ mins
		x = adjPlayerCount + 6
		xC = adjPlayerCount
		xC2 = adjPlayerCount
	end

	if waveType <= 6 then
		for i=1,x do
			location = (Vector(-6828, 5400, 304)) + (Vector(RandomInt(0, 1000),RandomInt(0, 400), 0))
			local unit = CreateUnitByName("greevil_naked_dire", location, true, nil, nil, DOTA_TEAM_BADGUYS)
			unit:FaceTowards(unit:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))

			location = (Vector(5972, 5400, 304)) + (Vector(RandomInt(0, 1000),RandomInt(0, 400), 0))
			local unit = CreateUnitByName("greevil_naked_rad", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
			unit:FaceTowards(unit:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
		end
	else
		for i=1,xC do
			locationBAD = (Vector(-6828, 5400, 304)) + (Vector(RandomInt(0, 1000),RandomInt(0, 400), 0))
			locationGOOD = (Vector(5972, 5400, 304)) + (Vector(RandomInt(0, 1000),RandomInt(0, 400), 0))
			if waveType == 7 then
				local unitBAD = CreateUnitByName("greevil_red_dire_att", locationBAD, true, nil, nil, DOTA_TEAM_BADGUYS)
				local unitGOOD = CreateUnitByName("greevil_red_rad_att", locationGOOD, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unitBAD:FaceTowards(unitBAD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitGOOD:FaceTowards(unitGOOD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitBAD.lane = 1
				unitGOOD.lane = 1
			elseif waveType == 8 then
				local unitBAD = CreateUnitByName("greevil_orange_dire_att", locationBAD, true, nil, nil, DOTA_TEAM_BADGUYS)
				local unitGOOD = CreateUnitByName("greevil_orange_rad_att", locationGOOD, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unitBAD:FaceTowards(unitBAD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitGOOD:FaceTowards(unitGOOD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitBAD.lane = 1
				unitGOOD.lane = 1
			elseif waveType == 9 then
				local unitBAD = CreateUnitByName("greevil_yellow_dire_att", locationBAD, true, nil, nil, DOTA_TEAM_BADGUYS)
				local unitGOOD = CreateUnitByName("greevil_yellow_rad_att", locationGOOD, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unitBAD:FaceTowards(unitBAD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitGOOD:FaceTowards(unitGOOD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitBAD.lane = 1
				unitGOOD.lane = 1
			elseif waveType == 10 then
				local unitBAD = CreateUnitByName("greevil_green_dire_att", locationBAD, true, nil, nil, DOTA_TEAM_BADGUYS)
				local unitGOOD = CreateUnitByName("greevil_green_rad_att", locationGOOD, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unitBAD:FaceTowards(unitBAD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitGOOD:FaceTowards(unitGOOD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitBAD.lane = 1
				unitGOOD.lane = 1
			elseif waveType == 11 then
				local unitBAD = CreateUnitByName("greevil_blue_dire_att", locationBAD, true, nil, nil, DOTA_TEAM_BADGUYS)
				local unitGOOD = CreateUnitByName("greevil_blue_rad_att", locationGOOD, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unitBAD:FaceTowards(unitBAD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitGOOD:FaceTowards(unitGOOD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitBAD.lane = 1
				unitGOOD.lane = 1
			elseif waveType == 12 then
				local unitBAD = CreateUnitByName("greevil_purple_dire_att", locationBAD, true, nil, nil, DOTA_TEAM_BADGUYS)
				local unitGOOD = CreateUnitByName("greevil_purple_rad_att", locationGOOD, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unitBAD:FaceTowards(unitBAD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitGOOD:FaceTowards(unitGOOD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitBAD.lane = 1
				unitGOOD.lane = 1
			elseif waveType == 13 then
				local unitBAD = CreateUnitByName("greevil_white_dire_att", locationBAD, true, nil, nil, DOTA_TEAM_BADGUYS)
				local unitGOOD = CreateUnitByName("greevil_white_rad_att", locationGOOD, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unitBAD:FaceTowards(unitBAD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitGOOD:FaceTowards(unitGOOD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitBAD.lane = 1
				unitGOOD.lane = 1
			elseif waveType == 14 then
				local unitBAD = CreateUnitByName("greevil_black_dire_att", locationBAD, true, nil, nil, DOTA_TEAM_BADGUYS)
				local unitGOOD = CreateUnitByName("greevil_black_rad_att", locationGOOD, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unitBAD:FaceTowards(unitBAD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitGOOD:FaceTowards(unitGOOD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitBAD.lane = 1
				unitGOOD.lane = 1
			end
		end
		for i=1,xC2 do
			locationBAD = (Vector(-6828, 5400, 304)) + (Vector(RandomInt(0, 1000),RandomInt(0, 400), 0))
			locationGOOD = (Vector(5972, 5400, 304)) + (Vector(RandomInt(0, 1000),RandomInt(0, 400), 0))
			if waveType2 == 1 then
				local unitBAD = CreateUnitByName("greevil_red_dire_att", locationBAD, true, nil, nil, DOTA_TEAM_BADGUYS)
				local unitGOOD = CreateUnitByName("greevil_red_rad_att", locationGOOD, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unitBAD:FaceTowards(unitBAD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitGOOD:FaceTowards(unitGOOD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitBAD.lane = 1
				unitGOOD.lane = 1
			elseif waveType2 == 2 then
				local unitBAD = CreateUnitByName("greevil_orange_dire_att", locationBAD, true, nil, nil, DOTA_TEAM_BADGUYS)
				local unitGOOD = CreateUnitByName("greevil_orange_rad_att", locationGOOD, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unitBAD:FaceTowards(unitBAD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitGOOD:FaceTowards(unitGOOD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitBAD.lane = 1
				unitGOOD.lane = 1
			elseif waveType2 == 3 then
				local unitBAD = CreateUnitByName("greevil_yellow_dire_att", locationBAD, true, nil, nil, DOTA_TEAM_BADGUYS)
				local unitGOOD = CreateUnitByName("greevil_yellow_rad_att", locationGOOD, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unitBAD:FaceTowards(unitBAD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitGOOD:FaceTowards(unitGOOD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitBAD.lane = 1
				unitGOOD.lane = 1
			elseif waveType2 == 4 then
				local unitBAD = CreateUnitByName("greevil_green_dire_att", locationBAD, true, nil, nil, DOTA_TEAM_BADGUYS)
				local unitGOOD = CreateUnitByName("greevil_green_rad_att", locationGOOD, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unitBAD:FaceTowards(unitBAD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitGOOD:FaceTowards(unitGOOD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitBAD.lane = 1
				unitGOOD.lane = 1
			elseif waveType2 == 5 then
				local unitBAD = CreateUnitByName("greevil_blue_dire_att", locationBAD, true, nil, nil, DOTA_TEAM_BADGUYS)
				local unitGOOD = CreateUnitByName("greevil_blue_rad_att", locationGOOD, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unitBAD:FaceTowards(unitBAD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitGOOD:FaceTowards(unitGOOD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitBAD.lane = 1
				unitGOOD.lane = 1
			elseif waveType2 == 6 then
				local unitBAD = CreateUnitByName("greevil_purple_dire_att", locationBAD, true, nil, nil, DOTA_TEAM_BADGUYS)
				local unitGOOD = CreateUnitByName("greevil_purple_rad_att", locationGOOD, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unitBAD:FaceTowards(unitBAD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitGOOD:FaceTowards(unitGOOD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitBAD.lane = 1
				unitGOOD.lane = 1
			elseif waveType2 == 7 then
				local unitBAD = CreateUnitByName("greevil_white_dire_att", locationBAD, true, nil, nil, DOTA_TEAM_BADGUYS)
				local unitGOOD = CreateUnitByName("greevil_white_rad_att", locationGOOD, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unitBAD:FaceTowards(unitBAD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitGOOD:FaceTowards(unitGOOD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitBAD.lane = 1
				unitGOOD.lane = 1
			elseif waveType2 == 8 then
				local unitBAD = CreateUnitByName("greevil_black_dire_att", locationBAD, true, nil, nil, DOTA_TEAM_BADGUYS)
				local unitGOOD = CreateUnitByName("greevil_black_rad_att", locationGOOD, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unitBAD:FaceTowards(unitBAD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitGOOD:FaceTowards(unitGOOD:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
				unitBAD.lane = 1
				unitGOOD.lane = 1
			end
		end
	end
end

function SpawnInitialGreevils()
	local pointred = Entities:FindAllByName("spawnexample_red_r")
	for k,v in pairs(pointred) do
		local location = v:GetAbsOrigin()
		local unit = CreateUnitByName("greevil_red_showcase", location, false, nil, nil, DOTA_TEAM_GOODGUYS)
		unit:FaceTowards(unit:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
	end
	local pointorange = Entities:FindAllByName("spawnexample_orange_r")
	for k,v in pairs(pointorange) do
		local location = v:GetAbsOrigin()
		local unit = CreateUnitByName("greevil_orange_showcase", location, false, nil, nil, DOTA_TEAM_GOODGUYS)
		unit:FaceTowards(unit:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
	end
	local pointyellow = Entities:FindAllByName("spawnexample_yellow_r")
	for k,v in pairs(pointyellow) do
		local location = v:GetAbsOrigin()
		local unit = CreateUnitByName("greevil_yellow_showcase", location, false, nil, nil, DOTA_TEAM_GOODGUYS)
		unit:FaceTowards(unit:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
	end
	local pointgreen = Entities:FindAllByName("spawnexample_green_r")
	for k,v in pairs(pointgreen) do
		local location = v:GetAbsOrigin()
		local unit = CreateUnitByName("greevil_green_showcase", location, false, nil, nil, DOTA_TEAM_GOODGUYS)
		unit:FaceTowards(unit:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
	end
	local pointblue = Entities:FindAllByName("spawnexample_blue_r")
	for k,v in pairs(pointblue) do
		local location = v:GetAbsOrigin()
		local unit = CreateUnitByName("greevil_blue_showcase", location, false, nil, nil, DOTA_TEAM_GOODGUYS)
		unit:FaceTowards(unit:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
	end
	local pointpurple = Entities:FindAllByName("spawnexample_purple_r")
	for k,v in pairs(pointpurple) do
		local location = v:GetAbsOrigin()
		local unit = CreateUnitByName("greevil_purple_showcase", location, false, nil, nil, DOTA_TEAM_GOODGUYS)
		unit:FaceTowards(unit:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
	end
	local pointwhite = Entities:FindAllByName("spawnexample_white_r")
	for k,v in pairs(pointwhite) do
		local location = v:GetAbsOrigin()
		local unit = CreateUnitByName("greevil_white_showcase", location, false, nil, nil, DOTA_TEAM_GOODGUYS)
		unit:FaceTowards(unit:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
	end
	local pointblack = Entities:FindAllByName("spawnexample_black_r")
	for k,v in pairs(pointblack) do
		local location = v:GetAbsOrigin()
		local unit = CreateUnitByName("greevil_black_showcase", location, false, nil, nil, DOTA_TEAM_GOODGUYS)
		unit:FaceTowards(unit:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
	end

	local pointred = Entities:FindAllByName("spawnexample_red_d")
	for k,v in pairs(pointred) do
		local location = v:GetAbsOrigin()
		local unit = CreateUnitByName("greevil_red_showcase", location, false, nil, nil, DOTA_TEAM_BADGUYS)
		unit:FaceTowards(unit:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
	end
	local pointorange = Entities:FindAllByName("spawnexample_orange_d")
	for k,v in pairs(pointorange) do
		local location = v:GetAbsOrigin()
		local unit = CreateUnitByName("greevil_orange_showcase", location, false, nil, nil, DOTA_TEAM_BADGUYS)
		unit:FaceTowards(unit:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
	end
	local pointyellow = Entities:FindAllByName("spawnexample_yellow_d")
	for k,v in pairs(pointyellow) do
		local location = v:GetAbsOrigin()
		local unit = CreateUnitByName("greevil_yellow_showcase", location, false, nil, nil, DOTA_TEAM_BADGUYS)
		unit:FaceTowards(unit:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
	end
	local pointgreen = Entities:FindAllByName("spawnexample_green_d")
	for k,v in pairs(pointgreen) do
		local location = v:GetAbsOrigin()
		local unit = CreateUnitByName("greevil_green_showcase", location, false, nil, nil, DOTA_TEAM_BADGUYS)
		unit:FaceTowards(unit:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
	end
	local pointblue = Entities:FindAllByName("spawnexample_blue_d")
	for k,v in pairs(pointblue) do
		local location = v:GetAbsOrigin()
		local unit = CreateUnitByName("greevil_blue_showcase", location, false, nil, nil, DOTA_TEAM_BADGUYS)
		unit:FaceTowards(unit:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
	end
	local pointpurple = Entities:FindAllByName("spawnexample_purple_d")
	for k,v in pairs(pointpurple) do
		local location = v:GetAbsOrigin()
		local unit = CreateUnitByName("greevil_purple_showcase", location, false, nil, nil, DOTA_TEAM_BADGUYS)
		unit:FaceTowards(unit:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
	end
	local pointwhite = Entities:FindAllByName("spawnexample_white_d")
	for k,v in pairs(pointwhite) do
		local location = v:GetAbsOrigin()
		local unit = CreateUnitByName("greevil_white_showcase", location, false, nil, nil, DOTA_TEAM_BADGUYS)
		unit:FaceTowards(unit:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
	end
	local pointblack = Entities:FindAllByName("spawnexample_black_d")
	for k,v in pairs(pointblack) do
		local location = v:GetAbsOrigin()
		local unit = CreateUnitByName("greevil_black_showcase", location, false, nil, nil, DOTA_TEAM_BADGUYS)
		unit:FaceTowards(unit:GetAbsOrigin()+Vector(0 + math.random(-30,40), -100, 0))
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