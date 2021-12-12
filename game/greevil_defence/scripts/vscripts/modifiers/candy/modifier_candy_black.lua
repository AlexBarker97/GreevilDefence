modifier_candy_black = class({})

function modifier_candy_black:IsHidden() return false end
function modifier_candy_black:IsPurgable() return false end
function modifier_candy_black:RemoveOnDeath() return false end
function modifier_candy_black:IsPermanent() return true end

function modifier_candy_black:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
	return funcs
end

function modifier_candy_black:GetModifierMagicalResistanceBonus()
	return self:GetStackCount()
end