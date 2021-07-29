$.Msg("test123456");
let select = Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_HERO_SELECT);
$.Msg(select);
$.RegisterKeyBind($.GetContextPanel(), select, function () {
    $.Msg("Select Hero pressed");
});