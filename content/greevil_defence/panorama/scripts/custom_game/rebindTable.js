let select = "key_" + Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_SELECT);
$.Msg("SelectHeroBind: " + select);
$.RegisterKeyBind($.GetContextPanel(), select, function () {
    $.Msg("Select Hero pressed");
});