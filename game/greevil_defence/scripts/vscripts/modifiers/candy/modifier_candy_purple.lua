modifier_candy_purple = class({})

function modifier_candy_purple:IsHidden() return false end
function modifier_candy_purple:IsPurgable() return false end
function modifier_candy_purple:RemoveOnDeath() return false end
function modifier_candy_purple:IsPermanent() return true end

function modifier_candy_purple:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
	return funcs
end

function modifier_candy_purple:GetModifierSpellAmplify_Percentage()
	return self:GetStackCount()
end