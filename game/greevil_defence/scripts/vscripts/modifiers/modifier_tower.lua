modifier_tower = class({})

function modifier_tower:IsHidden() return true end
function modifier_tower:IsPurgable() return false end
function modifier_tower:RemoveOnDeath() return true end
function modifier_tower:IsPermanent() return false end

function modifier_tower:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BASE_OVERRIDE,
		MODIFIER_PROPERTY_MODEL_CHANGE
	}
	return funcs
end

function modifier_tower:GetModifierAttackSpeedBaseOverride()
	return 1.8
end

function modifier_tower:GetModifierModelChange()
	return "models/items/invoker/forge_spirit/covenant_of_the_depths_deep_forged/covenant_of_the_depths_deep_forged.vmdl"
end