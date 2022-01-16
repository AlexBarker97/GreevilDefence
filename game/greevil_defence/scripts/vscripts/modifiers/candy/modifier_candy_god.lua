modifier_candy_god = class({})

function modifier_candy_god:IsHidden() return false end
function modifier_candy_god:IsPurgable() return false end
function modifier_candy_god:RemoveOnDeath() return false end
function modifier_candy_god:IsPermanent() return true end

function modifier_candy_god:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
	return funcs
end

function modifier_candy_god:GetModifierPreAttack_BonusDamage()
	return self:GetStackCount()
end

function modifier_candy_god:GetModifierStatusResistanceStacking()
	return self:GetStackCount()
end

function modifier_candy_god:GetModifierPhysicalArmorBonus()
	return self:GetStackCount()
end

function modifier_candy_god:GetModifierConstantHealthRegen()
	return self:GetStackCount()
end

function modifier_candy_god:GetModifierConstantManaRegen()
	return self:GetStackCount()
end

function modifier_candy_god:GetModifierSpellAmplify_Percentage()
	return self:GetStackCount()
end

function modifier_candy_god:GetModifierMoveSpeedBonus_Constant()
	return self:GetStackCount()
end

function modifier_candy_god:GetModifierMagicalResistanceBonus()
	return self:GetStackCount()
end