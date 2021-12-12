modifier_candy_yellow = class({})

function modifier_candy_yellow:IsHidden() return false end
function modifier_candy_yellow:IsPurgable() return false end
function modifier_candy_yellow:RemoveOnDeath() return false end
function modifier_candy_yellow:IsPermanent() return true end

function modifier_candy_yellow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
	return funcs
end

function modifier_candy_yellow:GetModifierPhysicalArmorBonus()
	return self:GetStackCount()
end