transformation_mod = class({})

function transformation_mod:DeclareFunctions()
    local funcs = 	{
					MODIFIER_PROPERTY_MODEL_SCALE,
					MODIFIER_STATE_INVULNERABLE,
					MODIFIER_STATE_UNSELECTABLE,
					MODIFIER_STATE_NO_UNIT_COLLISION
					}
    return funcs
end

function transformation_mod:GetModifierModelScale()
    return 1
end

function transformation_mod:CheckState()
	local state = {}
	state[MODIFIER_STATE_MAGIC_IMMUNE] = true
	state[MODIFIER_STATE_INVULNERABLE] = true
	state[MODIFIER_STATE_OUT_OF_GAME] = false
	state[MODIFIER_STATE_STUNNED] = true
	state[MODIFIER_STATE_UNSELECTABLE] = true
	state[MODIFIER_STATE_NO_HEALTH_BAR] = true
	state[MODIFIER_STATE_NO_UNIT_COLLISION] = true
	return state
end