lifeline_lua = class({})

function lifeline_lua:OnDestroy()
	ApplyDamage({
	victim = self:GetParent(),
	attacker = self:GetCaster(),
	damage = self:GetParent():GetHealth(),
	damage_type = DAMAGE_TYPE_PURE,
	})
end

function lifeline_lua:IsHidden()
	return true
end