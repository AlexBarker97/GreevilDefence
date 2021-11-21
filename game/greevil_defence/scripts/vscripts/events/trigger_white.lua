function boxtrigger(trigger) 
        local trigUnit = trigger.activator
        if not trigUnit then return end
        local trigUnitOrigin = trigUnit:GetAbsOrigin()
        local BossSearch = FindUnitsInRadius(DOTA_TEAM_NEUTRALS, trigUnitOrigin, nil, 8000, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
        local HeroSearch = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, trigUnitOrigin, nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
        
        local tBoxList = Entities:FindAllByName("trigger_rad_white")
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
            local bossName = BossSearch[i]:GetUnitName()
            if heroes == 0 then
                if bossName == "greevil_white_red" or
                bossName == "greevil_white_orange" or  
                bossName == "greevil_white_yellow" or  
                bossName == "greevil_white_green" or  
                bossName == "greevil_white_blue" or  
                bossName == "greevil_white_purple" then
                    BossSearch[i]:ForceKill(false)

                elseif bossName == "greevil_white" then
                    local ability1 = BossSearch[i]:GetAbilityByIndex(0)  
                    local ability2 = BossSearch[i]:GetAbilityByIndex(1)  
                    local ability3 = BossSearch[i]:GetAbilityByIndex(2)  
                    local ability4 = BossSearch[i]:GetAbilityByIndex(3)  
                    local ability5 = BossSearch[i]:GetAbilityByIndex(4)  
                    local ability6 = BossSearch[i]:GetAbilityByIndex(5)  
                    local ability7 = BossSearch[i]:GetAbilityByIndex(6)  
                    local ability8 = BossSearch[i]:GetAbilityByIndex(7)  
                    ability1:EndCooldown()
                    ability2:EndCooldown()
                    ability3:EndCooldown()
                    ability4:EndCooldown()
                    ability5:EndCooldown()
                    ability6:EndCooldown()
                    ability7:EndCooldown()
                    ability8:EndCooldown()
                    BossSearch[i]:AddNewModifier(BossSearch[i], nil, "modifier_rune_regen", {duration = 30.0})
                end
            end
		end
    return 1
end