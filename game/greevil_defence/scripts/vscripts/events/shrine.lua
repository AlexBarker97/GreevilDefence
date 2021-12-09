function ShrineTrigger(trigger)
    local ent = trigger.activator
    if not ent then return end
    ent:AddNewModifier(ent, nil, "modifier_fountain_aura_buff", {})
    EmitSoundOn("Shrine.Cast", ent)
end

function ShrineExitTrigger(trigger)
    local ent = trigger.activator
    if not ent then return end
    ent:RemoveModifierByName("modifier_fountain_aura_buff")
end