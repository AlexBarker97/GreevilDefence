modifier_tower = class({})

function modifier_tower:IsHidden() return true end
function modifier_tower:IsPurgable() return false end
function modifier_tower:RemoveOnDeath() return false end
function modifier_tower:IsPermanent() return true end

function modifier_tower:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
	return funcs
end

function modifier_tower:GetModifierAttackSpeedBonus_Constant()
	return 100
end