item_mana = class({})

function item_mana:OnSpellStart()
    local caster = self:GetCaster()
    
	local currentMP = caster:GetMana()
	local maxMP = caster:GetMaxMana()
	if (currentMP + 100) > maxMP then
		caster:SetMana(maxMP)
	else
		caster:SetMana(currentMP + 100)
	end
	self:SpendCharge()
	EmitSoundOn("DOTA_Item.Mango.Activate", caster)
end