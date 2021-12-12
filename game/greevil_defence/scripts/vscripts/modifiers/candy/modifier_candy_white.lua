modifier_candy_white = class({})

function modifier_candy_white:IsHidden() return false end
function modifier_candy_white:IsPurgable() return false end
function modifier_candy_white:RemoveOnDeath() return false end
function modifier_candy_white:IsPermanent() return true end

function modifier_candy_white:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
	}
	return funcs
end

function modifier_candy_white:GetModifierMoveSpeedBonus_Constant()
	return self:GetStackCount()
end