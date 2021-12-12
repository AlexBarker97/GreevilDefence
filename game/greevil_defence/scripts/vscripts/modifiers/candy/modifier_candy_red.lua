modifier_candy_red = class({})

function modifier_candy_red:IsHidden() return false end
function modifier_candy_red:IsPurgable() return false end
function modifier_candy_red:RemoveOnDeath() return false end
function modifier_candy_red:IsPermanent() return true end

function modifier_candy_red:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
	return funcs
end

function modifier_candy_red:GetModifierPreAttack_BonusDamage()
	return self:GetStackCount()
end