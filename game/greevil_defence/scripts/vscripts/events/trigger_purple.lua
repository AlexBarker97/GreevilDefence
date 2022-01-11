function boxtrigger(trigger) 
        local trigUnit = trigger.activator
        if not trigUnit then return end
        local trigUnitOrigin = trigUnit:GetAbsOrigin()
        local BossSearch = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, trigUnitOrigin, nil, 8000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
        local HeroSearch = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, trigUnitOrigin, nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
        
        local tBoxList = Entities:FindAllByName("trigger_rad_purple")
        local tBox = tBoxList[1]
        local tBoxOrigin = tBox:GetAbsOrigin()
        local tBoxMin = tBox:GetBoundingMins()
        local tBoxMax = tBox:GetBoundingMaxs()
        local tBoxAbsMin = tBoxOrigin + tBoxMin
        local tBoxAbsMax = tBoxOrigin + tBoxMax

        local heroes = 0
        for i=1,#HeroSearch do
            local heroAbsPos = HeroSearch[i]:GetAbsOrigin()
            if HeroSearch[i]:GetUnitName() == "npc_dota_hero_beastmaster" then
                if ((heroAbsPos.x >= tBoxAbsMin.x and heroAbsPos.y >= tBoxAbsMin.y) and 
                    (heroAbsPos.x <= tBoxAbsMax.x and heroAbsPos.y <= tBoxAbsMax.y)) then
                    heroes = heroes + 1
                end
            end
		end

        for i=1,#BossSearch do
            if BossSearch[i]:GetUnitName() == "greevil_purple" and heroes == 0 then
                local ability1 = BossSearch[i]:GetAbilityByIndex(0)
                local ability2 = BossSearch[i]:GetAbilityByIndex(1)
                local ability3 = BossSearch[i]:GetAbilityByIndex(2)
                local ability4 = BossSearch[i]:GetAbilityByIndex(3)
                ability1:EndCooldown()
                ability2:EndCooldown()
                ability3:EndCooldown()
                ability4:EndCooldown()
                BossSearch[i]:AddNewModifier(BossSearch[i], nil, "modifier_rune_regen", {duration = 30.0})
            end
		end
    return 1
end