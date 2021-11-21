local REGEN_TICK_RATE = 0.05
local HEAL_AMOUNT = 12
local MANA_AMOUNT = 8

function ShrineTrigger(trigger)
    local ent = trigger.activator
    if not ent then return end

    local HP = ent:GetHealth()
    local MP = ent:GetMana()
    ent:SetHealth(HP + HEAL_AMOUNT)
    ent:SetMana(MP + MANA_AMOUNT)

    return REGEN_TICK_RATE
end