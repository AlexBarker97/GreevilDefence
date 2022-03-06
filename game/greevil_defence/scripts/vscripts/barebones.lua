print ('barebones.lua' )
require('customability/whiteboss')
require('libraries/util')

-- GameRules Variables
ENABLE_HERO_RESPAWN = true             -- Should the heroes automatically respawn on a timer or stay dead until manually respawned
MAX_RESPAWN_TIME = 300
USE_CUSTOM_RESPAWN_TIME = true
CUSTOM_RESPAWN_TIME = 90
UNIVERSAL_SHOP_MODE = true				-- Should the main shop contain Secret Shop items as well as regular items
ALLOW_SAME_HERO_SELECTION = true        -- Should we let people select the same hero as each other

HERO_SELECTION_TIME = 0					-- How long should we let people select their hero?
PRE_GAME_TIME = 25.0					-- How long after people select their heroes should the horn blow and the game start?
POST_GAME_TIME = 25.0                   -- How long should we let people look at the scoreboard before closing the server automatically?
TREE_REGROW_TIME = 1.0					-- How long should it take individual trees to respawn after being cut down/destroyed?

GOLD_PER_TICK = 0						-- How much gold should players get per tick?
GOLD_TICK_TIME = 1                      -- How long should we wait in seconds between gold ticks?

RECOMMENDED_BUILDS_DISABLED = true		-- Should we disable the recommened builds for heroes (Note: this is not working currently I believe)
CAMERA_DISTANCE_OVERRIDE = 1500.0       -- How far out should we allow the camera to go?  1134 is the default in Dota

MINIMAP_ICON_SIZE = 1                   -- What icon size should we use for our heroes?
MINIMAP_CREEP_ICON_SIZE = 2             -- What icon size should we use for creeps?
MINIMAP_RUNE_ICON_SIZE = 1              -- What icon size should we use for runes?

RUNE_SPAWN_TIME = 120                   -- How long in seconds should we wait between rune spawns?
CUSTOM_BUYBACK_COST_ENABLED = true      -- Should we use a custom buyback cost setting?
BUYBACK_FIXED_GOLD_COST = 500
CUSTOM_BUYBACK_COOLDOWN_ENABLED = true  -- Should we use a custom buyback time?
CUSTOM_BUYBACK_COOLDOWN_TIME = 60
BUYBACK_ENABLED = true					-- Should we allow people to buyback when they die?

DISABLE_FOG_OF_WAR_ENTIRELY = false		-- Should we disable fog of war entirely for both teams?
USE_STANDARD_HERO_GOLD_BOUNTY = true    -- Should we give gold for hero kills the same as in Dota, or allow those values to be changed?

USE_CUSTOM_TOP_BAR_VALUES = false       -- Should we do customized top bar values or use the default kill count per team?
TOP_BAR_VISIBLE = true                  -- Should we display the top bar score/count at all?
SHOW_KILLS_ON_TOPBAR = true             -- Should we display kills only on the top bar? (No denies, suicides, kills by neutrals)  Requires USE_CUSTOM_TOP_BAR_VALUES

ENABLE_TOWER_BACKDOOR_PROTECTION = false-- Should we enable backdoor protection for our towers?
REMOVE_ILLUSIONS_ON_DEATH = false       -- Should we remove all illusions if the main hero dies?
DISABLE_GOLD_SOUNDS = false             -- Should we disable the gold sound when players get gold?

END_GAME_ON_KILLS = false               -- Should the game end after a certain number of kills?
KILLS_TO_END_GAME_FOR_TEAM = 5			-- How many kills for a team should signify an end of game?

USE_CUSTOM_HERO_LEVELS = true           -- Should we allow heroes to have custom levels?
MAX_LEVEL = 30                          -- What level should we let heroes get to?
USE_CUSTOM_XP_VALUES = true             -- Should we use custom XP values to level up heroes, or the default Dota numbers?

DISABLE_STASH_PURCHASING = true
ENABLE_STASH = false
ENABLE_SEND_TO_STASH = false

-- Fill this table up with the required XP per level if you want to change it
XP_PER_LEVEL_TABLE = {}
XP_PER_LEVEL_TABLE = {
		0,		200,	400,	600,	800,
		1200,	1600,	2000,	2400,	2800,	3200,
		3800,	4500,	5300,	6100,	6900,	7700,
		8700,	10000,
		12000,	14000,	16000,	18000,	20000,	22000,	24000,	26000,	28000,	30000,	32000
		}
--for i=1,MAX_LEVEL do
--	XP_PER_LEVEL_TABLE[i] = i * 250
--end
--DeepPrintTable(XP_PER_LEVEL_TABLE)

-- Generated from template
if GameMode == nil then
	_G.GameMode = class({})
end

-- Defence Greevil Existence Tracker
local DefenceGreevil = {}
DefenceGreevil.Radiant = {}
DefenceGreevil.Dire = {}
DefenceGreevil.Radiant.Red = 0
DefenceGreevil.Radiant.Orange = 0
DefenceGreevil.Radiant.Yellow = 0
DefenceGreevil.Radiant.Green = 0
DefenceGreevil.Radiant.Blue = 0
DefenceGreevil.Radiant.Purple = 0
DefenceGreevil.Radiant.White = 0
DefenceGreevil.Radiant.Black = 0
DefenceGreevil.Dire.Red = 0
DefenceGreevil.Dire.Orange = 0
DefenceGreevil.Dire.Yellow = 0
DefenceGreevil.Dire.Green = 0
DefenceGreevil.Dire.Blue = 0
DefenceGreevil.Dire.Purple = 0
DefenceGreevil.Dire.White = 0
DefenceGreevil.Dire.Black = 0

local AttackGreevil = {}
AttackGreevil.Radiant = {}
AttackGreevil.Dire = {}
AttackGreevil.Radiant.Red = 0
AttackGreevil.Radiant.Orange = 0
AttackGreevil.Radiant.Yellow = 0
AttackGreevil.Radiant.Green = 0
AttackGreevil.Radiant.Blue = 0
AttackGreevil.Radiant.Purple = 0
AttackGreevil.Radiant.White = 0
AttackGreevil.Radiant.Black = 0
AttackGreevil.Dire.Red = 0
AttackGreevil.Dire.Orange = 0
AttackGreevil.Dire.Yellow = 0
AttackGreevil.Dire.Green = 0
AttackGreevil.Dire.Blue = 0
AttackGreevil.Dire.Purple = 0
AttackGreevil.Dire.White = 0
AttackGreevil.Dire.Black = 0

-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function GameMode:InitGameMode()
	GameMode = self
	print('Starting to load Barebones gamemode...')

	-- Setup rules
	GameRules:SetHeroRespawnEnabled( ENABLE_HERO_RESPAWN )
	GameRules:SetUseUniversalShopMode( UNIVERSAL_SHOP_MODE )
	GameRules:SetSameHeroSelectionEnabled( ALLOW_SAME_HERO_SELECTION )
	GameRules:SetHeroSelectionTime( HERO_SELECTION_TIME )
	GameRules:SetPreGameTime( PRE_GAME_TIME)
	GameRules:SetPostGameTime( POST_GAME_TIME )
	GameRules:SetTreeRegrowTime( TREE_REGROW_TIME )
	GameRules:SetUseCustomHeroXPValues ( USE_CUSTOM_XP_VALUES )
	GameRules:SetGoldPerTick(GOLD_PER_TICK)
	GameRules:SetGoldTickTime(GOLD_TICK_TIME)
	GameRules:SetRuneSpawnTime(RUNE_SPAWN_TIME)
	GameRules:SetUseBaseGoldBountyOnHeroes(USE_STANDARD_HERO_GOLD_BOUNTY)
	GameRules:SetHeroMinimapIconScale( MINIMAP_ICON_SIZE )
	GameRules:SetCreepMinimapIconScale( MINIMAP_CREEP_ICON_SIZE )
	GameRules:SetRuneMinimapIconScale( MINIMAP_RUNE_ICON_SIZE )
	GameRules:GetGameModeEntity():SetCustomGameForceHero("npc_dota_hero_beastmaster")
	print('GameRules set')

	-- Listeners - Event Hooks
	-- All of these events can potentially be fired by the game, though only the uncommented ones have had
	-- Functions supplied for them.
	ListenToGameEvent('dota_player_gained_level', Dynamic_Wrap(GameMode, 'OnPlayerLevelUp'), self)
	ListenToGameEvent('dota_ability_channel_finished', Dynamic_Wrap(GameMode, 'OnAbilityChannelFinished'), self)
	ListenToGameEvent('dota_player_learned_ability', Dynamic_Wrap(GameMode, 'OnPlayerLearnedAbility'), self)
	ListenToGameEvent('entity_killed', Dynamic_Wrap(GameMode, 'OnEntityKilled'), self)
	ListenToGameEvent('player_connect_full', Dynamic_Wrap(GameMode, 'OnConnectFull'), self)
	ListenToGameEvent('player_disconnect', Dynamic_Wrap(GameMode, 'OnDisconnect'), self)
	ListenToGameEvent('dota_item_purchased', Dynamic_Wrap(GameMode, 'OnItemPurchased'), self)
	ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(GameMode, 'OnItemPickedUp'), self)
	ListenToGameEvent('last_hit', Dynamic_Wrap(GameMode, 'OnLastHit'), self)
	ListenToGameEvent('dota_non_player_used_ability', Dynamic_Wrap(GameMode, 'OnNonPlayerUsedAbility'), self)
	ListenToGameEvent('player_changename', Dynamic_Wrap(GameMode, 'OnPlayerChangedName'), self)
	ListenToGameEvent('dota_rune_activated_server', Dynamic_Wrap(GameMode, 'OnRuneActivated'), self)
	ListenToGameEvent('dota_player_take_tower_damage', Dynamic_Wrap(GameMode, 'OnPlayerTakeTowerDamage'), self)
	ListenToGameEvent('tree_cut', Dynamic_Wrap(GameMode, 'OnTreeCut'), self)
	ListenToGameEvent('entity_hurt', Dynamic_Wrap(GameMode, 'OnEntityHurt'), self)
	ListenToGameEvent('player_connect', Dynamic_Wrap(GameMode, 'PlayerConnect'), self)
	ListenToGameEvent('dota_player_used_ability', Dynamic_Wrap(GameMode, 'OnAbilityUsed'), self)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(GameMode, 'OnGameRulesStateChange'), self)
	ListenToGameEvent('npc_spawned', Dynamic_Wrap(GameMode, 'OnNPCSpawned'), self)
	ListenToGameEvent('dota_player_pick_hero', Dynamic_Wrap(GameMode, 'OnPlayerPickHero'), self)
	ListenToGameEvent('dota_team_kill_credit', Dynamic_Wrap(GameMode, 'OnTeamKillCredit'), self)
	ListenToGameEvent("player_reconnected", Dynamic_Wrap(GameMode, 'OnPlayerReconnect'), self)
	ListenToGameEvent("dota_hud_error_message", Dynamic_Wrap(GameMode, 'On_dota_hud_error_message'), self)

	local gamemode = GameRules:GetGameModeEntity()
	gamemode:SetExecuteOrderFilter(Dynamic_Wrap(GameMode, "OrderFilter"), self)
	gamemode:SetDamageFilter(Dynamic_Wrap(GameMode, "DamageFilter"), self)
	gamemode:SetModifierGainedFilter(Dynamic_Wrap(GameMode, "ModifierFilter"), self)
	gamemode:SetModifyExperienceFilter(Dynamic_Wrap(GameMode, "ExperienceFilter"), self)
	gamemode:SetTrackingProjectileFilter(Dynamic_Wrap(GameMode, "ProjectileFilter"), self)
	gamemode:SetRuneSpawnFilter(Dynamic_Wrap(GameMode, "RuneSpawnFilter"), self)
	gamemode:SetBountyRunePickupFilter(Dynamic_Wrap(GameMode, "BountyRuneFilter"), self)
	gamemode:SetHealingFilter(Dynamic_Wrap(GameMode, "HealingFilter"), self)
	gamemode:SetModifyGoldFilter(Dynamic_Wrap(GameMode, "GoldFilter"), self)
	--gamemode:SetItemAddedToInventoryFilter(Dynamic_Wrap(GameMode, "InventoryFilter"), self)

	-- Change random seed
	local timeTxt = string.gsub(string.gsub(GetSystemTime(), ':', ''), '0','')
	math.randomseed(tonumber(timeTxt))

	-- Initialized tables for tracking state
	self.vUserIds = {}
	self.vSteamIds = {}
	self.vBots = {}
	self.vBroadcasters = {}

	self.vPlayers = {}
	self.vRadiant = {}
	self.vDire = {}

	self.nRadiantKills = 0
	self.nDireKills = 0

	self.bSeenWaitForPlayers = false

	-- Commands can be registered for debugging purposes or as functions that can be called by the custom Scaleform UI
	Convars:RegisterCommand( "command_example", Dynamic_Wrap(GameMode, 'ExampleConsoleCommand'), "A console command example", 0 )

	print('Done loading Barebones gamemode!\n\n')
end

mode = nil

-- This function is called 1 to 2 times as the player connects initially but before they
-- have completely connected
function GameMode:PlayerConnect(keys)
	--DeepPrintTable(keys)

	if keys.bot == 1 then
		-- This user is a Bot, so add it to the bots table
		self.vBots[keys.userid] = 1
	end
end

-- This function is called once when the player fully connects and becomes "Ready" during Loading
function GameMode:OnConnectFull(keys)

end

-- This function is called as the first player loads and sets up the GameMode parameters
function GameMode:CaptureGameMode()
	if mode == nil then
		-- Set GameMode parameters
		mode = GameRules:GetGameModeEntity()
		mode:SetRecommendedItemsDisabled( RECOMMENDED_BUILDS_DISABLED )
		mode:SetCameraDistanceOverride( CAMERA_DISTANCE_OVERRIDE )
		mode:SetCustomBuybackCostEnabled( CUSTOM_BUYBACK_COST_ENABLED )
		mode:SetCustomBuybackCooldownEnabled( CUSTOM_BUYBACK_COOLDOWN_ENABLED )
		mode:SetBuybackEnabled( BUYBACK_ENABLED )
		mode:SetTopBarTeamValuesOverride ( USE_CUSTOM_TOP_BAR_VALUES )
		mode:SetTopBarTeamValuesVisible( TOP_BAR_VISIBLE )
		mode:SetUseCustomHeroLevels ( USE_CUSTOM_HERO_LEVELS )
		mode:SetCustomHeroMaxLevel ( MAX_LEVEL )
		mode:SetCustomXPRequiredToReachNextLevel( XP_PER_LEVEL_TABLE )

		--mode:SetBotThinkingEnabled( USE_STANDARD_DOTA_BOT_THINKING )
		mode:SetTowerBackdoorProtectionEnabled( ENABLE_TOWER_BACKDOOR_PROTECTION )

		mode:SetFogOfWarDisabled(DISABLE_FOG_OF_WAR_ENTIRELY)
		mode:SetGoldSoundDisabled( DISABLE_GOLD_SOUNDS )
		mode:SetRemoveIllusionsOnDeath( REMOVE_ILLUSIONS_ON_DEATH )

		self:OnFirstPlayerLoaded()
	end
end

-- This is an example console command
function GameMode:ExampleConsoleCommand()
	print( '******* Example Console Command ***************' )
	local cmdPlayer = Convars:GetCommandClient()
	if cmdPlayer then
		local playerID = cmdPlayer:GetPlayerID()
		if playerID ~= nil and playerID ~= -1 then
			-- Do something here for the player who called this command
			PlayerResource:ReplaceHeroWith(playerID, "npc_dota_hero_viper", 1000, 1000)
		end
	end
	print( '*********************************************' )
end

--[[
  This function should be used to set up Async precache calls at the beginning of the game.  The Precache() function 
  in addon_game_mode.lua used to and may still sometimes have issues with client's appropriately precaching stuff.
  If this occurs it causes the client to never precache things configured in that block.

  In this function, place all of your PrecacheItemByNameAsync and PrecacheUnitByNameAsync.  These calls will be made
  after all players have loaded in, but before they have selected their heroes. PrecacheItemByNameAsync can also
  be used to precache dynamically-added datadriven abilities instead of items.  PrecacheUnitByNameAsync will 
  precache the precache{} block statement of the unit and all precache{} block statements for every Ability# 
  defined on the unit.

  This function should only be called once.  If you want to/need to precache more items/abilities/units at a later
  time, you can call the functions individually (for example if you want to precache units in a new wave of
  holdout).
]]
function GameMode:PostLoadPrecache()
	print("Performing Post-Load precache")

end

--[[
  This function is called once and only once as soon as the first player (almost certain to be the server in local lobbies) loads in.
  It can be used to initialize state that isn't initializeable in InitGameMode() but needs to be done before everyone loads in.
]]
function GameMode:OnFirstPlayerLoaded()
end

--[[
  This function is called once and only once after all players have loaded into the game, right as the hero selection time begins.
  It can be used to initialize non-hero player state or adjust the hero selection (i.e. force random etc)
]]
function GameMode:OnAllPlayersLoaded()
end

--[[
  This function is called once and only once for every player when they spawn into the game for the first time.  It is also called
  if the player's hero is replaced with a new hero for any reason.  This function is useful for initializing heroes, such as adding
  levels, changing the starting gold, removing/adding abilities, adding physics, etc.

  The hero parameter is the hero entity that just spawned in.
]]
function GameMode:OnFirstTimeHeroInGame(hero)

	-- Store a reference to the player handle inside this hero handle.
	hero.player = PlayerResource:GetPlayer(hero:GetPlayerID())
	-- Store the player's name inside this hero handle.
	hero.playerName = PlayerResource:GetPlayerName(hero:GetPlayerID())
	-- Store this hero handle in this table.
	table.insert(self.vPlayers, hero)

	-- This line for example will set the starting gold of every hero to 500 unreliable gold
	hero:SetGold(0, false)

	local satchel = CreateItem("item_satchel_custom", nil, nil)
	satchel:SetPurchaseTime(0)
	hero:AddItem(satchel)
end

function GameMode:OnGameInProgress()
	print("The game has officially begun")
end

-- Cleanup a player when they leave
function GameMode:OnDisconnect(keys)
	print('Player Disconnected ' .. tostring(keys.userid))
	--DeepPrintTable(keys)

	local name = keys.name
	local networkid = keys.networkid
	local reason = keys.reason
	local userid = keys.userid
end

-- The overall game state has changed
function GameMode:OnGameRulesStateChange(keys)
	print("GameRules State Changed")
	--DeepPrintTable(keys)

	local newState = GameRules:State_Get()
	if newState == DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD then
		self.bSeenWaitForPlayers = true
	elseif newState == DOTA_GAMERULES_STATE_INIT then
		Timers:RemoveTimer("alljointimer")
	elseif newState == DOTA_GAMERULES_STATE_HERO_SELECTION then
		local et = 6
		if self.bSeenWaitForPlayers then
			et = .01
		end
		Timers:CreateTimer("alljointimer", {
			useGameTime = true,
			endTime = et,
			callback = function()
				if PlayerResource:HaveAllPlayersJoined() then
					GameMode:PostLoadPrecache()
					GameMode:OnAllPlayersLoaded()
					return
				end
				return 1
			end})
	elseif newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		GameMode:OnGameInProgress()
		Convars:SetInt('dota_max_physical_items_purchase_limit', 9999)
	end
end

-- An NPC has spawned somewhere in game.  This includes heroes
function GameMode:OnNPCSpawned(keys)
	--print("NPC Spawned")
	--DeepPrintTable(keys)
	local npc = EntIndexToHScript(keys.entindex)

	if npc:IsRealHero() then

		if npc.bFirstSpawned == nil then
			npc.bFirstSpawned = true
			GameMode:OnFirstTimeHeroInGame(npc)
		end
	end

end

-- An entity somewhere has been hurt.  This event fires very often with many units so don't do too many expensive
-- operations here
function GameMode:OnEntityHurt(keys)
	--print("Entity Hurt")
	--DeepPrintTable(keys)
	local entCause = EntIndexToHScript(keys.entindex_attacker)
	local entVictim = EntIndexToHScript(keys.entindex_killed)
end

-- An item was picked up off the ground
function GameMode:OnItemPickedUp(keys)
	--DeepPrintTable(keys)

	if keys.HeroEntityIndex == nil then
		local unitEntity = EntIndexToHScript(keys.UnitEntityIndex)
	else
		local unitEntity = EntIndexToHScript(keys.HeroEntityIndex)
	end
	local player = PlayerResource:GetPlayer(keys.PlayerID)
	local itemname = keys.itemname
	if itemname == "item_present" or itemname == "item_greater_present" then
		EmitSoundOnLocationWithCaster(player:GetAbsOrigin(), "greevil_receive_present_Stinger", player)
	end
end

-- A player has reconnected to the game.  This function can be used to repaint Player-based particles or change
-- state as necessary
function GameMode:OnPlayerReconnect(keys)
	print ( 'OnPlayerReconnect' )
	--DeepPrintTable(keys)
end

-- An item was purchased by a player
function GameMode:OnItemPurchased(keys)
	--DeepPrintTable(keys)

	local playerID = keys.PlayerID
	local item_name = keys.itemname
	local item_cost = keys.itemcost
	local purchaseEntity = PlayerResource:GetSelectedHeroEntity(playerID)
	local team = purchaseEntity:GetTeam()
	if not playerID then
		return
	end

	if item_name == "item_upgrade_att" then
		if team == 2 then
			local radUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, Vector(0, 0, 0), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
				DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			for k,v in pairs(radUnits) do
				if radUnits[k]:GetUnitName() == "greevil_spawner_red" or radUnits[k]:GetUnitName() == "greevil_spawner_orange" 
						or radUnits[k]:GetUnitName() == "greevil_spawner_yellow" or radUnits[k]:GetUnitName() == "greevil_spawner_green" 
						or radUnits[k]:GetUnitName() == "greevil_spawner_blue" or radUnits[k]:GetUnitName() == "greevil_spawner_purple" 
						or radUnits[k]:GetUnitName() == "greevil_spawner_white" or radUnits[k]:GetUnitName() == "greevil_spawner_black" then
					radUnits[k]:CreatureLevelUp(1)
				end
			end
		else
			local direUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, Vector(0, 0, 0), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
				DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			for k,v in pairs(direUnits) do
				if direUnits[k]:GetUnitName() == "greevil_spawner_red" or direUnits[k]:GetUnitName() == "greevil_spawner_orange" 
						or direUnits[k]:GetUnitName() == "greevil_spawner_yellow" or direUnits[k]:GetUnitName() == "greevil_spawner_green" 
						or direUnits[k]:GetUnitName() == "greevil_spawner_blue" or direUnits[k]:GetUnitName() == "greevil_spawner_purple" 
						or direUnits[k]:GetUnitName() == "greevil_spawner_white" or direUnits[k]:GetUnitName() == "greevil_spawner_black" then
					direUnits[k]:CreatureLevelUp(1)
				end
			end
		end				
		removeItem(purchaseEntity,"item_upgrade_att")
		
	elseif item_name == "item_upgrade_def" then
		if team == 2 then
			local radUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, Vector(0, 0, 0), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
				DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			for k,v in pairs(radUnits) do
				if radUnits[k]:GetUnitName() == "greevil_red_rad_def" or radUnits[k]:GetUnitName() == "greevil_orange_rad_def" 
						or radUnits[k]:GetUnitName() == "greevil_yellow_rad_def" or radUnits[k]:GetUnitName() == "greevil_green_rad_def" 
						or radUnits[k]:GetUnitName() == "greevil_blue_rad_def" or radUnits[k]:GetUnitName() == "greevil_purple_rad_def" 
						or radUnits[k]:GetUnitName() == "greevil_white_rad_def" or radUnits[k]:GetUnitName() == "greevil_black_rad_def" then
					radUnits[k]:CreatureLevelUp(1)
				end
			end
		else
			local direUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, Vector(0, 0, 0), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, 
				DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			for k,v in pairs(direUnits) do
				if direUnits[k]:GetUnitName() == "greevil_red_dire_def" or direUnits[k]:GetUnitName() == "greevil_orange_dire_def" 
						or direUnits[k]:GetUnitName() == "greevil_yellow_dire_def" or direUnits[k]:GetUnitName() == "greevil_green_dire_def" 
						or direUnits[k]:GetUnitName() == "greevil_blue_dire_def" or direUnits[k]:GetUnitName() == "greevil_purple_dire_def" 
						or direUnits[k]:GetUnitName() == "greevil_white_dire_def" or direUnits[k]:GetUnitName() == "greevil_black_dire_def" then
					direUnits[k]:CreatureLevelUp(1)
				end
			end
		end
		removeItem(purchaseEntity,"item_upgrade_def")
	
	elseif item_name == "item_voidling" then
		if team == 2 then
			local unit = CreateUnitByName("rex", Vector(6400, 5760, 256), true, nil, nil, DOTA_TEAM_GOODGUYS)
		else
			local unit = CreateUnitByName("rex", Vector(-6400, 5760, 256), true, nil, nil, DOTA_TEAM_BADGUYS)
		end
		removeItem(purchaseEntity,"item_voidling")
	

	elseif item_name == "item_red_egg_att" then
		if PlayerResource:GetTeam(playerID) == 2 then

			if AttackGreevil.Radiant.Red == 0 then
				location = Vector(6880, 5760, 256)
				local unit = CreateUnitByName("greevil_spawner_red", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, RandomInt(-110, -90), 0))
				AttackGreevil.Radiant.Red = 1
			elseif AttackGreevil.Radiant.Red == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_red_att"})
			end
		else
			if AttackGreevil.Dire.Red == 0 then
				location = Vector(-6880, 5760, 256)
				local unit = CreateUnitByName("greevil_spawner_red", location, true, nil, nil, DOTA_TEAM_BADGUYS)
				unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, RandomInt(-110, -90), 0))
				AttackGreevil.Dire.Red = 1
			elseif AttackGreevil.Dire.Red == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_red_att"})
			end
		end
		removeItem(purchaseEntity,"item_red_egg_att")

	elseif item_name == "item_orange_egg_att" then
		if PlayerResource:GetTeam(playerID) == 2 then
			if AttackGreevil.Radiant.Orange == 0 then
				location = Vector(6560, 5760, 256)
				local unit = CreateUnitByName("greevil_spawner_orange", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, RandomInt(-110, -90), 0))
				AttackGreevil.Radiant.Orange = 1
			elseif AttackGreevil.Radiant.Orange == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_orange_att"})
			end
		else
			if AttackGreevil.Dire.Orange == 0 then
				location = Vector(-6560, 5760, 256)
				local unit = CreateUnitByName("greevil_spawner_orange", location, true, nil, nil, DOTA_TEAM_BADGUYS)
				unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, RandomInt(-110, -90), 0))
				AttackGreevil.Dire.Orange = 1
			elseif AttackGreevil.Dire.Orange == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_orange_att"})
			end
		end
		removeItem(purchaseEntity,"item_orange_egg_att")

	elseif item_name == "item_yellow_egg_att" then
		if PlayerResource:GetTeam(playerID) == 2 then
			if AttackGreevil.Radiant.Yellow == 0 then
				location = Vector(6240, 5760, 256)
				local unit = CreateUnitByName("greevil_spawner_yellow", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, RandomInt(-110, -90), 0))
				AttackGreevil.Radiant.Yellow = 1
			elseif AttackGreevil.Radiant.Yellow == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_yellow_att"})
			end
		else
			if AttackGreevil.Dire.Yellow == 0 then
				location = Vector(-6240, 5760, 256)
				local unit = CreateUnitByName("greevil_spawner_yellow", location, true, nil, nil, DOTA_TEAM_BADGUYS)
				unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, RandomInt(-110, -90), 0))
				AttackGreevil.Dire.Yellow = 1
			elseif AttackGreevil.Dire.Yellow == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_yellow_att"})
			end
		end
		removeItem(purchaseEntity,"item_yellow_egg_att")

	elseif item_name == "item_green_egg_att" then
		if PlayerResource:GetTeam(playerID) == 2 then
			if AttackGreevil.Radiant.Green == 0 then
				location = Vector(5920, 5760, 256)
				local unit = CreateUnitByName("greevil_spawner_green", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, RandomInt(-110, -90), 0))
				AttackGreevil.Radiant.Green = 1
			elseif AttackGreevil.Radiant.Green == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_green_att"})
			end
		else
			if AttackGreevil.Dire.Green == 0 then
				location = Vector(-5920, 5760, 256)
				local unit = CreateUnitByName("greevil_spawner_green", location, true, nil, nil, DOTA_TEAM_BADGUYS)
				unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, RandomInt(-110, -90), 0))
				AttackGreevil.Dire.Green = 1
			elseif AttackGreevil.Dire.Green == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_green_att"})
			end
		end
		removeItem(purchaseEntity,"item_green_egg_att")

	elseif item_name == "item_blue_egg_att" then
		if PlayerResource:GetTeam(playerID) == 2 then
			if AttackGreevil.Radiant.Blue == 0 then
				location = Vector(6880, 6016, 256)
				local unit = CreateUnitByName("greevil_spawner_blue", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, RandomInt(-110, -90), 0))
				AttackGreevil.Radiant.Blue = 1
			elseif AttackGreevil.Radiant.Blue == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_blue_att"})
			end
		else
			if AttackGreevil.Dire.Blue == 0 then
				location = Vector(-6880, 6016, 256)
				local unit = CreateUnitByName("greevil_spawner_blue", location, true, nil, nil, DOTA_TEAM_BADGUYS)
				unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, RandomInt(-110, -90), 0))
				AttackGreevil.Dire.Blue = 1
			elseif AttackGreevil.Dire.Blue == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_blue_att"})
			end
		end
		removeItem(purchaseEntity,"item_blue_egg_att")

	elseif item_name == "item_purple_egg_att" then
		if PlayerResource:GetTeam(playerID) == 2 then
			if AttackGreevil.Radiant.Purple == 0 then
				location = Vector(6560, 6016, 256)
				local unit = CreateUnitByName("greevil_spawner_purple", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, RandomInt(-110, -90), 0))
				AttackGreevil.Radiant.Purple = 1
			elseif AttackGreevil.Radiant.Purple == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_purple_att"})
			end
		else
			if AttackGreevil.Dire.Purple == 0 then
				location = Vector(-6560, 6016, 256)
				local unit = CreateUnitByName("greevil_spawner_purple", location, true, nil, nil, DOTA_TEAM_BADGUYS)
				unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, RandomInt(-110, -90), 0))
				AttackGreevil.Dire.Purple = 1
			elseif AttackGreevil.Dire.Purple == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_purple_att"})
			end
		end
		removeItem(purchaseEntity,"item_purple_egg_att")

	elseif item_name == "item_white_egg_att" then
		if PlayerResource:GetTeam(playerID) == 2 then
			if AttackGreevil.Radiant.White == 0 then
				location = Vector(6240, 6016, 256)
				local unit = CreateUnitByName("greevil_spawner_white", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, RandomInt(-110, -90), 0))
				AttackGreevil.Radiant.White = 1
			elseif AttackGreevil.Radiant.White == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_white_att"})
			end
		else
			if AttackGreevil.Dire.White == 0 then
				location = Vector(-6240, 6016, 256)
				local unit = CreateUnitByName("greevil_spawner_white", location, true, nil, nil, DOTA_TEAM_BADGUYS)
				unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, RandomInt(-110, -90), 0))
				AttackGreevil.Dire.White = 1
			elseif AttackGreevil.Dire.White == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_white_att"})
			end
		end
		removeItem(purchaseEntity,"item_white_egg_att")

	elseif item_name == "item_black_egg_att" then
		if PlayerResource:GetTeam(playerID) == 2 then
			if AttackGreevil.Radiant.Black == 0 then
				location = Vector(5920, 6016, 256)
				local unit = CreateUnitByName("greevil_spawner_black", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
				unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, RandomInt(-110, -90), 0))
				AttackGreevil.Radiant.Black = 1
			elseif AttackGreevil.Radiant.Black == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_black_att"})
			end
		else
			if AttackGreevil.Dire.Black == 0 then
				location = Vector(-5920, 6016, 256)
				local unit = CreateUnitByName("greevil_spawner_black", location, true, nil, nil, DOTA_TEAM_BADGUYS)
				unit:FaceTowards(unit:GetAbsOrigin()+Vector(0, RandomInt(-110, -90), 0))
				AttackGreevil.Dire.Black = 1
			elseif AttackGreevil.Dire.Black == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_black_att"})
			end
		end
		removeItem(purchaseEntity,"item_black_egg_att")

	elseif item_name == "item_blue_egg_def" then
		if PlayerResource:GetTeam(playerID) == 2 then
			if DefenceGreevil.Radiant.Blue == 0 then
				location = (Vector(-6928, -4000, 304)) + (Vector(RandomInt(0,1056),RandomInt(0,944), 0))
				local unit = CreateUnitByName("greevil_blue_rad_def", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
				DefenceGreevil.Radiant.Blue = 1
			elseif DefenceGreevil.Radiant.Blue == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_blue_def"})
			end
		else
			if DefenceGreevil.Dire.Blue == 0 then
				location = (Vector(5872, -4000, 304)) + (Vector(RandomInt(0,1056),RandomInt(0,944), 0))
				local unit = CreateUnitByName("greevil_blue_dire_def", location, true, nil, nil, DOTA_TEAM_BADGUYS)
				DefenceGreevil.Dire.Blue = 1
			elseif DefenceGreevil.Dire.Blue == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_blue_def"})
			end
		end
		removeItem(purchaseEntity,"item_blue_egg_def")

	elseif item_name == "item_green_egg_def" then
		if PlayerResource:GetTeam(playerID) == 2 then
			if DefenceGreevil.Radiant.Green == 0 then
				location = (Vector(-6928, -4000, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				local unit = CreateUnitByName("greevil_green_rad_def", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
			DefenceGreevil.Radiant.Green = 1
			elseif DefenceGreevil.Radiant.Green == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_green_def"})
			end
		else
			if DefenceGreevil.Dire.Green == 0 then
				location = (Vector(5872, -4000, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				local unit = CreateUnitByName("greevil_green_dire_def", location, true, nil, nil, DOTA_TEAM_BADGUYS)
			DefenceGreevil.Dire.Green = 1
			elseif DefenceGreevil.Dire.Green == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_green_def"})
			end
		end
		removeItem(purchaseEntity,"item_green_egg_def")

	elseif item_name == "item_yellow_egg_def" then
		if PlayerResource:GetTeam(playerID) == 2 then
			if DefenceGreevil.Radiant.Yellow == 0 then
				location = (Vector(-6928, -4000, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				local unit = CreateUnitByName("greevil_yellow_rad_def", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
			DefenceGreevil.Radiant.Yellow = 1
			elseif DefenceGreevil.Radiant.Yellow == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_yellow_def"})
			end
		else
			if DefenceGreevil.Dire.Yellow == 0 then
				location = (Vector(5872, -4000, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				local unit = CreateUnitByName("greevil_yellow_dire_def", location, true, nil, nil, DOTA_TEAM_BADGUYS)
			DefenceGreevil.Dire.Yellow = 1
			elseif DefenceGreevil.Dire.Yellow == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_yellow_def"})
			end
		end
		removeItem(purchaseEntity,"item_yellow_egg_def")

	elseif item_name == "item_orange_egg_def" then
		if PlayerResource:GetTeam(playerID) == 2 then
			if DefenceGreevil.Radiant.Orange == 0 then
				location = (Vector(-6928, -4000, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				local unit = CreateUnitByName("greevil_orange_rad_def", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
			DefenceGreevil.Radiant.Orange = 1
			elseif DefenceGreevil.Radiant.Orange == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_orange_def"})
			end
		else
			if DefenceGreevil.Dire.Orange == 0 then
				location = (Vector(5872, -4000, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				local unit = CreateUnitByName("greevil_orange_dire_def", location, true, nil, nil, DOTA_TEAM_BADGUYS)
			DefenceGreevil.Dire.Orange = 1
			elseif DefenceGreevil.Dire.Orange == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_orange_def"})
			end
		end
		removeItem(purchaseEntity,"item_orange_egg_def")

	elseif item_name == "item_red_egg_def" then
		if PlayerResource:GetTeam(playerID) == 2 then
			if DefenceGreevil.Radiant.Red == 0 then
				location = (Vector(-6928, -4000, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				local unit = CreateUnitByName("greevil_red_rad_def", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
			DefenceGreevil.Radiant.Red = 1
			elseif DefenceGreevil.Radiant.Red == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_red_def"})
			end
		else
			if DefenceGreevil.Dire.Red == 0 then
				location = (Vector(5872, -4000, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				local unit = CreateUnitByName("greevil_red_dire_def", location, true, nil, nil, DOTA_TEAM_BADGUYS)
			DefenceGreevil.Dire.Red = 1
			elseif DefenceGreevil.Dire.Red == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_red_def"})
			end
		end
		removeItem(purchaseEntity,"item_red_egg_def")

	elseif item_name == "item_purple_egg_def" then
		if PlayerResource:GetTeam(playerID) == 2 then
			if DefenceGreevil.Radiant.Purple == 0 then
				location = (Vector(-6928, -4000, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				local unit = CreateUnitByName("greevil_purple_rad_def", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
			DefenceGreevil.Radiant.Purple = 1
			elseif DefenceGreevil.Radiant.Purple == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_purple_def"})
			end
		else
			if DefenceGreevil.Dire.Purple == 0 then
				location = (Vector(5872, -4000, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				local unit = CreateUnitByName("greevil_purple_dire_def", location, true, nil, nil, DOTA_TEAM_BADGUYS)
			DefenceGreevil.Dire.Purple = 1
			elseif DefenceGreevil.Dire.Purple == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_purple_def"})
			end
		end
		removeItem(purchaseEntity,"item_purple_egg_def")

	elseif item_name == "item_black_egg_def" then
		if PlayerResource:GetTeam(playerID) == 2 then
			if DefenceGreevil.Radiant.Black == 0 then
				location = (Vector(-6928, -4000, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				local unit = CreateUnitByName("greevil_black_rad_def", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
			DefenceGreevil.Radiant.Black = 1
			elseif DefenceGreevil.Radiant.Black == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_black_def"})
			end
		else
			if DefenceGreevil.Dire.Black == 0 then
				location = (Vector(5872, -4000, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				local unit = CreateUnitByName("greevil_black_dire_def", location, true, nil, nil, DOTA_TEAM_BADGUYS)
			DefenceGreevil.Dire.Black = 1
			elseif DefenceGreevil.Dire.Black == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_black_def"})
			end
		end
		removeItem(purchaseEntity,"item_black_egg_def")

	elseif item_name == "item_white_egg_def" then
		if PlayerResource:GetTeam(playerID) == 2 then
			if DefenceGreevil.Radiant.White == 0 then
				location = (Vector(-6928, -4000, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				local unit = CreateUnitByName("greevil_white_rad_def", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
			DefenceGreevil.Radiant.White = 1
			elseif DefenceGreevil.Radiant.White == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_white_def"})
			end
		else
			if DefenceGreevil.Dire.White == 0 then
				location = (Vector(5872, -4000, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				local unit = CreateUnitByName("greevil_white_dire_def", location, true, nil, nil, DOTA_TEAM_BADGUYS)
			DefenceGreevil.Dire.White = 1
			elseif DefenceGreevil.Dire.White == 1 then
				purchaseEntity:ModifyGold(item_cost,false,0)
				CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(playerID), "custom_dota_hud_error_message", {reason=80 , message= "#error_max_white_def"})
			end
		end
		removeItem(purchaseEntity,"item_white_egg_def")

	end
end

-- An ability was used by a player
function GameMode:OnAbilityUsed(keys)
	local ply = PlayerResource:GetPlayer(keys.PlayerID or keys.player)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local abilityname = keys.abilityname

	--if abilityname == "greevil_surge_custom" then
	--	local ab = caster:FindAbilityByName('greevil_surge_custom')
	--	local charges = ab:GetCurrentCharges()
	--	ab:SetCurrentCharges(charges-1)
	--end

	if abilityname == "greevil_brain_sap_custom" then
		local currMana = caster:GetMana()
		caster:SetMana(currMana + 50)
	end

    if ply then
        local hero = ply:GetAssignedHero()
        if hero then
            -- Check if they have multicast
            local mab = hero:FindAbilityByName('greevil_multicast_custom')

            if mab then
                -- Grab the level of the ability
                local lvl = mab:GetLevel()

                -- If they have no level in it, stop
                if lvl > 0 then
                    -- How many times we will cast the spell
                    local mult = 0

                    -- Grab a random number
                    local r = RandomFloat(0, 1)

                    if lvl == 1 then
                        if r > 0.5 then
                            mult = 2
                        end
                    elseif lvl == 2 then
                        if r > 0.6 then
                            mult = 3
                        elseif r < 0.4 then
                            mult = 2
                        end
                    elseif lvl == 3 then
                        if r > 0.8 then
                            mult = 4
                        elseif r > 0.5 then
                            mult = 3
                        elseif r > 0.2 then
                            mult = 2
                        end
                    end

                    -- Are we doing any multicasting?
                    if mult > 0 then
                        local ab = hero:FindAbilityByName(keys.abilityname)

                        if ab then
                            -- How long to delay each cast
                            local delay = 0.4

                            -- Grab playerID
                            local playerID = hero:GetPlayerID()

                            -- Grab the position
                            local pos = hero:GetCursorPosition()
                            local target = hero:GetCursorCastTarget()
                            local isaTargetSpell = false

                            -- Table to store multi units
                            local multUnits

                            local targets
                            if target and util:isTargetSpell(keys.abilityname) then
                                isaTargetSpell = true

                                targets = FindUnitsInRadius(target:GetTeam(),
                                    target:GetOrigin(),
                                    nil,
                                    256,
                                    DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                                    DOTA_UNIT_TARGET_ALL,
                                    DOTA_UNIT_TARGET_FLAG_NONE,
                                    FIND_ANY_ORDER,
                                    false
                                )
                            end

                            Timers:CreateTimer({endTime = 0.4,
								callback = function()
                                if IsValidEntity(ab) then
                                    hero:SetCursorPosition(pos)

                                    local ourTarget = target

                                    local doneTarget = false
                                    if targets then
                                        while #targets > 0 do
                                            local index = math.random(#targets)
                                            local t = targets[index]

                                            if IsValidEntity(t) and t:GetHealth() > 0 and t ~= ourTarget and isValidTargetEntity(t) then
                                                ourTarget = t
                                                doneTarget = true
                                                break
                                            else
                                                table.remove(targets, index)
                                            end
                                        end
                                    end

                                    if isaTargetSpell then
                                        if IsValidEntity(ourTarget) and ourTarget:GetHealth() > 0 then
                                            hero:SetCursorCastTarget(ourTarget)
                                        else
                                            return
                                        end
                                    end

                                    ab:OnSpellStart()

                                    mult = mult-1
                                    if mult > 1 then
											
                                        return delay
                                    end
                                end
                            end}, DoUniqueString('multicast'), delay)

                            -- Create sexy particles
                            local prt = ParticleManager:CreateParticle('particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf', PATTACH_OVERHEAD_FOLLOW, hero)
                            ParticleManager:SetParticleControl(prt, 1, Vector(mult, 0, 0))
                            ParticleManager:ReleaseParticleIndex(prt)

                            prt = ParticleManager:CreateParticle('particles/units/heroes/hero_ogre_magi/ogre_magi_multicast_b.vpcf', PATTACH_OVERHEAD_FOLLOW, hero:GetCursorCastTarget() or hero)
                            prt = ParticleManager:CreateParticle('particles/units/heroes/hero_ogre_magi/ogre_magi_multicast_b.vpcf', PATTACH_OVERHEAD_FOLLOW, hero)
                            ParticleManager:ReleaseParticleIndex(prt)

                            prt = ParticleManager:CreateParticle('particles/units/heroes/hero_ogre_magi/ogre_magi_multicast_c.vpcf', PATTACH_OVERHEAD_FOLLOW, hero:GetCursorCastTarget() or hero)
                            ParticleManager:SetParticleControl(prt, 1, Vector(mult, 0, 0))
                            ParticleManager:ReleaseParticleIndex(prt)

                            -- Play the sound
                            hero:EmitSound('Hero_OgreMagi.Fireblast.x'..(mult-1))
                        end
                    end
                end
            end
            
        end
    end

end

-- A non-player entity (necro-book, chen creep, etc) used an ability
function GameMode:OnNonPlayerUsedAbility(keys)
	--DeepPrintTable(keys)

	local caster = EntIndexToHScript(keys.caster_entindex)
	local abilityname = keys.abilityname

	if abilityname == "greevil_white_overwhelming_odds" then
		whiteboss:OOds(caster)
	elseif abilityname == "greevil_white_light_strike_array" then
		whiteboss:LSA(caster)
	elseif abilityname == "greevil_white_echo_slam" then
		whiteboss:ESlam(caster)
	elseif abilityname == "greevil_white_ravage" then
		whiteboss:Rav(caster)
	elseif abilityname == "greevil_white_frostbite" then
		whiteboss:FBite(caster)
	elseif abilityname == "greevil_white_vacuum" then
		whiteboss:Vac(caster)
	elseif abilityname == "greevil_white_will_o_wisp" then
		whiteboss:WoW(caster)
	end
end

-- A player changed their name
function GameMode:OnPlayerChangedName(keys)
	--DeepPrintTable(keys)

	local newName = keys.newname
	local oldName = keys.oldName
end

-- A player leveled up an ability
function GameMode:OnPlayerLearnedAbility( keys)
	--DeepPrintTable(keys)

	local player = EntIndexToHScript(keys.player)
	local abilityname = keys.abilityname
end

-- A channelled ability finished by either completing or being interrupted
function GameMode:OnAbilityChannelFinished(keys)
	--DeepPrintTable(keys)

	local interrupted = keys.interrupted == 1
	local abilityname = keys.abilityname
	local caster = EntIndexToHScript(keys.caster_entindex)

	if abilityname == "item_bosstoken_blue" and interrupted == false then
		for i=0,8 do
			local item = caster:GetItemInSlot(i)
			if item ~= nil and item:GetAbilityName() == "item_bosstoken_blue" then
				caster:RemoveItem(item)
				return
			end
		end
	elseif abilityname == "item_bosstoken_green" and interrupted == false then
		for i=0,8 do
			local item = caster:GetItemInSlot(i)
			if item ~= nil and item:GetAbilityName() == "item_bosstoken_green" then
				caster:RemoveItem(item)
				return
			end
		end
	elseif abilityname == "item_bosstoken_yellow" and interrupted == false then
		for i=0,8 do
			local item = caster:GetItemInSlot(i)
			if item ~= nil and item:GetAbilityName() == "item_bosstoken_yellow" then
				caster:RemoveItem(item)
				return
			end
		end
	elseif abilityname == "item_bosstoken_orange" and interrupted == false then
		for i=0,8 do
			local item = caster:GetItemInSlot(i)
			if item ~= nil and item:GetAbilityName() == "item_bosstoken_orange" then
				caster:RemoveItem(item)
				return
			end
		end
	elseif abilityname == "item_bosstoken_red" and interrupted == false then
		for i=0,8 do
			local item = caster:GetItemInSlot(i)
			if item ~= nil and item:GetAbilityName() == "item_bosstoken_red" then
				caster:RemoveItem(item)
				return
			end
		end
	elseif abilityname == "item_bosstoken_purple" and interrupted == false then
		for i=0,8 do
			local item = caster:GetItemInSlot(i)
			if item ~= nil and item:GetAbilityName() == "item_bosstoken_purple" then
				caster:RemoveItem(item)
				return
			end
		end
	elseif abilityname == "item_bosstoken_white" and interrupted == false then
		for i=0,8 do
			local item = caster:GetItemInSlot(i)
			if item ~= nil and item:GetAbilityName() == "item_bosstoken_white" then
				caster:RemoveItem(item)
				return
			end
		end
	elseif abilityname == "item_bosstoken_black" and interrupted == false then
		for i=0,8 do
			local item = caster:GetItemInSlot(i)
			if item ~= nil and item:GetAbilityName() == "item_bosstoken_black" then
				caster:RemoveItem(item)
				return
			end
		end
	end
end

-- A player leveled up
function GameMode:OnPlayerLevelUp(keys)
	--DeepPrintTable(keys)

	local player = EntIndexToHScript(keys.player)
	local level = keys.level
end

-- A player last hit a creep, a tower, or a hero
function GameMode:OnLastHit(keys)
	--DeepPrintTable(keys)

	local isFirstBlood = keys.FirstBlood == 1
	local isHeroKill = keys.HeroKill == 1
	local isTowerKill = keys.TowerKill == 1
	local player = PlayerResource:GetPlayer(keys.PlayerID)
end

-- A tree was cut down by tango, quelling blade, etc
function GameMode:OnTreeCut(keys)
	--DeepPrintTable(keys)

	local treeX = keys.tree_x
	local treeY = keys.tree_y
end

-- A rune was activated by a player
function GameMode:OnRuneActivated (keys)
	--DeepPrintTable(keys)

	local player = PlayerResource:GetPlayer(keys.PlayerID)
	local rune = keys.rune

end

-- A player took damage from a tower
function GameMode:OnPlayerTakeTowerDamage(keys)
	--DeepPrintTable(keys)

	local player = PlayerResource:GetPlayer(keys.PlayerID)
	local damage = keys.damage
end

-- A player picked a hero
function GameMode:OnPlayerPickHero(keys)
	--DeepPrintTable(keys)

	local heroClass = keys.hero
	local heroEntity = EntIndexToHScript(keys.heroindex)
	local player = EntIndexToHScript(keys.player)
end

-- A player killed another player in a multi-team context
function GameMode:OnTeamKillCredit(keys)
	--DeepPrintTable(keys)

	local killerPlayer = PlayerResource:GetPlayer(keys.killer_userid)
	local victimPlayer = PlayerResource:GetPlayer(keys.victim_userid)
	local numKills = keys.herokills
	local killerTeamNumber = keys.teamnumber
end

-- An entity died
function GameMode:OnEntityKilled(keys)
	--DeepPrintTable( keys )
	local killed_unit = EntIndexToHScript(keys.entindex_killed)
	local deathLocation = killed_unit:GetAbsOrigin()
	local killedTeam = killed_unit:GetTeam()
	--killed_unit:GetTeam()
	--radiant = 2
	--dire = 3
	--neturals = 4
	
	local owner = killed_unit:GetOwner()
	if killed_unit.hero == 1 then
		owner:SetOrigin(killed_unit:GetOrigin())
		owner:ForceKill(true)
	end
	
	if killed_unit:IsHero() then
		local newItem = CreateItem("item_tombstone", killed_unit , killed_unit)
		newItem:SetPurchaseTime(0)
		newItem:SetPurchaser(killed_unit)
		local tombstone = SpawnEntityFromTableSynchronous("dota_item_tombstone_drop", {})
		tombstone:SetContainedItem(newItem)
		tombstone:SetAngles(0, RandomFloat( 0, 360 ), 0)
		FindClearSpaceForUnit(tombstone, killed_unit:GetAbsOrigin(), true)
	end
	
	-- The Killing entity
	local killer_unit = nil
	if keys.entindex_attacker ~= nil then
		killer_unit = EntIndexToHScript(keys.entindex_attacker)
	end

	if killed_unit:GetUnitName() == "greevil_naked_dire" or
		killed_unit:GetUnitName() == "greevil_naked_rad" then
		local dropRoll = RandomInt(1, 1000)
		if (dropRoll > 0) and (dropRoll <= 100) then
			local pos = killed_unit:GetAbsOrigin()
			local item = CreateItem("item_heal", nil, nil)
			item:SetPurchaseTime(0)
			CreateItemOnPositionSync(pos, item)
			item:LaunchLoot(true, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
			Timers:CreateTimer({endTime = 60.0,
				callback = function()
				item:GetContainer():Destroy()
			end})
		end
		if (dropRoll > 100) and (dropRoll <= 200) then
			local pos = killed_unit:GetAbsOrigin()
			local item = CreateItem("item_mana", nil, nil)
			item:SetPurchaseTime(0)
			CreateItemOnPositionSync(pos, item)
			item:LaunchLoot(true, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
			Timers:CreateTimer({endTime = 60.0,
				callback = function()
				item:GetContainer():Destroy()
			end})
		end
		if (dropRoll > 200) and (dropRoll <= 250) then
			local pos = killed_unit:GetAbsOrigin()
			local item = CreateItem("item_present", nil, nil)
			item:SetPurchaseTime(0)
			CreateItemOnPositionSync(pos, item)
			item:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
			Timers:CreateTimer({endTime = 60.0,
				callback = function()
				item:GetContainer():Destroy()
			end})
		end
	end
	
	if killer_unit ~= nil then
		if killed_unit:GetUnitName() == "greevil_red" 
		or killed_unit:GetUnitName() == "greevil_orange" 
		or killed_unit:GetUnitName() == "greevil_yellow" 
		or killed_unit:GetUnitName() == "greevil_blue" 
		or killed_unit:GetUnitName() == "greevil_purple" 
		or killed_unit:GetUnitName() == "greevil_black"
		or killed_unit:GetUnitName() == "greevil_white" then
			local killerTeam = killer_unit:GetTeam()
			local PlayerCountOnTeam = PlayerResource:GetPlayerCountForTeam(killerTeam)
			
			for i=1,PlayerCountOnTeam do
				local playerId = PlayerResource:GetNthPlayerIDOnTeam(killerTeam, i)
				local hero = PlayerResource:GetSelectedHeroEntity(playerId)
				hero:AddExperience(400,0,false,false)	--neutral boss xp to whole team
			end
		elseif killed_unit:GetUnitName() == "greevil_naked_rad"
		or killed_unit:GetUnitName() == "greevil_naked_dire" then
			local killerTeam = killer_unit:GetTeam()
			local PlayerCountOnTeam = PlayerResource:GetPlayerCountForTeam(killerTeam)
			for i=1,PlayerCountOnTeam do
				local playerId = PlayerResource:GetNthPlayerIDOnTeam(killerTeam, i)
				local hero = PlayerResource:GetSelectedHeroEntity(playerId)
				hero:AddExperience(40,0,false,false)	--naked lane greevil xp
				hero:ModifyGold(15/PlayerCountOnTeam,false,0)
				local particle = ParticleManager:CreateParticleForTeam("particles/generic_gameplay/lasthit_coins.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero, killerTeam)
				ParticleManager:SetParticleControl(particle, 1, hero:GetAbsOrigin())
				ParticleManager:ReleaseParticleIndex(1)				
			end
		elseif killed_unit:GetUnitName() == "greevil_red_rad_att" or killed_unit:GetUnitName() == "greevil_red_dire_att"
		or killed_unit:GetUnitName() == "greevil_orange_rad_att" or killed_unit:GetUnitName() == "greevil_orange_dire_att"		
		or killed_unit:GetUnitName() == "greevil_yellow_rad_att" or killed_unit:GetUnitName() == "greevil_yellow_dire_att"		
		or killed_unit:GetUnitName() == "greevil_green_rad_att" or killed_unit:GetUnitName() == "greevil_green_dire_att"
		or killed_unit:GetUnitName() == "greevil_blue_rad_att" or killed_unit:GetUnitName() == "greevil_blue_dire_att"
		or killed_unit:GetUnitName() == "greevil_purple_rad_att" or killed_unit:GetUnitName() == "greevil_purple_dire_att"
		or killed_unit:GetUnitName() == "greevil_white_rad_att" or killed_unit:GetUnitName() == "greevil_white_dire_att"
		or killed_unit:GetUnitName() == "greevil_black_rad_att" or killed_unit:GetUnitName() == "greevil_black_dire_att" then
			if killed_unit.lane == 1 then
				local killerTeam = killer_unit:GetTeam()
				local PlayerCountOnTeam = PlayerResource:GetPlayerCountForTeam(killerTeam)
				for i=1,PlayerCountOnTeam do
					local playerId = PlayerResource:GetNthPlayerIDOnTeam(killerTeam, i)
					local hero = PlayerResource:GetSelectedHeroEntity(playerId)
					hero:AddExperience(120,0,false,false)	--naked lane greevil xp
					hero:ModifyGold(80/PlayerCountOnTeam,false,0)
					local particle = ParticleManager:CreateParticleForTeam("particles/generic_gameplay/lasthit_coins.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero, killerTeam)
					ParticleManager:SetParticleControl(particle, 1, hero:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(1)				
				end
				local dropRoll = RandomInt(1, 1000)
				if (dropRoll > 0) and (dropRoll <= 100) then
					local pos = killed_unit:GetAbsOrigin()
					local item = CreateItem("item_heal", nil, nil)
					item:SetPurchaseTime(0)
					CreateItemOnPositionSync(pos, item)
					item:LaunchLoot(true, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
					Timers:CreateTimer({endTime = 60.0,
						callback = function()
						item:GetContainer():Destroy()
					end})
				end
				if (dropRoll > 100) and (dropRoll <= 200) then
					local pos = killed_unit:GetAbsOrigin()
					local item = CreateItem("item_mana", nil, nil)
					item:SetPurchaseTime(0)
					CreateItemOnPositionSync(pos, item)
					item:LaunchLoot(true, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
					Timers:CreateTimer({endTime = 60.0,
						callback = function()
						item:GetContainer():Destroy()
					end})
				end
				if (dropRoll > 200) and (dropRoll <= 250) then
					local pos = killed_unit:GetAbsOrigin()
					local item = CreateItem("item_present", nil, nil)
					item:SetPurchaseTime(0)
					CreateItemOnPositionSync(pos, item)
					item:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
					Timers:CreateTimer({endTime = 60.0,
						callback = function()
						item:GetContainer():Destroy()
					end})
				end
			end
		end
		
		-- Hero gets lasthit on boss
		if killed_unit:GetUnitName() == "greevil_red" then
			local pos = killed_unit:GetAbsOrigin()
			local bossLoot = CreateItem("item_boss_drop_red", nil, nil)
			bossLoot:SetPurchaseTime(0)
			CreateItemOnPositionSync(pos, bossLoot)
			bossLoot:LaunchLoot(false, 300, RandomFloat(0, 1), pos + RandomVector(RandomFloat(0, 150)))
			Timers:CreateTimer({endTime = 300.0,
				callback = function()
				bossLoot:GetContainer():Destroy()
			end})
			EmitSoundOnLocationWithCaster(killed_unit:GetAbsOrigin(), "Miniboss_Greevil.Death", killed_unit)
		elseif killed_unit:GetUnitName() == "greevil_orange" then
			local pos = killed_unit:GetAbsOrigin()
			local bossLoot = CreateItem("item_boss_drop_orange", nil, nil)
			bossLoot:SetPurchaseTime(0)
			CreateItemOnPositionSync(pos, bossLoot)
			bossLoot:LaunchLoot(false, 300, RandomFloat(0, 1), pos + RandomVector(RandomFloat(0, 150)))
			Timers:CreateTimer({endTime = 300.0,
				callback = function()
				bossLoot:GetContainer():Destroy()
			end})
			EmitSoundOnLocationWithCaster(killed_unit:GetAbsOrigin(), "Miniboss_Greevil.Death", killed_unit)
		elseif killed_unit:GetUnitName() == "greevil_yellow" then
			local pos = killed_unit:GetAbsOrigin()
			local bossLoot = CreateItem("item_boss_drop_yellow", nil, nil)
			bossLoot:SetPurchaseTime(0)
			CreateItemOnPositionSync(pos, bossLoot)
			bossLoot:LaunchLoot(false, 300, RandomFloat(0, 1), pos + RandomVector(RandomFloat(0, 150)))
			Timers:CreateTimer({endTime = 300.0,
				callback = function()
				bossLoot:GetContainer():Destroy()
			end})
			EmitSoundOnLocationWithCaster(killed_unit:GetAbsOrigin(), "Miniboss_Greevil.Death", killed_unit)
		elseif killed_unit:GetUnitName() == "greevil_green" then
			local pos = killed_unit:GetAbsOrigin()
			local bossLoot = CreateItem("item_boss_drop_green", nil, nil)
			bossLoot:SetPurchaseTime(0)
			CreateItemOnPositionSync(pos, bossLoot)
			bossLoot:LaunchLoot(false, 300, RandomFloat(0, 1), pos + RandomVector(RandomFloat(0, 150)))
			Timers:CreateTimer({endTime = 300.0,
				callback = function()
				bossLoot:GetContainer():Destroy()
			end})
			EmitSoundOnLocationWithCaster(killed_unit:GetAbsOrigin(), "Miniboss_Greevil.Death", killed_unit)
		elseif killed_unit:GetUnitName() == "greevil_blue" then
			local pos = killed_unit:GetAbsOrigin()
			local bossLoot = CreateItem("item_boss_drop_blue", nil, nil)
			bossLoot:SetPurchaseTime(0)
			CreateItemOnPositionSync(pos, bossLoot)
			bossLoot:LaunchLoot(false, 300, RandomFloat(0, 1), pos + RandomVector(RandomFloat(0, 150)))
			Timers:CreateTimer({endTime = 300.0,
				callback = function()
				bossLoot:GetContainer():Destroy()
			end})
			EmitSoundOnLocationWithCaster(killed_unit:GetAbsOrigin(), "Miniboss_Greevil.Death", killed_unit)
		elseif killed_unit:GetUnitName() == "greevil_purple" then
			local pos = killed_unit:GetAbsOrigin()
			local bossLoot = CreateItem("item_boss_drop_purple", nil, nil)
			bossLoot:SetPurchaseTime(0)
			CreateItemOnPositionSync(pos, bossLoot)
			bossLoot:LaunchLoot(false, 300, RandomFloat(0, 1), pos + RandomVector(RandomFloat(0, 150)))
			Timers:CreateTimer({endTime = 300.0,
				callback = function()
				bossLoot:GetContainer():Destroy()
			end})
			EmitSoundOnLocationWithCaster(killed_unit:GetAbsOrigin(), "Miniboss_Greevil.Death", killed_unit)
		elseif killed_unit:GetUnitName() == "greevil_white" then
			local pos = killed_unit:GetAbsOrigin()
			local bossLoot = CreateItem("item_boss_drop_white", nil, nil)
			bossLoot:SetPurchaseTime(0)
			CreateItemOnPositionSync(pos, bossLoot)
			bossLoot:LaunchLoot(false, 300, RandomFloat(0, 1), pos + RandomVector(RandomFloat(0, 150)))
			Timers:CreateTimer({endTime = 300.0,
				callback = function()
				bossLoot:GetContainer():Destroy()
			end})
			EmitSoundOnLocationWithCaster(killed_unit:GetAbsOrigin(), "Miniboss_Greevil.Death", killed_unit)
		elseif killed_unit:GetUnitName() == "greevil_black" then
			local pos = killed_unit:GetAbsOrigin()
			local bossLoot = CreateItem("item_boss_drop_black", nil, nil)
			bossLoot:SetPurchaseTime(0)
			CreateItemOnPositionSync(pos, bossLoot)
			bossLoot:LaunchLoot(false, 300, RandomFloat(0, 1), pos + RandomVector(RandomFloat(0, 150)))
			Timers:CreateTimer({endTime = 300.0,
				callback = function()
				bossLoot:GetContainer():Destroy()
			end})
			EmitSoundOnLocationWithCaster(killed_unit:GetAbsOrigin(), "Miniboss_Greevil.Death", killed_unit)
		
		-- Defence Greevils
		elseif killed_unit:GetUnitName() == "greevil_red_rad_def" then
			DefenceGreevil.Radiant.Red = 0
		elseif killed_unit:GetUnitName() == "greevil_orange_rad_def" then
			DefenceGreevil.Radiant.Orange = 0
		elseif killed_unit:GetUnitName() == "greevil_yellow_rad_def" then
			DefenceGreevil.Radiant.Yellow = 0
		elseif killed_unit:GetUnitName() == "greevil_green_rad_def" then
			DefenceGreevil.Radiant.Green = 0
		elseif killed_unit:GetUnitName() == "greevil_blue_rad_def" then
			DefenceGreevil.Radiant.Blue = 0
		elseif killed_unit:GetUnitName() == "greevil_purple_rad_def" then
			DefenceGreevil.Radiant.Purple = 0
		elseif killed_unit:GetUnitName() == "greevil_white_rad_def" then
			DefenceGreevil.Radiant.White = 0
		elseif killed_unit:GetUnitName() == "greevil_black_rad_def" then
			DefenceGreevil.Radiant.Black = 0
		elseif killed_unit:GetUnitName() == "greevil_red_dire_def" then
			DefenceGreevil.Dire.Red = 0
		elseif killed_unit:GetUnitName() == "greevil_orange_dire_def" then
			DefenceGreevil.Dire.Orange = 0
		elseif killed_unit:GetUnitName() == "greevil_yellow_dire_def" then
			DefenceGreevil.Dire.Yellow = 0
		elseif killed_unit:GetUnitName() == "greevil_green_dire_def" then
			DefenceGreevil.Dire.Green = 0
		elseif killed_unit:GetUnitName() == "greevil_blue_dire_def" then
			DefenceGreevil.Dire.Blue = 0
		elseif killed_unit:GetUnitName() == "greevil_purple_dire_def" then
			DefenceGreevil.Dire.Purple = 0
		elseif killed_unit:GetUnitName() == "greevil_white_dire_def" then
			DefenceGreevil.Dire.White = 0
		elseif killed_unit:GetUnitName() == "greevil_black_dire_def" then
			DefenceGreevil.Dire.Black = 0
		
		-- Attack Greevils Spawners
		elseif killed_unit:GetUnitName() == "greevil_spawner_red" and killed_unit:GetTeam() == 2 then
			AttackGreevil.Radiant.Red = 0
		elseif killed_unit:GetUnitName() == "greevil_spawner_orange" and killed_unit:GetTeam() == 2 then
			AttackGreevil.Radiant.Orange = 0
		elseif killed_unit:GetUnitName() == "greevil_spawner_yellow" and killed_unit:GetTeam() == 2 then
			AttackGreevil.Radiant.Yellow = 0
		elseif killed_unit:GetUnitName() == "greevil_spawner_green" and killed_unit:GetTeam() == 2 then
			AttackGreevil.Radiant.Green = 0
		elseif killed_unit:GetUnitName() == "greevil_spawner_blue" and killed_unit:GetTeam() == 2 then
			AttackGreevil.Radiant.Blue = 0
		elseif killed_unit:GetUnitName() == "greevil_spawner_purple" and killed_unit:GetTeam() == 2 then
			AttackGreevil.Radiant.Purple = 0
		elseif killed_unit:GetUnitName() == "greevil_spawner_white" and killed_unit:GetTeam() == 2 then
			AttackGreevil.Radiant.White = 0
		elseif killed_unit:GetUnitName() == "greevil_spawner_black" and killed_unit:GetTeam() == 2 then
			AttackGreevil.Radiant.Black = 0
		elseif killed_unit:GetUnitName() == "greevil_spawner_red" and killed_unit:GetTeam() == 3 then
			AttackGreevil.Dire.Red = 0
		elseif killed_unit:GetUnitName() == "greevil_spawner_orange" and killed_unit:GetTeam() == 3 then
			AttackGreevil.Dire.Orange = 0
		elseif killed_unit:GetUnitName() == "greevil_spawner_yellow" and killed_unit:GetTeam() == 3 then
			AttackGreevil.Dire.Yellow = 0
		elseif killed_unit:GetUnitName() == "greevil_spawner_green" and killed_unit:GetTeam() == 3 then
			AttackGreevil.Dire.Green = 0
		elseif killed_unit:GetUnitName() == "greevil_spawner_blue" and killed_unit:GetTeam() == 3 then
			AttackGreevil.Dire.Blue = 0
		elseif killed_unit:GetUnitName() == "greevil_spawner_purple" and killed_unit:GetTeam() == 3 then
			AttackGreevil.Dire.Purple = 0
		elseif killed_unit:GetUnitName() == "greevil_spawner_white" and killed_unit:GetTeam() == 3 then
			AttackGreevil.Dire.White = 0
		elseif killed_unit:GetUnitName() == "greevil_spawner_black" and killed_unit:GetTeam() == 3 then
			AttackGreevil.Dire.Black = 0
		
		-- Green attack greevil duplication
		elseif killed_unit:GetUnitName() == "greevil_green_boss_att" then
			unit = CreateUnitByName("greevil_green_boss_att_2", deathLocation, true, nil, nil, killedTeam)
			unit = CreateUnitByName("greevil_green_boss_att_2", deathLocation, true, nil, nil, killedTeam)
		elseif killed_unit:GetUnitName() == "greevil_green_boss_att_2" then
			unit = CreateUnitByName("greevil_green_boss_att_3", deathLocation, true, nil, nil, killedTeam)
			unit = CreateUnitByName("greevil_green_boss_att_3", deathLocation, true, nil, nil, killedTeam)

		-- whiteboss fight
		elseif killed_unit:GetUnitName() == "greevil_white_red" or killed_unit:GetUnitName() == "greevil_white_orange" or killed_unit:GetUnitName() == "greevil_white_yellow" or killed_unit:GetUnitName() == "greevil_white_green" or killed_unit:GetUnitName() == "greevil_white_blue" or killed_unit:GetUnitName() == "greevil_white_purple" then
			if killed_unit.side == "rad" then
				local units = FindUnitsInLine(DOTA_TEAM_NEUTRALS, (Vector(-9700, 5760, 256)), (Vector(-9700, -3584, 256)), nil, 2000.0, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE)
				for i=1,#units do
					if units[i]:GetUnitName() == "greevil_white" then
						local target = units[i]
						local remainingHP = target:GetHealth()
						nearEnemies = FindUnitsInRadius(target:GetTeam(), target:GetAbsOrigin(), nil,
							2000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
							FIND_CLOSEST, false)
						closestEnemy = nearEnemies[1]
						local damageTable = {
							victim = target,
							attacker = closestEnemy,
							damage = 1,
							damage_type = DAMAGE_TYPE_HP_REMOVAL,
							damage_flags = DOTA_DAMAGE_FLAG_NONE,
							ability = nil,}
						ApplyDamage(damageTable)
					end
				end
			elseif killed_unit.side == "dire" then
				local units = FindUnitsInLine(DOTA_TEAM_NEUTRALS, (Vector(9700, 5760, 256)), (Vector(9700, -3584, 256)), nil, 2000.0, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE)
				for i=1,#units do
					if units[i]:GetUnitName() == "greevil_white" then
						local target = units[i]
						local remainingHP = target:GetHealth()
						nearEnemies = FindUnitsInRadius(target:GetTeam(), target:GetAbsOrigin(), nil,
							2000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, 
							FIND_CLOSEST, false)
						closestEnemy = nearEnemies[1]
						local damageTable = {
							victim = target,
							attacker = closestEnemy,
							damage = 1,
							damage_type = DAMAGE_TYPE_HP_REMOVAL,
							damage_flags = DOTA_DAMAGE_FLAG_NONE,
							ability = nil,}
						ApplyDamage(damageTable)
					end
				end
			end
		end
	end
		
	-- The ability/item used to kill, or nil if not killed by an item/ability
	local killing_ability = nil
	
	if keys.entindex_inflictor ~= nil then
		killing_ability = EntIndexToHScript(keys.entindex_inflictor)
	end
	
	-- For Meepo clones, find the original
	if killed_unit:IsClone() then
		if killed_unit:GetCloneSource() then
			killed_unit = killed_unit:GetCloneSource()
		end
	end
	
	-- Killed Unit is a hero (not an illusion) and he is not reincarnating
	if killed_unit:IsRealHero() and (not killed_unit:IsReincarnating()) then
		-- Hero gold bounty update for the killer
		if USE_CUSTOM_HERO_GOLD_BOUNTY then
			if killer_unit:IsRealHero() then
				-- Get his killing streak
				local hero_streak = killer_unit:GetStreak()
				-- Get his level
				local hero_level = killer_unit:GetLevel()
				-- Adjust Gold bounty
				local gold_bounty
				if hero_streak > 2 then
					gold_bounty = HERO_KILL_GOLD_BASE + hero_level*HERO_KILL_GOLD_PER_LEVEL + (hero_streak-2)*HERO_KILL_GOLD_PER_STREAK
				else
					gold_bounty = HERO_KILL_GOLD_BASE + hero_level*HERO_KILL_GOLD_PER_LEVEL
				end
				
				killer_unit:SetMinimumGoldBounty(gold_bounty)
				killer_unit:SetMaximumGoldBounty(gold_bounty)
			end
		end

		-- Hero Respawn time configuration
		if ENABLE_HERO_RESPAWN then
			local killed_unit_level = killed_unit:GetLevel()

			-- Respawn time without buyback penalty (+25 sec)
			local respawn_time = 1
			if USE_CUSTOM_RESPAWN_TIME then
				-- Get respawn time from the table that we defined
				respawn_time = CUSTOM_RESPAWN_TIME
			else
				-- Get dota default respawn time
				respawn_time = killed_unit:GetRespawnTime()
			end

			-- Killer is a neutral creep
			if killer_unit:IsNeutralUnitType() then
				-- If a hero is killed by a neutral creep, respawn time can be modified here
			end

			if not killed_unit:IsReincarnating() then
				killed_unit:SetTimeUntilRespawn(respawn_time)
			end
		end

		-- Buyback Cooldown
		if CUSTOM_BUYBACK_COOLDOWN_ENABLED then
			PlayerResource:SetCustomBuybackCooldown(killed_unit:GetPlayerID(), CUSTOM_BUYBACK_COOLDOWN_TIME)
		end

		-- Buyback Fixed Gold Cost
		if CUSTOM_BUYBACK_COST_ENABLED then
			PlayerResource:SetCustomBuybackCost(killed_unit:GetPlayerID(), BUYBACK_FIXED_GOLD_COST)
		end

		-- Killer is not a real hero but it killed a hero
		if killer_unit:IsTower() or killer_unit:IsCreep() or killer_unit:IsFountain() then
			-- Put stuff here that you want to happen if a hero is killed by a creep, tower or fountain.
		end

		-- When team hero kill limit is reached declare the winner
		if END_GAME_ON_KILLS and GetTeamHeroKills(killer_unit:GetTeam()) >= KILLS_TO_END_GAME_FOR_TEAM then
			GameRules:SetGameWinner(killer_unit:GetTeam())
		end

		-- Setting top bar values
		if SHOW_KILLS_ON_TOPBAR then
			GameRules:GetGameModeEntity():SetTopBarTeamValue(DOTA_TEAM_BADGUYS, GetTeamHeroKills(DOTA_TEAM_BADGUYS))
			GameRules:GetGameModeEntity():SetTopBarTeamValue(DOTA_TEAM_GOODGUYS, GetTeamHeroKills(DOTA_TEAM_GOODGUYS))
		end
	end

	-- Ancient destruction detection (if the map doesn't have ancients with these names, this will never happen)
	if killed_unit:GetUnitName() == "npc_dota_badguys_fort" then
		GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
		GameRules:SetCustomVictoryMessage("#dota_post_game_radiant_victory")
		GameRules:SetCustomVictoryMessageDuration(POST_GAME_TIME)
	elseif killed_unit:GetUnitName() == "npc_dota_goodguys_fort" then
		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		GameRules:SetCustomVictoryMessage("#dota_post_game_dire_victory")
		GameRules:SetCustomVictoryMessageDuration(POST_GAME_TIME)
	end

	-- Remove dead non-hero units from selection -> bugged ability/cast bar
	if killed_unit:IsIllusion() or (killed_unit:IsControllableByAnyPlayer() and (not killed_unit:IsRealHero()) and (not killed_unit:IsCourier()) and (not killed_unit:IsClone())) and (not killed_unit:IsTempestDouble()) then
		local player = killed_unit:GetPlayerOwner()
		local playerID
		if player == nil then
			playerID = killed_unit:GetPlayerOwnerID()
		else
			playerID = player:GetPlayerID()
		end
		
		if Selection then
			-- Without Selection library this will return an error
			PlayerResource:RemoveFromSelection(playerID, killed_unit)
		end
	end
end

function removeItem(purchaseEntity,itemName)
	for i=0,14 do
		local itemHero = purchaseEntity:GetItemInSlot(i)
		if itemHero ~= nil and itemHero:GetAbilityName() == tostring(itemName) then
			if itemHero:GetContainer() ~= nil then
				itemHero:GetContainer():Destroy()
			end
			purchaseEntity:RemoveItem(itemHero)
		end
	end
end