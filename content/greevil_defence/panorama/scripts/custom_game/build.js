/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ({

/***/ "./scripts/custom_game/index.js":
/*!**************************************!*\
  !*** ./scripts/custom_game/index.js ***!
  \**************************************/
/*! namespace exports */
/*! exports [not provided] [no usage info] */
/*! runtime requirements: __webpack_require__, __webpack_require__.r, __webpack_exports__, __webpack_require__.* */
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _keybinds_index_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./keybinds/index.js */ "./scripts/custom_game/keybinds/index.js");


;(0,_keybinds_index_js__WEBPACK_IMPORTED_MODULE_0__.initialize_keybinds)()
;(0,_keybinds_index_js__WEBPACK_IMPORTED_MODULE_0__.initialize_targeting_think)()

// in the future I may decide to use javascript instead of particles
// this is a demo of what that might begin to look like
function on_target_spawned(event_data)
{
	var entity_index = event_data["entity_index"]
	var origin = Entities.GetAbsOrigin(entity_index);
	var hpOffset = Entities.GetHealthBarOffset(entity_index);
	var wx = Game.WorldToScreenX(origin[0], origin[1], origin[2]+hpOffset);
	var wy = Game.WorldToScreenY(origin[0], origin[1], origin[2]+hpOffset);
	var check = Game.ScreenXYToWorld(wx, wy);

	var root = $.GetContextPanel().GetParent().GetParent().GetParent();
	var test = root.FindChildrenWithClassTraverse("HeroHealthBar")
	var test2 = root.FindChildrenWithClassTraverse("HealthBar")
	var test3 = root.FindChildTraverse("HPBarContainer")
}
GameEvents.Subscribe( "target_spawned", on_target_spawned)



/***/ }),

/***/ "./scripts/custom_game/keybinds/index.js":
/*!***********************************************!*\
  !*** ./scripts/custom_game/keybinds/index.js ***!
  \***********************************************/
/*! namespace exports */
/*! export initialize_keybinds [provided] [no usage info] [missing usage info prevents renaming] -> ./scripts/custom_game/keybinds/initialize.js .initialize_keybinds */
/*! export initialize_targeting_think [provided] [no usage info] [missing usage info prevents renaming] -> ./scripts/custom_game/keybinds/targeting.js .initialize_targeting_think */
/*! other exports [not provided] [no usage info] */
/*! runtime requirements: __webpack_require__, __webpack_exports__, __webpack_require__.d, __webpack_require__.r, __webpack_require__.* */
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "initialize_keybinds": () => /* reexport safe */ _initialize_js__WEBPACK_IMPORTED_MODULE_0__.initialize_keybinds,
/* harmony export */   "initialize_targeting_think": () => /* reexport safe */ _targeting_js__WEBPACK_IMPORTED_MODULE_1__.initialize_targeting_think
/* harmony export */ });
/* harmony import */ var _initialize_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./initialize.js */ "./scripts/custom_game/keybinds/initialize.js");
/* harmony import */ var _targeting_js__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./targeting.js */ "./scripts/custom_game/keybinds/targeting.js");




var ability_keybinds_map = new Map()

function on_target_spawned(event_data)
{
	var entity_index = event_data["entity_index"]
	var origin = Entities.GetAbsOrigin(entity_index);
	var hpOffset = Entities.GetHealthBarOffset(entity_index);
	var wx = Game.WorldToScreenX(origin[0], origin[1], origin[2]+hpOffset);
	var wy = Game.WorldToScreenY(origin[0], origin[1], origin[2]+hpOffset);
	var check = Game.ScreenXYToWorld(wx, wy);

	var root = $.GetContextPanel().GetParent().GetParent().GetParent();
	var test = root.FindChildrenWithClassTraverse("HeroHealthBar")
	var test2 = root.FindChildrenWithClassTraverse("HealthBar")
	var test3 = root.FindChildTraverse("HPBarContainer")
}





/***/ }),

/***/ "./scripts/custom_game/keybinds/initialize.js":
/*!****************************************************!*\
  !*** ./scripts/custom_game/keybinds/initialize.js ***!
  \****************************************************/
/*! namespace exports */
/*! export initialize_keybinds [provided] [no usage info] [missing usage info prevents renaming] */
/*! other exports [not provided] [no usage info] */
/*! runtime requirements: __webpack_require__, __webpack_require__.r, __webpack_exports__, __webpack_require__.d, __webpack_require__.* */
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "initialize_keybinds": () => /* binding */ initialize_keybinds
/* harmony export */ });
/* harmony import */ var _table_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./table.js */ "./scripts/custom_game/keybinds/table.js");
/* harmony import */ var _util_js__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./util.js */ "./scripts/custom_game/keybinds/util.js");



function initialize_keybinds()
{
    for (const property in _table_js__WEBPACK_IMPORTED_MODULE_0__.ability_keybinds)
    {
        Game.AddCommand( 
            "+"+_table_js__WEBPACK_IMPORTED_MODULE_0__.ability_keybinds[property].command, 
            () => { 
                ;(0,_util_js__WEBPACK_IMPORTED_MODULE_1__.cast_keybind)(property)
            }, 
            "",
            0
        )
        Game.CreateCustomKeyBind(_table_js__WEBPACK_IMPORTED_MODULE_0__.ability_keybinds[property].keybind, "+"+_table_js__WEBPACK_IMPORTED_MODULE_0__.ability_keybinds[property].command)
    }

    GameUI.SetMouseCallback( function( eventName, arg ) {
        var CONSUME_EVENT = true;
        var CONTINUE_PROCESSING_EVENT = false;
        if ( GameUI.GetClickBehaviors() !== CLICK_BEHAVIORS.DOTA_CLICK_BEHAVIOR_NONE )
            return CONTINUE_PROCESSING_EVENT;
    
        if ( eventName === "pressed" )
        {
            if ( arg === 0 )
            {
                (0,_util_js__WEBPACK_IMPORTED_MODULE_1__.cast_keybind)("left_mouse")
                return CONSUME_EVENT;
            }
    
            if ( arg === 1 )
            {
                (0,_util_js__WEBPACK_IMPORTED_MODULE_1__.cast_keybind)("right_mouse")
                return CONSUME_EVENT;
            }
    
        }
    
        return CONTINUE_PROCESSING_EVENT;
    } );
}



/***/ }),

/***/ "./scripts/custom_game/keybinds/table.js":
/*!***********************************************!*\
  !*** ./scripts/custom_game/keybinds/table.js ***!
  \***********************************************/
/*! namespace exports */
/*! export ability_keybinds [provided] [no usage info] [missing usage info prevents renaming] */
/*! other exports [not provided] [no usage info] */
/*! runtime requirements: __webpack_require__.r, __webpack_exports__, __webpack_require__.d, __webpack_require__.* */
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "ability_keybinds": () => /* binding */ ability_keybinds
/* harmony export */ });
var ability_keybinds = {

    primary_ability1 : {
        command : "keybind_cast_primary_ability1",
        ability_index : 0
    },

    primary_ability2 : {
        command : "keybind_cast_primary_ability2",
        ability_index : 1
    },

    primary_ability3 : {
        command : "keybind_cast_primary_ability3",
        ability_index : 2
    },

    secondary_ability1 : {
        command : "keybind_cast_secondary_ability1",
        ability_index : 3
    },

    secondary_ability2 : {
        command : "keybind_cast_secondary_ability2",
        ability_index : 4
    },

    ultimate_ability : {
        command : "keybind_cast_ultimate_ability",
        ability_index : 5
    },

    item1 : {
        command : "keybind_cast_item1",
    },

    item2 : {
        command : "keybind_cast_item2",
    },

    item3 : {
        command : "keybind_cast_item3",
    },

    item4 : {
        command : "keybind_cast_item4",
    },

    item5 : {
        command : "keybind_cast_item5",
    },

    item6 : {
        command : "keybind_cast_item6",
    },

    neutral_item : {
        command : "keybind_cast_neutral_item",
    },

    teleport_scroll : {
        command : "keybind_cast_teleport_scroll",
    },

    attack : {
        command : "keybind_cast_attack",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_ATTACK).replace("ALT-", "ALT+"),
        ability_index : 6
    },

    move : {
        command : "keybind_cast_move",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_MOVE).replace("ALT-", "ALT+"),
        ability_index : 7
    },

    stop : {
        command : "keybind_cast_stop",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_STOP).replace("ALT-", "ALT+"),
        ability_index : 8
    },

    quickbuy : {
        command : "keybind_cast_quickbuy",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_PURCHASE_QUICKBUY).replace("ALT-", "ALT+"),
        ability_index : 9
    },

    sticky_buy : {
        command : "keybind_cast_sticky_buy",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_PURCHASE_STICKY).replace("ALT-", "ALT+"),
        ability_index : 10
    },

    open_shop : {
        command : "keybind_cast_open_shop",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_SHOP_TOGGLE).replace("ALT-", "ALT+"),
        ability_index : 11
    },

    deliver_items : {
        command : "keybind_cast_deliver_items",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_COURIER_DELIVER).replace("ALT-", "ALT+"),
        ability_index : 12
    },

    select_hero : {
        command : "keybind_cast_select_hero",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_SELECT).replace("ALT-", "ALT+"),
        ability_index : 13
    },

    select_courier : {
        command : "keybind_cast_select_courier",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_COURIER_SELECT).replace("ALT-", "ALT+"),
        ability_index : 14
    },

    left_mouse : {
        command : "keybind_cast_left_mouse",
        ability_index : 15
    },

    right_mouse : {
        command : "keybind_cast_right_mouse",
        ability_index : 16
    },

    camera_grip : {
        command : "keybind_cast_camera_grip",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CAMERA_GRIP).replace("ALT-", "ALT+"),
        ability_index : 17
    },

    scoreboard : {
        command : "keybind_cast_scoreboard",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_SCOREBOARD_TOGGLE).replace("ALT-", "ALT+"),
        ability_index : 18
    },

    unit1 : {
        command : "keybind_cast_unit1",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP1).replace("ALT-", "ALT+"),
        ability_index : 19
    },

    unit2 : {
        command : "keybind_cast_unit2",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP2).replace("ALT-", "ALT+"),
        ability_index : 20
    },

    unit3 : {
        command : "keybind_cast_unit3",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP3).replace("ALT-", "ALT+"),
        ability_index : 21
    },

    unit4 : {
        command : "keybind_cast_unit4",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP4).replace("ALT-", "ALT+"),
        ability_index : 22
    },

    unit5 : {
        command : "keybind_cast_unit5",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP5).replace("ALT-", "ALT+"),
        ability_index : 23
    },

    unit6 : {
        command : "keybind_cast_unit6",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP6).replace("ALT-", "ALT+"),
        ability_index : 24
    },

    unit7 : {
        command : "keybind_cast_unit7",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP7).replace("ALT-", "ALT+"),
        ability_index : 25
    },

    unit8 : {
        command : "keybind_cast_unit8",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP8).replace("ALT-", "ALT+"),
        ability_index : 26
    },

    unit9 : {
        command : "keybind_cast_unit9",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP9).replace("ALT-", "ALT+"),
        ability_index : 27
    },

    unit10 : {
        command : "keybind_cast_unit10",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP10).replace("ALT-", "ALT+"),
        ability_index : 28
    },

    next_unit : {
        command : "keybind_cast_next_unit",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUPCYCLE).replace("ALT-", "ALT+"),
        ability_index : 29
    },

    prev_unit : {
        command : "keybind_cast_prev_unit",
        keybind : Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUPCYCLEPREV).replace("ALT-", "ALT+"),
        ability_index : 30
    },

}

/***/ }),

/***/ "./scripts/custom_game/keybinds/targeting.js":
/*!***************************************************!*\
  !*** ./scripts/custom_game/keybinds/targeting.js ***!
  \***************************************************/
/*! namespace exports */
/*! export get_mouse_cast_position [provided] [no usage info] [missing usage info prevents renaming] */
/*! export get_mouse_cast_target [provided] [no usage info] [missing usage info prevents renaming] */
/*! export initialize_targeting_think [provided] [no usage info] [missing usage info prevents renaming] */
/*! export on_target_blur [provided] [no usage info] [missing usage info prevents renaming] */
/*! export on_target_focus [provided] [no usage info] [missing usage info prevents renaming] */
/*! export on_think [provided] [no usage info] [missing usage info prevents renaming] */
/*! other exports [not provided] [no usage info] */
/*! runtime requirements: __webpack_require__.r, __webpack_exports__, __webpack_require__.d, __webpack_require__.* */
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "get_mouse_cast_position": () => /* binding */ get_mouse_cast_position,
/* harmony export */   "get_mouse_cast_target": () => /* binding */ get_mouse_cast_target,
/* harmony export */   "on_target_focus": () => /* binding */ on_target_focus,
/* harmony export */   "on_target_blur": () => /* binding */ on_target_blur,
/* harmony export */   "on_think": () => /* binding */ on_think,
/* harmony export */   "initialize_targeting_think": () => /* binding */ initialize_targeting_think
/* harmony export */ });
function get_mouse_cast_position()
{
    return GameUI.GetScreenWorldPosition( GameUI.GetCursorPosition() )
}

function get_mouse_cast_target()
{
	var mouseEntities = GameUI.FindScreenEntities( GameUI.GetCursorPosition() );
	var localHeroIndex = Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() );
	mouseEntities = mouseEntities.filter( function(entity) { return entity.entityIndex !== localHeroIndex; } );
	
	for ( var entity of mouseEntities )
	{
		if ( !entity.accurateCollision )
			continue;
		return entity.entityIndex;
	}

	for ( var entity of mouseEntities )
	{
		return entity.entityIndex;
	}

	return -1;
}

function on_target_focus(entity_index)
{
	GameEvents.SendCustomGameEventToServer( "on_target_focus", {"entity_index":entity_index} )
}

function on_target_blur(entity_index)
{
	GameEvents.SendCustomGameEventToServer( "on_target_blur", {"entity_index":entity_index} )
}

let old_mouse_target = -1
function on_think()
{
	let new_mouse_target = get_mouse_cast_target()
	if (old_mouse_target != new_mouse_target)
	{
		if (old_mouse_target != -1)
			on_target_blur(old_mouse_target)

		if (new_mouse_target != -1)
			on_target_focus(new_mouse_target)
	}
		
	old_mouse_target = new_mouse_target

	$.Schedule( 0.1, on_think )
}

function initialize_targeting_think()
{
	$.Schedule( 0.0, on_think )
}

/***/ }),

/***/ "./scripts/custom_game/keybinds/util.js":
/*!**********************************************!*\
  !*** ./scripts/custom_game/keybinds/util.js ***!
  \**********************************************/
/*! namespace exports */
/*! export cast_keybind [provided] [no usage info] [missing usage info prevents renaming] */
/*! other exports [not provided] [no usage info] */
/*! runtime requirements: __webpack_require__, __webpack_require__.r, __webpack_exports__, __webpack_require__.d, __webpack_require__.* */
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

__webpack_require__.r(__webpack_exports__);
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "cast_keybind": () => /* binding */ cast_keybind
/* harmony export */ });
/* harmony import */ var _table_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./table.js */ "./scripts/custom_game/keybinds/table.js");
/* harmony import */ var _targeting__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./targeting */ "./scripts/custom_game/keybinds/targeting.js");




function cast_keybind(keybind)
{
    $.Msg("casting: ", keybind)
	var order = {
		AbilityIndex : Entities.GetAbility( Players.GetPlayerHeroEntityIndex( Players.GetLocalPlayer() ), _table_js__WEBPACK_IMPORTED_MODULE_0__.ability_keybinds[keybind].ability_index),
		QueueBehavior : OrderQueueBehavior_t.DOTA_ORDER_QUEUE_NEVER,
		ShowEffects : false,
		OrderType : dotaunitorder_t.DOTA_UNIT_ORDER_CAST_NO_TARGET
    };
    
    var abilityBehavior = Abilities.GetBehavior( order.AbilityIndex );
    var target_entity_index = (0,_targeting__WEBPACK_IMPORTED_MODULE_1__.get_mouse_cast_target)();

	if ( abilityBehavior & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_POINT )
	{
        order.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_CAST_POSITION;
		order.Position = (0,_targeting__WEBPACK_IMPORTED_MODULE_1__.get_mouse_cast_position)();
    }
    if ( ( abilityBehavior & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET ) && ( target_entity_index !== -1 ) )
    {
        order.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TARGET;
        order.TargetIndex = target_entity_index;
    }
	Game.PrepareUnitOrders( order );
}



/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		if(__webpack_module_cache__[moduleId]) {
/******/ 			return __webpack_module_cache__[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId](module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
/******/ 	/* webpack/runtime/define property getters */
/******/ 	(() => {
/******/ 		// define getter functions for harmony exports
/******/ 		__webpack_require__.d = (exports, definition) => {
/******/ 			for(var key in definition) {
/******/ 				if(__webpack_require__.o(definition, key) && !__webpack_require__.o(exports, key)) {
/******/ 					Object.defineProperty(exports, key, { enumerable: true, get: definition[key] });
/******/ 				}
/******/ 			}
/******/ 		};
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/hasOwnProperty shorthand */
/******/ 	(() => {
/******/ 		__webpack_require__.o = (obj, prop) => Object.prototype.hasOwnProperty.call(obj, prop)
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/make namespace object */
/******/ 	(() => {
/******/ 		// define __esModule on exports
/******/ 		__webpack_require__.r = (exports) => {
/******/ 			if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 				Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 			}
/******/ 			Object.defineProperty(exports, '__esModule', { value: true });
/******/ 		};
/******/ 	})();
/******/ 	
/************************************************************************/
/******/ 	// startup
/******/ 	// Load entry module
/******/ 	__webpack_require__("./scripts/custom_game/index.js");
/******/ 	// This entry module used 'exports' so it can't be inlined
/******/ })()
;