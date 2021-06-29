item_heal = class({})

function item_heal:OnSpellStart()
    local caster = self:GetCaster()
    
	local currentHP = caster:GetHealth()
	local maxHP = caster:GetMaxHealth()
	if (currentHP + 200) > maxHP then
		caster:SetHealth(maxHP)
	else
		caster:SetHealth(currentHP + 200)
	end
	self:SpendCharge()
	EmitSoundOn("DOTA_Item.FaerieSpark.Activate", caster)
end