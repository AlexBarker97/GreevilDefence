import {initialize_keybinds, initialize_targeting_think} from "./keybinds/index.js"

initialize_keybinds()
initialize_targeting_think()

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

