modifier_farm = class({})

function modifier_farm:IsHidden() return true end
function modifier_farm:IsPurgable() return false end
function modifier_farm:RemoveOnDeath() return true end
function modifier_farm:IsPermanent() return true end

function modifier_farm:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS 
	}
	return funcs
end

function modifier_farm:GetModifierModelChange()
	return "models/props_gameplay/gold_coin001b.vmdl"
end

function modifier_farm:GetModifierExtraHealthBonus()
	return 300
end