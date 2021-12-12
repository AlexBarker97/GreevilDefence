modifier_candy_orange = class({})

function modifier_candy_orange:IsHidden() return false end
function modifier_candy_orange:IsPurgable() return false end
function modifier_candy_orange:RemoveOnDeath() return false end
function modifier_candy_orange:IsPermanent() return true end

function modifier_candy_orange:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
	}
	return funcs
end

function modifier_candy_orange:GetModifierStatusResistanceStacking()
	return self:GetStackCount()
end