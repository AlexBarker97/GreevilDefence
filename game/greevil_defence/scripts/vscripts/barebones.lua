print ('[BAREBONES] barebones.lua' )

-- GameRules Variables
ENABLE_HERO_RESPAWN = false              -- Should the heroes automatically respawn on a timer or stay dead until manually respawned
UNIVERSAL_SHOP_MODE = false             -- Should the main shop contain Secret Shop items as well as regular items
ALLOW_SAME_HERO_SELECTION = true        -- Should we let people select the same hero as each other

HERO_SELECTION_TIME = 15.0				-- How long should we let people select their hero?
PRE_GAME_TIME = 20.0					-- How long after people select their heroes should the horn blow and the game start?
POST_GAME_TIME = 30.0                   -- How long should we let people look at the scoreboard before closing the server automatically?
TREE_REGROW_TIME = 1.0					-- How long should it take individual trees to respawn after being cut down/destroyed?

GOLD_PER_TICK = 0						-- How much gold should players get per tick?
GOLD_TICK_TIME = 5                      -- How long should we wait in seconds between gold ticks?

RECOMMENDED_BUILDS_DISABLED = true		-- Should we disable the recommened builds for heroes (Note: this is not working currently I believe)
CAMERA_DISTANCE_OVERRIDE = 1600.0       -- How far out should we allow the camera to go?  1134 is the default in Dota

MINIMAP_ICON_SIZE = 1                   -- What icon size should we use for our heroes?
MINIMAP_CREEP_ICON_SIZE = 2             -- What icon size should we use for creeps?
MINIMAP_RUNE_ICON_SIZE = 1              -- What icon size should we use for runes?

RUNE_SPAWN_TIME = 120                   -- How long in seconds should we wait between rune spawns?
CUSTOM_BUYBACK_COST_ENABLED = true      -- Should we use a custom buyback cost setting?
CUSTOM_BUYBACK_COOLDOWN_ENABLED = true  -- Should we use a custom buyback time?
BUYBACK_ENABLED = false                 -- Should we allow people to buyback when they die?

DISABLE_FOG_OF_WAR_ENTIRELY = true      -- Should we disable fog of war entirely for both teams?
USE_STANDARD_HERO_GOLD_BOUNTY = true    -- Should we give gold for hero kills the same as in Dota, or allow those values to be changed?

USE_CUSTOM_TOP_BAR_VALUES = true        -- Should we do customized top bar values or use the default kill count per team?
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

-- Fill this table up with the required XP per level if you want to change it
XP_PER_LEVEL_TABLE = {}
XP_PER_LEVEL_TABLE = {
		100,	200,	300,	400,	500,
		900,	1300,	1700,	2100,	2500,	2900,
		3700,	4500,	4300,	5100,	5900,	6700,
		7700,	8700,
		10000,	10000,	10000,	10000,	10000,	10000,	10000,	10000,	10000,	10000,	10000
		}
--for i=1,MAX_LEVEL do
--	XP_PER_LEVEL_TABLE[i] = i * 250
--end
DeepPrintTable(XP_PER_LEVEL_TABLE)

-- Generated from template
if GameMode == nil then
	GameMode = class({})
end

-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function GameMode:InitGameMode()
	GameMode = self
	print('[BAREBONES] Starting to load Barebones gamemode...')

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
	print('[BAREBONES] GameRules set')

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

	print('[BAREBONES] Done loading Barebones gamemode!\n\n')
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
	--DeepPrintTable(keys)
	GameMode:CaptureGameMode()

	local entIndex = keys.index+1
	-- The Player entity of the joining user
	local ply = EntIndexToHScript(entIndex)

	-- The Player ID of the joining player
	local playerID = ply:GetPlayerID()

	-- Update the user ID table with this user
	self.vUserIds[keys.userid] = ply

	-- Update the Steam ID table
	self.vSteamIds[PlayerResource:GetSteamAccountID(playerID)] = ply

	-- If the player is a broadcaster flag it in the Broadcasters table
	if PlayerResource:IsBroadcaster(playerID) then
		self.vBroadcasters[keys.userid] = 1
		return
	end
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
	print("[BAREBONES] Performing Post-Load precache")

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
function GameMode:OnHeroInGame(hero)

	-- Store a reference to the player handle inside this hero handle.
	hero.player = PlayerResource:GetPlayer(hero:GetPlayerID())
	-- Store the player's name inside this hero handle.
	hero.playerName = PlayerResource:GetPlayerName(hero:GetPlayerID())
	-- Store this hero handle in this table.
	table.insert(self.vPlayers, hero)

	-- This line for example will set the starting gold of every hero to 500 unreliable gold
	hero:SetGold(0, false)

	-- These lines will create an item and add it to the player, effectively ensuring they start with the item
	if hero:IsRealHero() and hero.greevil == nil then
		local item = CreateItem("item_selection_whistle", hero, hero)
		hero:AddItem(item)
	end
	
end

--[[
	This function is called once and only once when the game completely begins (about 0:00 on the clock).  At this point,
	gold will begin to go up in ticks if configured, creeps will spawn, towers will become damageable etc.  This function
	is useful for starting any game logic timers/thinkers, beginning the first round, etc.
]]
function GameMode:OnGameInProgress()
	print("[BAREBONES] The game has officially begun")
end

-- Cleanup a player when they leave
function GameMode:OnDisconnect(keys)
	print('[BAREBONES] Player Disconnected ' .. tostring(keys.userid))
	--DeepPrintTable(keys)

	local name = keys.name
	local networkid = keys.networkid
	local reason = keys.reason
	local userid = keys.userid
end

-- The overall game state has changed
function GameMode:OnGameRulesStateChange(keys)
	print("[BAREBONES] GameRules State Changed")
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
	end
end

-- An NPC has spawned somewhere in game.  This includes heroes
function GameMode:OnNPCSpawned(keys)
	print("[BAREBONES] NPC Spawned")
	--DeepPrintTable(keys)
	local npc = EntIndexToHScript(keys.entindex)

	if npc:IsRealHero() and npc.bFirstSpawned == nil then
		npc.bFirstSpawned = true
		GameMode:OnHeroInGame(npc)
	end
end

-- An entity somewhere has been hurt.  This event fires very often with many units so don't do too many expensive
-- operations here
function GameMode:OnEntityHurt(keys)
	--print("[BAREBONES] Entity Hurt")
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
end

-- A player has reconnected to the game.  This function can be used to repaint Player-based particles or change
-- state as necessary
function GameMode:OnPlayerReconnect(keys)
	print ( '[BAREBONES] OnPlayerReconnect' )
	--DeepPrintTable(keys)
end

-- An item was purchased by a player
function GameMode:OnItemPurchased(keys)
	--DeepPrintTable(keys)

	local item_name = keys.itemname
	local item_cost = keys.itemcost
	local purchaseEntity = PlayerResource:GetSelectedHeroEntity(playerID)
	local team = purchaseEntity:GetTeam()
	local playerID = keys.PlayerID
	if not playerID then
		return
	end

	if item_name == "item_blue_egg_att" then
		if PlayerResource:GetTeam(playerID) == 2 then
			location = (Vector(5872, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(5872, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end
			local unit = CreateUnitByName("greevil_blue_rad_att", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
		else
			location = (Vector(-6928, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do
				x = x + 1
				location = (Vector(-6928, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_blue_dire_att", location, true, nil, nil, DOTA_TEAM_BADGUYS)
		end
		for i=0,8 do
			local itemHero = purchaseEntity:GetItemInSlot(i)
			if itemHero ~= nil and itemHero:GetAbilityName() == "item_blue_egg_att" then
				purchaseEntity:RemoveItem(itemHero)
			end
			local itemGreevil = purchaseEntity.greevil:GetItemInSlot(i)
			if itemGreevil ~= nil and itemGreevil:GetAbilityName() == "item_blue_egg_att" then
				purchaseEntity.greevil:RemoveItem(itemGreevil)
			end
		end
	elseif item_name == "item_green_egg_att" then
		if PlayerResource:GetTeam(playerID) == 2 then
			location = (Vector(5872, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(5872, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_green_rad_att", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
		else
			location = (Vector(-6928, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(-6928, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_green_dire_att", location, true, nil, nil, DOTA_TEAM_BADGUYS)
		end
		for i=0,8 do
			local itemHero = purchaseEntity:GetItemInSlot(i)
			if itemHero ~= nil and itemHero:GetAbilityName() == "item_green_egg_att" then
				purchaseEntity:RemoveItem(itemHero)
			end
			local itemGreevil = purchaseEntity.greevil:GetItemInSlot(i)
			if itemGreevil ~= nil and itemGreevil:GetAbilityName() == "item_green_egg_att" then
				purchaseEntity.greevil:RemoveItem(itemGreevil)
			end
		end
	elseif item_name == "item_yellow_egg_att" then
		if PlayerResource:GetTeam(playerID) == 2 then
			location = (Vector(5872, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(5872, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_yellow_rad_att", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
		else
			location = (Vector(-6928, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(-6928, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_yellow_dire_att", location, true, nil, nil, DOTA_TEAM_BADGUYS)
		end
		for i=0,8 do
			local itemHero = purchaseEntity:GetItemInSlot(i)
			if itemHero ~= nil and itemHero:GetAbilityName() == "item_yellow_egg_att" then
				purchaseEntity:RemoveItem(itemHero)
			end
			local itemGreevil = purchaseEntity.greevil:GetItemInSlot(i)
			if itemGreevil ~= nil and itemGreevil:GetAbilityName() == "item_yellow_egg_att" then
				purchaseEntity.greevil:RemoveItem(itemGreevil)
			end
		end
	elseif item_name == "item_orange_egg_att" then
		if PlayerResource:GetTeam(playerID) == 2 then
			location = (Vector(5872, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(5872, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_orange_rad_att", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
		else
			location = (Vector(-6928, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(-6928, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_orange_dire_att", location, true, nil, nil, DOTA_TEAM_BADGUYS)
		end
		for i=0,8 do
			local itemHero = purchaseEntity:GetItemInSlot(i)
			if itemHero ~= nil and itemHero:GetAbilityName() == "item_orange_egg_att" then
				purchaseEntity:RemoveItem(itemHero)
			end
			local itemGreevil = purchaseEntity.greevil:GetItemInSlot(i)
			if itemGreevil ~= nil and itemGreevil:GetAbilityName() == "item_orange_egg_att" then
				purchaseEntity.greevil:RemoveItem(itemGreevil)
			end
		end
	elseif item_name == "item_red_egg_att" then
		if PlayerResource:GetTeam(playerID) == 2 then
			location = (Vector(5872, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(5872, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_red_rad_att", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
		else
			location = (Vector(-6928, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(-6928, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_red_dire_att", location, true, nil, nil, DOTA_TEAM_BADGUYS)
		end
		for i=0,8 do
			local itemHero = purchaseEntity:GetItemInSlot(i)
			if itemHero ~= nil and itemHero:GetAbilityName() == "item_red_egg_att" then
				purchaseEntity:RemoveItem(itemHero)
			end
			local itemGreevil = purchaseEntity.greevil:GetItemInSlot(i)
			if itemGreevil ~= nil and itemGreevil:GetAbilityName() == "item_red_egg_att" then
				purchaseEntity.greevil:RemoveItem(itemGreevil)
			end
		end
	elseif item_name == "item_purple_egg_att" then
		if PlayerResource:GetTeam(playerID) == 2 then
			location = (Vector(5872, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(5872, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_purple_rad_att", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
		else
			location = (Vector(-6928, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(-6928, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_purple_dire_att", location, true, nil, nil, DOTA_TEAM_BADGUYS)
		end
		for i=0,8 do
			local itemHero = purchaseEntity:GetItemInSlot(i)
			if itemHero ~= nil and itemHero:GetAbilityName() == "item_purple_egg_att" then
				purchaseEntity:RemoveItem(itemHero)
			end
			local itemGreevil = purchaseEntity.greevil:GetItemInSlot(i)
			if itemGreevil ~= nil and itemGreevil:GetAbilityName() == "item_purple_egg_att" then
				purchaseEntity.greevil:RemoveItem(itemGreevil)
			end
		end
	elseif item_name == "item_black_egg_att" then
		if PlayerResource:GetTeam(playerID) == 2 then
			location = (Vector(5872, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(5872, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_black_rad_att", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
		else
			location = (Vector(-6928, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(-6928, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_black_dire_att", location, true, nil, nil, DOTA_TEAM_BADGUYS)
		end
		for i=0,8 do
			local itemHero = purchaseEntity:GetItemInSlot(i)
			if itemHero ~= nil and itemHero:GetAbilityName() == "item_black_egg_att" then
				purchaseEntity:RemoveItem(itemHero)
			end
			local itemGreevil = purchaseEntity.greevil:GetItemInSlot(i)
			if itemGreevil ~= nil and itemGreevil:GetAbilityName() == "item_black_egg_att" then
				purchaseEntity.greevil:RemoveItem(itemGreevil)
			end
		end
	elseif item_name == "item_white_egg_att" then
		if PlayerResource:GetTeam(playerID) == 2 then
			location = (Vector(5872, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(5872, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_white_rad_att", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
		else
			location = (Vector(-6928, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(-6928, 5200, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_white_dire_att", location, true, nil, nil, DOTA_TEAM_BADGUYS)
		end
		for i=0,8 do
			local itemHero = purchaseEntity:GetItemInSlot(i)
			if itemHero ~= nil and itemHero:GetAbilityName() == "item_white_egg_att" then
				purchaseEntity:RemoveItem(itemHero)
			end
			local itemGreevil = purchaseEntity.greevil:GetItemInSlot(i)
			if itemGreevil ~= nil and itemGreevil:GetAbilityName() == "item_white_egg_att" then
				purchaseEntity.greevil:RemoveItem(itemGreevil)
			end
		end
	elseif item_name == "item_blue_egg_def" then
		if PlayerResource:GetTeam(playerID) == 2 then
			location = (Vector(-6928, -2896, 304)) + (Vector(RandomInt(0,1056),RandomInt(0,944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(-6928, -2896, 304)) + (Vector(RandomInt(0,1056),RandomInt(0,944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_blue_rad_def", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
		else
			location = (Vector(5872, -2896, 304)) + (Vector(RandomInt(0,1056),RandomInt(0,944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(5872, -2896, 304)) + (Vector(RandomInt(0,1056),RandomInt(0,944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_blue_dire_def", location, true, nil, nil, DOTA_TEAM_BADGUYS)
		end
		for i=0,8 do
			local itemHero = purchaseEntity:GetItemInSlot(i)
			if itemHero ~= nil and itemHero:GetAbilityName() == "item_blue_egg_def" then
				purchaseEntity:RemoveItem(itemHero)
			end
			local itemGreevil = purchaseEntity.greevil:GetItemInSlot(i)
			if itemGreevil ~= nil and itemGreevil:GetAbilityName() == "item_blue_egg_def" then
				purchaseEntity.greevil:RemoveItem(itemGreevil)
			end
		end
	elseif item_name == "item_green_egg_def" then
		if PlayerResource:GetTeam(playerID) == 2 then
			location = (Vector(-6928, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(-6928, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_green_rad_def", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
		else
			location = (Vector(5872, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(5872, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_green_dire_def", location, true, nil, nil, DOTA_TEAM_BADGUYS)
		end
		for i=0,8 do
			local itemHero = purchaseEntity:GetItemInSlot(i)
			if itemHero ~= nil and itemHero:GetAbilityName() == "item_green_egg_def" then
				purchaseEntity:RemoveItem(itemHero)
			end
			local itemGreevil = purchaseEntity.greevil:GetItemInSlot(i)
			if itemGreevil ~= nil and itemGreevil:GetAbilityName() == "item_green_egg_def" then
				purchaseEntity.greevil:RemoveItem(itemGreevil)
			end
		end
	elseif item_name == "item_yellow_egg_def" then
		if PlayerResource:GetTeam(playerID) == 2 then
			location = (Vector(-6928, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(-6928, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_yellow_rad_def", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
		else
			location = (Vector(5872, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(5872, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_yellow_dire_def", location, true, nil, nil, DOTA_TEAM_BADGUYS)
		end
		for i=0,8 do
			local itemHero = purchaseEntity:GetItemInSlot(i)
			if itemHero ~= nil and itemHero:GetAbilityName() == "item_yellow_egg_def" then
				purchaseEntity:RemoveItem(itemHero)
			end
			local itemGreevil = purchaseEntity.greevil:GetItemInSlot(i)
			if itemGreevil ~= nil and itemGreevil:GetAbilityName() == "item_yellow_egg_def" then
				purchaseEntity.greevil:RemoveItem(itemGreevil)
			end
		end
	elseif item_name == "item_orange_egg_def" then
		if PlayerResource:GetTeam(playerID) == 2 then
			location = (Vector(-6928, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(-6928, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_orange_rad_def", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
		else
			location = (Vector(5872, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(5872, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_orange_dire_def", location, true, nil, nil, DOTA_TEAM_BADGUYS)
		end
		for i=0,8 do
			local itemHero = purchaseEntity:GetItemInSlot(i)
			if itemHero ~= nil and itemHero:GetAbilityName() == "item_orange_egg_def" then
				purchaseEntity:RemoveItem(itemHero)
			end
			local itemGreevil = purchaseEntity.greevil:GetItemInSlot(i)
			if itemGreevil ~= nil and itemGreevil:GetAbilityName() == "item_orange_egg_def" then
				purchaseEntity.greevil:RemoveItem(itemGreevil)
			end
		end
	elseif item_name == "item_red_egg_def" then
		if PlayerResource:GetTeam(playerID) == 2 then
			location = (Vector(-6928, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(-6928, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_red_rad_def", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
		else
			location = (Vector(5872, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(5872, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_red_dire_def", location, true, nil, nil, DOTA_TEAM_BADGUYS)
		end
		for i=0,8 do
			local itemHero = purchaseEntity:GetItemInSlot(i)
			if itemHero ~= nil and itemHero:GetAbilityName() == "item_red_egg_def" then
				purchaseEntity:RemoveItem(itemHero)
			end
			local itemGreevil = purchaseEntity.greevil:GetItemInSlot(i)
			if itemGreevil ~= nil and itemGreevil:GetAbilityName() == "item_red_egg_def" then
				purchaseEntity.greevil:RemoveItem(itemGreevil)
			end
		end
	elseif item_name == "item_purple_egg_def" then
		if PlayerResource:GetTeam(playerID) == 2 then
			location = (Vector(-6928, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(-6928, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_purple_rad_def", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
		else
			location = (Vector(5872, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(5872, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_purple_dire_def", location, true, nil, nil, DOTA_TEAM_BADGUYS)
		end
		for i=0,8 do
			local itemHero = purchaseEntity:GetItemInSlot(i)
			if itemHero ~= nil and itemHero:GetAbilityName() == "item_purple_egg_def" then
				purchaseEntity:RemoveItem(itemHero)
			end
			local itemGreevil = purchaseEntity.greevil:GetItemInSlot(i)
			if itemGreevil ~= nil and itemGreevil:GetAbilityName() == "item_purple_egg_def" then
				purchaseEntity.greevil:RemoveItem(itemGreevil)
			end
		end
	elseif item_name == "item_black_egg_def" then
		if PlayerResource:GetTeam(playerID) == 2 then
			location = (Vector(-6928, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(-6928, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_black_rad_def", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
		else
			location = (Vector(5872, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(5872, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_black_dire_def", location, true, nil, nil, DOTA_TEAM_BADGUYS)
		end
		for i=0,8 do
			local itemHero = purchaseEntity:GetItemInSlot(i)
			if itemHero ~= nil and itemHero:GetAbilityName() == "item_black_egg_def" then
				purchaseEntity:RemoveItem(itemHero)
			end
			local itemGreevil = purchaseEntity.greevil:GetItemInSlot(i)
			if itemGreevil ~= nil and itemGreevil:GetAbilityName() == "item_black_egg_def" then
				purchaseEntity.greevil:RemoveItem(itemGreevil)
			end
		end
	elseif item_name == "item_white_egg_def" then
		if PlayerResource:GetTeam(playerID) == 2 then
			location = (Vector(-6928, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(-6928, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_white_rad_def", location, true, nil, nil, DOTA_TEAM_GOODGUYS)
		else
			location = (Vector(5872, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
			FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 300, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			x = 1
			while FindUnits[1] ~= nil and x < 100 do 
				x = x + 1
				location = (Vector(5872, -2896, 304)) + (Vector(RandomInt(0, 1056),RandomInt(0, 944), 0))
				FindUnits = FindUnitsInRadius(DOTA_TEAM_BADGUYS, location, nil, 200, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			end	
			local unit = CreateUnitByName("greevil_white_dire_def", location, true, nil, nil, DOTA_TEAM_BADGUYS)
		end
		for i=0,8 do
			local itemHero = purchaseEntity:GetItemInSlot(i)
			if itemHero ~= nil and itemHero:GetAbilityName() == "item_white_egg_def" then
				purchaseEntity:RemoveItem(itemHero)
			end
			local itemGreevil = purchaseEntity.greevil:GetItemInSlot(i)
			if itemGreevil ~= nil and itemGreevil:GetAbilityName() == "item_white_egg_def" then
				purchaseEntity.greevil:RemoveItem(itemGreevil)
			end
		end
	end
end

-- An ability was used by a player
function GameMode:OnAbilityUsed(keys)

	local player = EntIndexToHScript(keys.PlayerID)
	local caster = EntIndexToHScript(keys.caster_entindex)
	local abilityname = keys.abilityname

end

-- A non-player entity (necro-book, chen creep, etc) used an ability
function GameMode:OnNonPlayerUsedAbility(keys)
	--DeepPrintTable(keys)

	local abilityname=  keys.abilityname
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
	DeepPrintTable(keys)

	local interrupted = keys.interrupted == 1
	local abilityname = keys.abilityname
	local caster = EntIndexToHScript(keys.caster_entindex)

	if abilityname == "item_bosstoken_blue" and interrupted == false then
		for i=0,8 do
			local item = caster:GetItemInSlot(i)
			if item ~= nil and item:GetAbilityName() == "item_bosstoken_blue" then
				caster:RemoveItem(item)
			end
		end
	elseif abilityname == "item_bosstoken_green" and interrupted == false then
		for i=0,8 do
			local item = caster:GetItemInSlot(i)
			if item ~= nil and item:GetAbilityName() == "item_bosstoken_green" then
				caster:RemoveItem(item)
			end
		end
	elseif abilityname == "item_bosstoken_yellow" and interrupted == false then
		for i=0,8 do
			local item = caster:GetItemInSlot(i)
			if item ~= nil and item:GetAbilityName() == "item_bosstoken_yellow" then
				caster:RemoveItem(item)
			end
		end
	elseif abilityname == "item_bosstoken_orange" and interrupted == false then
		for i=0,8 do
			local item = caster:GetItemInSlot(i)
			if item ~= nil and item:GetAbilityName() == "item_bosstoken_orange" then
				caster:RemoveItem(item)
			end
		end
	elseif abilityname == "item_bosstoken_red" and interrupted == false then
		for i=0,8 do
			local item = caster:GetItemInSlot(i)
			if item ~= nil and item:GetAbilityName() == "item_bosstoken_red" then
				caster:RemoveItem(item)
			end
		end
	elseif abilityname == "item_bosstoken_purple" and interrupted == false then
		for i=0,8 do
			local item = caster:GetItemInSlot(i)
			if item ~= nil and item:GetAbilityName() == "item_bosstoken_purple" then
				caster:RemoveItem(item)
			end
		end
	elseif abilityname == "item_bosstoken_white" and interrupted == false then
		for i=0,8 do
			local item = caster:GetItemInSlot(i)
			if item ~= nil and item:GetAbilityName() == "item_bosstoken_white" then
				caster:RemoveItem(item)
			end
		end
	elseif abilityname == "item_bosstoken_black" and interrupted == false then
		for i=0,8 do
			local item = caster:GetItemInSlot(i)
			if item ~= nil and item:GetAbilityName() == "item_bosstoken_black" then
				caster:RemoveItem(item)
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
		local dropRoll = RandomInt(1, 10)
		if dropRoll == 5 then
			local pos = killed_unit:GetAbsOrigin()
			local Heal = CreateItem("item_heal", nil, nil)
			Heal:SetPurchaseTime(0)
			CreateItemOnPositionSync(pos, Heal)
			Heal:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
		end
		if dropRoll == 10 then
			local pos = killed_unit:GetAbsOrigin()
			local Mana = CreateItem("item_mana", nil, nil)
			Mana:SetPurchaseTime(0)
			CreateItemOnPositionSync(pos, Mana)
			Mana:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
		end
	end
	
	--killed_unit:GetTeam()
		--radiant = 2
		--dire = 3
		--neturals = 4
	
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
				hero:AddExperience(750,0,false,false)
			end
		elseif killed_unit:GetUnitName() == "greevil_naked_rad"
		or killed_unit:GetUnitName() == "greevil_naked_dire" then
			local killerTeam = killer_unit:GetTeam()
			local PlayerCountOnTeam = PlayerResource:GetPlayerCountForTeam(killerTeam)
			for i=1,PlayerCountOnTeam do
				local playerId = PlayerResource:GetNthPlayerIDOnTeam(killerTeam, i)
				local hero = PlayerResource:GetSelectedHeroEntity(playerId)
				hero:AddExperience(150,0,false,false)
				hero:ModifyGold(15/PlayerCountOnTeam,false,0)
				local particle = ParticleManager:CreateParticleForTeam("particles/generic_gameplay/lasthit_coins.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero, killerTeam)
				ParticleManager:SetParticleControl(particle, 1, hero:GetAbsOrigin())
				ParticleManager:ReleaseParticleIndex(1)				
			end
		end
		
		if killed_unit:GetUnitName() == "greevil_green" then
			local origin = killed_unit:GetOrigin()
			unit = CreateUnitByName("greevil_green_2", origin, true, nil, nil, DOTA_TEAM_NEUTRALS)
			unit.spawnPos = killed_unit.spawnPos
			unit = CreateUnitByName("greevil_green_2", origin, true, nil, nil, DOTA_TEAM_NEUTRALS)
			unit.spawnPos = killed_unit.spawnPos
		end
		
		if killed_unit:GetUnitName() == "greevil_green_2" then
			local origin = killed_unit:GetOrigin()
			unit = CreateUnitByName("greevil_green_3", origin, true, nil, nil, DOTA_TEAM_NEUTRALS)
			unit.spawnPos = killed_unit.spawnPos
			unit = CreateUnitByName("greevil_green_3", origin, true, nil, nil, DOTA_TEAM_NEUTRALS)
			unit.spawnPos = killed_unit.spawnPos
		end
		
		-- Hero gets lasthit on boss
		if killed_unit:GetUnitName() == "greevil_red" and killer_unit:IsRealHero() == true then
			killer_unit:AddItemByName("item_boss_drop_red")
		elseif killed_unit:GetUnitName() == "greevil_orange" and killer_unit:IsRealHero() == true then
			killer_unit:AddItemByName("item_boss_drop_orange")
		elseif killed_unit:GetUnitName() == "greevil_yellow" and killer_unit:IsRealHero() == true then
			killer_unit:AddItemByName("item_boss_drop_yellow")
		elseif killed_unit:GetUnitName() == "greevil_green" and killer_unit:IsRealHero() == true then
			killer_unit:AddItemByName("item_boss_drop_green")
		elseif killed_unit:GetUnitName() == "greevil_blue" and killer_unit:IsRealHero() == true then
			killer_unit:AddItemByName("item_boss_drop_blue")
		elseif killed_unit:GetUnitName() == "greevil_purple" and killer_unit:IsRealHero() == true then
			killer_unit:AddItemByName("item_boss_drop_purple")
		elseif killed_unit:GetUnitName() == "greevil_white" and killer_unit:IsRealHero() == true then
			killer_unit:AddItemByName("item_boss_drop_white")
		elseif killed_unit:GetUnitName() == "greevil_black" and killer_unit:IsRealHero() == true then
			killer_unit:AddItemByName("item_boss_drop_black")
		
		-- Illusion gets lasthit on boss
		elseif killed_unit:GetUnitName() == "greevil_red" and killer_unit:GetOwner() ~= nil then
			killer_unit:GetOwner():AddItemByName("item_boss_drop_red")		
		elseif killed_unit:GetUnitName() == "greevil_orange" and killer_unit:GetOwner() ~= nil then
			killer_unit:GetOwner():AddItemByName("item_boss_drop_orange")
		elseif killed_unit:GetUnitName() == "greevil_yellow" and killer_unit:GetOwner() ~= nil then
			killer_unit:GetOwner():AddItemByName("item_boss_drop_yellow")
		elseif killed_unit:GetUnitName() == "greevil_green" and killer_unit:GetOwner() ~= nil then
			killer_unit:GetOwner():AddItemByName("item_boss_drop_green")
		elseif killed_unit:GetUnitName() == "greevil_blue" and killer_unit:GetOwner() ~= nil then
			killer_unit:GetOwner():AddItemByName("item_boss_drop_blue")
		elseif killed_unit:GetUnitName() == "greevil_purple" and killer_unit:GetOwner() ~= nil then
			killer_unit:GetOwner():AddItemByName("item_boss_drop_purple")
		elseif killed_unit:GetUnitName() == "greevil_white" and killer_unit:GetOwner() ~= nil then
			killer_unit:GetOwner():AddItemByName("item_boss_drop_white")
		elseif killed_unit:GetUnitName() == "greevil_black" and killer_unit:GetOwner() ~= nil then
			killer_unit:GetOwner():AddItemByName("item_boss_drop_black")
		
		-- Summon gets lasthit on boss
		elseif killed_unit:GetUnitName() == "greevil_red" then
			killer_unit:GetOwner():AddItemByName("item_boss_drop_red")		
		elseif killed_unit:GetUnitName() == "greevil_orange" then
			killer_unit:GetOwner():AddItemByName("item_boss_drop_orange")
		elseif killed_unit:GetUnitName() == "greevil_yellow" then
			killer_unit:GetOwner():AddItemByName("item_boss_drop_yellow")
		elseif killed_unit:GetUnitName() == "greevil_green" then
			killer_unit:GetOwner():AddItemByName("item_boss_drop_green")
		elseif killed_unit:GetUnitName() == "greevil_blue" then
			killer_unit:GetOwner():AddItemByName("item_boss_drop_blue")
		elseif killed_unit:GetUnitName() == "greevil_purple" then
			killer_unit:GetOwner():AddItemByName("item_boss_drop_purple")
		elseif killed_unit:GetUnitName() == "greevil_white" then
			killer_unit:GetOwner():AddItemByName("item_boss_drop_white")
		elseif killed_unit:GetUnitName() == "greevil_black" then
			killer_unit:GetOwner():AddItemByName("item_boss_drop_black")
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
			if USE_CUSTOM_RESPAWN_TIMES then
				-- Get respawn time from the table that we defined
				respawn_time = CUSTOM_RESPAWN_TIME[killed_unit_level]
			else
				-- Get dota default respawn time
				respawn_time = killed_unit:GetRespawnTime()
			end

			-- Fixing respawn time after level 25, this is usually bugged in custom games
			local respawn_time_after_25 = 100 + (killed_unit_level-25)*5
			if killed_unit_level > 25 and respawn_time < respawn_time_after_25	then
				respawn_time = respawn_time_after_25
			end

			-- Bloodstone reduction (bloodstone can't be in backpack)
			-- for i=DOTA_ITEM_SLOT_1, DOTA_ITEM_SLOT_6 do
				-- local item = killed_unit:GetItemInSlot(i)
				-- if item then
					-- if item:GetName() == "item_bloodstone" then
						-- local current_charges = item:GetCurrentCharges()
						-- local charges_before_death = math.ceil(current_charges*1.5)
						-- local reduction_per_charge = item:GetLevelSpecialValueFor("respawn_time_reduction", item:GetLevel() - 1)
						-- local respawn_reduction = charges_before_death*reduction_per_charge
						-- respawn_time = math.max(1, respawn_time-respawn_reduction)
						-- break -- break the for loop, to prevent multiple bloodstones granting respawn reduction
					-- end
				-- end
			-- end

			-- Killer is a neutral creep
			if killer_unit:IsNeutralUnitType() then
				-- If a hero is killed by a neutral creep, respawn time can be modified here
			end

			-- Maximum Respawn Time
			if respawn_time > MAX_RESPAWN_TIME then
				DebugPrint("Reducing respawn time of "..killed_unit:GetUnitName().." because it was too long.")
				respawn_time = MAX_RESPAWN_TIME
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