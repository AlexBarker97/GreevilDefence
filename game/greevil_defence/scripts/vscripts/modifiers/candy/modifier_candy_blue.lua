modifier_candy_blue = class({})

function modifier_candy_blue:IsHidden() return false end
function modifier_candy_blue:IsPurgable() return false end
function modifier_candy_blue:RemoveOnDeath() return false end
function modifier_candy_blue:IsPermanent() return true end

function modifier_candy_blue:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
	}
	return funcs
end

function modifier_candy_blue:GetModifierConstantManaRegen()
	return self:GetStackCount()
end