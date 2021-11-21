lifeline_lua = class({})

function lifeline_lua:OnDestroy()
	ApplyDamage({
	victim = self:GetParent(),
	attacker = self:GetCaster(),
	damage = 99999,
	damage_type = DAMAGE_TYPE_PURE,
	})
end

function lifeline_lua:IsHidden()
	return true
end