item_heal = class({})

function item_heal:OnSpellStart()
    local caster = self:GetCaster()
    
	local currentHP = caster:GetHealth()
	local maxHP = caster:GetMaxHealth()
	if (currentHP + 100) > maxHP then
		caster:SetHealth(maxHP)
	else
		caster:SetHealth(currentHP + 100)
	end
	self:SpendCharge()
	EmitSoundOn("DOTA_Item.FaerieSpark.Activate", caster)
end