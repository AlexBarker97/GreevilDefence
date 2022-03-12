modifier_tower = class({})

function modifier_tower:IsHidden() return true end
function modifier_tower:IsPurgable() return false end
function modifier_tower:RemoveOnDeath() return false end
function modifier_tower:IsPermanent() return true end

function modifier_tower:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MODEL_CHANGE
	}
	return funcs
end

function modifier_tower:GetModifierAttackSpeedBonus_Constant()
	return 100
end

function modifier_tower:GetModifierModelChange()
	return "models/items/invoker/forge_spirit/covenant_of_the_depths_deep_forged/covenant_of_the_depths_deep_forged.vmdl"
end