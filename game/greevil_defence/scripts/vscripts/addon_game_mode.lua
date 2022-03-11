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
LinkLuaModifier( "lifeline_lua", "modifiers/lifeline_lua", LUA_MODIFIER_MOTION_NONE )

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
	print("Performing pre-load precache")
	-- NOTE: IT IS RECOMMENDED TO USE A MINIMAL AMOUNT OF LUA PRECACHING, AND A MAXIMAL AMOUNT OF DATADRIVEN PRECACHING.
	-- Precaching guide: https://moddota.com/forums/discussion/119/precache-fixing-and-avoiding-issues

	-- Particles can be precached individually or by folder
	-- It it likely that precaching a single particle system will precache all of its children, but this may not be guaranteed
	-- PrecacheResource("particle", "particles/econ/generic/generic_aoe_explosion_sphere_1/generic_aoe_explosion_sphere_1.vpcf", context)
	-- PrecacheResource("particle_folder", "particles/test_particle", context)
	-- Models can also be precached by folder or individually
	-- PrecacheModel should generally used over PrecacheResource for individual models
	-- PrecacheResource("model_folder", "particles/heroes/antimage", context)
	-- PrecacheResource("model", "particles/heroes/viper/viper.vmdl", context)
	-- PrecacheModel("models/heroes/viper/viper.vmdl", context)
	-- Entire items can be precached by name
	-- Abilities can also be precached in this way despite the name
	-- PrecacheItemByNameSync("example_ability", context)
	-- PrecacheItemByNameSync("item_example_item", context)
	-- Entire heroes (sound effects/voice/models/particles) can be precached with PrecacheUnitByNameSync
	-- Custom units from npc_units_custom.txt can also have all of their abilities and precache{} blocks precached in this way
	-- PrecacheUnitByNameSync("npc_dota_hero_ancient_apparition", context)
	-- Sounds can precached here like anything else

	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_furion.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_ui_imported.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/voscripts/game_sounds_vo_siltbreaker.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_greevils.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_cny.vsndevts", context)
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
	GameStart()			--Listener for game start (timers)
	SpawnInitialGreevils()
end

function GameStart()
	ListenToGameEvent("game_rules_state_change", function(params)
		if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		
			local pointr = Entities:FindAllByName("spawnerino_boss")
			for k,v in pairs(pointr) do
				local location = v:GetAbsOrigin()
				local unit = CreateUnitByName("greevil_boss", location, false, nil, nil, DOTA_TEAM_NEUTRALS)
			end		
			
			SpawnDefenders()

			count = 0;
			Timers:CreateTimer(0, function()

				if count == 5 then
					SpawnBot()
				end

				if math.fmod(count,5) == 0 then
					SpawnFrostWard()
				end

				if (math.fmod(count,600) == 0) and (count > 1) then
					SpawnGiftSnatchers()
						EmitGlobalSound("greevil_loot_spawn_Stinger")
						EmitGlobalSound("soundboard.sleighbells")
				end

				if math.fmod(count,60) == 0 then
					if count == 0 then
						EmitGlobalSound("mars_takeover_stinger")
					end
					if count >= 120 then
						SpawnSmallBosses()
						if count == 120 then
							EmitGlobalSound("RoshanDT.Scream")
							EmitGlobalSound("RoshanDT.TakeoverScream.Layer")
						end
					end
					if count >= 240 then
						SpawnWhiteBosses()
						if count == 240 then
							EmitGlobalSound("earthshaker_takeover_stinger")
							EmitGlobalSound("RoshanDT.Scream")
							EmitGlobalSound("RoshanDT.TakeoverScream.Layer")
						end
					end
					if count >= 360 then
						SpawnBlackBoss()
						if count == 360 then
							EmitGlobalSound("void_spirit_debut_takeover_stinger")
							EmitGlobalSound("underlord_debut_takeover_stinger")
							EmitGlobalSound("RoshanDT.Scream")
							EmitGlobalSound("RoshanDT.TakeoverScream.Layer")
						end
					end
				end

				if (math.fmod(count,30) == 0) and ((math.fmod(count,600) ~= 0) or (count == 0)) then
					SpawnCreeps(count,"both")
				end

				count = count + 1;
			return 1
			end)
		elseif GameRules:State_Get() == DOTA_GAMERULES_STATE_PRE_GAME then
			local radgate = CreateUnitByName("door", Vector(-3712, 1920, 128), false, nil, nil, DOTA_TEAM_NEUTRALS)
			local diregate = CreateUnitByName("door", Vector(3712, 1920, 128), false, nil, nil, DOTA_TEAM_NEUTRALS)
			radgate:AddNewModifier(nil, nil,"modifier_hidden_nodamage", {})
			radgate:AddNewModifier(nil, nil,"modifier_magic_immune", {})
			diregate:AddNewModifier(nil, nil,"modifier_hidden_nodamage", {})
			diregate:AddNewModifier(nil, nil,"modifier_magic_immune", {})
			radgate.disabled = 0
			diregate.disabled = 0
			local particle1 = ParticleManager:CreateParticle("particles/units/heroes/hero_arc_warden/arc_warden_flux_tgt.vpcf", PATTACH_ABSORIGIN_FOLLOW, radgate)
			local particle2 = ParticleManager:CreateParticle("particles/units/heroes/hero_arc_warden/arc_warden_flux_tgt.vpcf", PATTACH_ABSORIGIN_FOLLOW, diregate)
			local jump1 = CreateUnitByName("jump", Vector(-6950, 60, 280), false, nil, nil, DOTA_TEAM_BADGUYS)
			local jump2 = CreateUnitByName("jump", Vector(-5852, 60, 280), false, nil, nil, DOTA_TEAM_BADGUYS)
			local jump3 = CreateUnitByName("jump", Vector(5846, 60, 280), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local jump4 = CreateUnitByName("jump", Vector(6944, 60, 280), false, nil, nil, DOTA_TEAM_GOODGUYS)
			jump1.disabled = 0
			jump2.disabled = 0
			jump3.disabled = 0
			jump4.disabled = 0
			local particle3 = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_earth_ambient_glow_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, jump1)
			local particle4 = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_earth_ambient_glow_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, jump2)
			local particle5 = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_earth_ambient_glow_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, jump3)
			local particle6 = ParticleManager:CreateParticle("particles/units/heroes/hero_brewmaster/brewmaster_earth_ambient_glow_b.vpcf", PATTACH_ABSORIGIN_FOLLOW, jump4)
			jump1:AddNewModifier(nil, nil,"modifier_hidden_nodamage", {})
			jump1:AddNewModifier(nil, nil,"modifier_magic_immune", {})
			jump2:AddNewModifier(nil, nil,"modifier_hidden_nodamage", {})
			jump2:AddNewModifier(nil, nil,"modifier_magic_immune", {})
			jump3:AddNewModifier(nil, nil,"modifier_hidden_nodamage", {})
			jump3:AddNewModifier(nil, nil,"modifier_magic_immune", {})
			jump4:AddNewModifier(nil, nil,"modifier_hidden_nodamage", {})
			jump4:AddNewModifier(nil, nil,"modifier_magic_immune", {})

			local radvision1 = CreateUnitByName("vision", Vector(-12000, 6500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision2 = CreateUnitByName("vision", Vector(-8000, 6500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision3 = CreateUnitByName("vision", Vector(-4000, 6500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision4 = CreateUnitByName("vision", Vector(0, 6500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision5 = CreateUnitByName("vision", Vector(4000, 6500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision6 = CreateUnitByName("vision", Vector(8000, 6500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision7 = CreateUnitByName("vision", Vector(12000, 6500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision8 = CreateUnitByName("vision", Vector(-12000, 1500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision9 = CreateUnitByName("vision", Vector(-8000, 1500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision10 = CreateUnitByName("vision", Vector(-4000, 1500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision11 = CreateUnitByName("vision", Vector(0, 1500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision12 = CreateUnitByName("vision", Vector(4000, 1500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision13 = CreateUnitByName("vision", Vector(8000, 1500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision14 = CreateUnitByName("vision", Vector(12000, 1500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision15 = CreateUnitByName("vision", Vector(-12000, -4500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision16 = CreateUnitByName("vision", Vector(-8000, -4500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision17 = CreateUnitByName("vision", Vector(-4000, -4500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision18 = CreateUnitByName("vision", Vector(0, -4500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision19 = CreateUnitByName("vision", Vector(4000, -4500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision20 = CreateUnitByName("vision", Vector(8000, -4500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)
			local radvision21 = CreateUnitByName("vision", Vector(12000, -4500, 128), false, nil, nil, DOTA_TEAM_GOODGUYS)

			local direvision1 = CreateUnitByName("vision", Vector(-12000, 6500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision2 = CreateUnitByName("vision", Vector(-8000, 6500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision3 = CreateUnitByName("vision", Vector(-4000, 6500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision4 = CreateUnitByName("vision", Vector(0, 6500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision5 = CreateUnitByName("vision", Vector(4000, 6500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision6 = CreateUnitByName("vision", Vector(8000, 6500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision7 = CreateUnitByName("vision", Vector(12000, 6500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision8 = CreateUnitByName("vision", Vector(-12000, 1500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision9 = CreateUnitByName("vision", Vector(-8000, 1500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision10 = CreateUnitByName("vision", Vector(-4000, 1500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision11 = CreateUnitByName("vision", Vector(0, 1500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision12 = CreateUnitByName("vision", Vector(4000, 1500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision13 = CreateUnitByName("vision", Vector(8000, 1500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision14 = CreateUnitByName("vision", Vector(12000, 1500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision15 = CreateUnitByName("vision", Vector(-12000, -4500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision16 = CreateUnitByName("vision", Vector(-8000, -4500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision17 = CreateUnitByName("vision", Vector(-4000, -4500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision18 = CreateUnitByName("vision", Vector(0, -4500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision19 = CreateUnitByName("vision", Vector(4000, -4500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision20 = CreateUnitByName("vision", Vector(8000, -4500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)
			local direvision21 = CreateUnitByName("vision", Vector(12000, -4500, 128), false, nil, nil, DOTA_TEAM_BADGUYS)

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
