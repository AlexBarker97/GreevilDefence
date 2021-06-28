modifier_greevil_boss_sres = class({})

function modifier_greevil_boss_sres:IsHidden() return false end
function modifier_greevil_boss_sres:IsPurgable() return false end
function modifier_greevil_boss_sres:RemoveOnDeath() return true end
function modifier_greevil_boss_sres:IsPermanent() return true end

function modifier_greevil_boss_sres:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATUS_RESISTANCE
	}
return funcs
end

function modifier_greevil_boss_sres:GetModifierStatusResistance()
	return 40
end


function modifier_greevil_boss_sres:OnCreated()
	--print("Created")
end

function modifier_greevil_boss_sres:OnDestroy()
	--print("Destroyed")
end
