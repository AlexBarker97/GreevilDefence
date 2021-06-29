item_mana = class({})

function item_mana:OnSpellStart()
    local caster = self:GetCaster()
    
	local currentMP = caster:GetMana()
	local maxMP = caster:GetMaxMana()
	if (currentMP + 200) > maxMP then
		caster:SetMana(maxMP)
	else
		caster:SetMana(currentMP + 200)
	end
	self:SpendCharge()
	EmitSoundOn("DOTA_Item.Mango.Activate", caster)
end