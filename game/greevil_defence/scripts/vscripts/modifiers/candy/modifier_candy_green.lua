modifier_candy_green = class({})

function modifier_candy_green:IsHidden() return false end
function modifier_candy_green:IsPurgable() return false end
function modifier_candy_green:RemoveOnDeath() return false end
function modifier_candy_green:IsPermanent() return true end

function modifier_candy_green:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}
	return funcs
end

function modifier_candy_green:GetModifierConstantHealthRegen()
	return self:GetStackCount()
end