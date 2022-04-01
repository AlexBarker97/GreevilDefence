choose_ab = class({})

function ab1Rand(event)
	local caster = event.caster

	caster:RemoveAbility(abLookup(caster)[1])
	caster:RemoveAbility(abLookup(caster)[2])
	caster:RemoveAbility(abLookup(caster)[3])
	caster:RemoveAbility("generic_hidden")
	caster:RemoveAbility("greevil_overload_custom")
	caster:RemoveAbility("greevil_guardian_angel_custom")
	caster:AddAbility("greevil_choice_SB")
	caster:AddAbility("greevil_choice_GR")
	caster:AddAbility("greevil_choice_Pen")
	caster:AddAbility("greevil_choice_SS")
	caster:AddAbility("greevil_choice_MM")
	caster:AddAbility("greevil_choice_SE")
	caster:UpgradeAbility(caster:GetAbilityByIndex(0))
	caster:UpgradeAbility(caster:GetAbilityByIndex(1))
	caster:UpgradeAbility(caster:GetAbilityByIndex(2))
	caster:UpgradeAbility(caster:GetAbilityByIndex(3))
	caster:UpgradeAbility(caster:GetAbilityByIndex(4))
	caster:UpgradeAbility(caster:GetAbilityByIndex(5))

end

function ab2Rand(event)
	local caster = event.caster

	caster:RemoveAbility(abLookup(caster)[1])
	caster:RemoveAbility(abLookup(caster)[2])
	caster:RemoveAbility(abLookup(caster)[3])
	caster:RemoveAbility("generic_hidden")
	caster:RemoveAbility("greevil_overload_custom")
	caster:RemoveAbility("greevil_guardian_angel_custom")
	caster:AddAbility("greevil_choice_TT")
	caster:AddAbility("greevil_choice_OG")
	caster:AddAbility("greevil_choice_FA")
	caster:AddAbility("greevil_choice_DP")
	caster:AddAbility("greevil_choice_SC")
	caster:AddAbility("greevil_choice_S")
	caster:UpgradeAbility(caster:GetAbilityByIndex(0))
	caster:UpgradeAbility(caster:GetAbilityByIndex(1))
	caster:UpgradeAbility(caster:GetAbilityByIndex(2))
	caster:UpgradeAbility(caster:GetAbilityByIndex(3))
	caster:UpgradeAbility(caster:GetAbilityByIndex(4))
	caster:UpgradeAbility(caster:GetAbilityByIndex(5))

end

function ab3Rand(event)
	local caster = event.caster

	caster:RemoveAbility(abLookup(caster)[1])
	caster:RemoveAbility(abLookup(caster)[2])
	caster:RemoveAbility(abLookup(caster)[3])
	caster:RemoveAbility("generic_hidden")
	caster:RemoveAbility("greevil_overload_custom")
	caster:RemoveAbility("greevil_guardian_angel_custom")
	caster:AddAbility("greevil_choice_NA")
	caster:AddAbility("greevil_choice_PN")
	caster:AddAbility("greevil_choice_IH")
	caster:AddAbility("greevil_choice_GT")
	caster:AddAbility("greevil_choice_NO")
	caster:AddAbility("greevil_choice_AS")
	caster:UpgradeAbility(caster:GetAbilityByIndex(0))
	caster:UpgradeAbility(caster:GetAbilityByIndex(1))
	caster:UpgradeAbility(caster:GetAbilityByIndex(2))
	caster:UpgradeAbility(caster:GetAbilityByIndex(3))
	caster:UpgradeAbility(caster:GetAbilityByIndex(4))
	caster:UpgradeAbility(caster:GetAbilityByIndex(5))

end







function ab1SB(event)
	local caster = event.caster

	caster.ab1 = "SB"

	caster:RemoveAbility("greevil_choice_SB")
	caster:RemoveAbility("greevil_choice_GR")
	caster:RemoveAbility("greevil_choice_Pen")
	caster:RemoveAbility("greevil_choice_SS")
	caster:RemoveAbility("greevil_choice_MM")
	caster:RemoveAbility("greevil_choice_SE")

	caster:AddAbility(abLookup(caster)[1])
	caster:AddAbility(abLookup(caster)[2])
	caster:AddAbility(abLookup(caster)[3])
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_overload_custom")
	caster:AddAbility("greevil_guardian_angel_custom")
	caster:SetAbilityPoints(0)
	allAbilities(caster)

end
function ab1GR(event)
	local caster = event.caster

	caster.ab1 = "GR"

	caster:RemoveAbility("greevil_choice_SB")
	caster:RemoveAbility("greevil_choice_GR")
	caster:RemoveAbility("greevil_choice_Pen")
	caster:RemoveAbility("greevil_choice_SS")
	caster:RemoveAbility("greevil_choice_MM")
	caster:RemoveAbility("greevil_choice_SE")

	caster:AddAbility(abLookup(caster)[1])
	caster:AddAbility(abLookup(caster)[2])
	caster:AddAbility(abLookup(caster)[3])
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_overload_custom")
	caster:AddAbility("greevil_guardian_angel_custom")
	caster:SetAbilityPoints(0)
	allAbilities(caster)

end
function ab1Pen(event)
	local caster = event.caster

	caster.ab1 = "Pen"

	caster:RemoveAbility("greevil_choice_SB")
	caster:RemoveAbility("greevil_choice_GR")
	caster:RemoveAbility("greevil_choice_Pen")
	caster:RemoveAbility("greevil_choice_SS")
	caster:RemoveAbility("greevil_choice_MM")
	caster:RemoveAbility("greevil_choice_SE")

	caster:AddAbility(abLookup(caster)[1])
	caster:AddAbility(abLookup(caster)[2])
	caster:AddAbility(abLookup(caster)[3])
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_overload_custom")
	caster:AddAbility("greevil_guardian_angel_custom")
	caster:SetAbilityPoints(0)
	allAbilities(caster)

end
function ab1SS(event)
	local caster = event.caster

	caster.ab1 = "SS"

	caster:RemoveAbility("greevil_choice_SB")
	caster:RemoveAbility("greevil_choice_GR")
	caster:RemoveAbility("greevil_choice_Pen")
	caster:RemoveAbility("greevil_choice_SS")
	caster:RemoveAbility("greevil_choice_MM")
	caster:RemoveAbility("greevil_choice_SE")

	caster:AddAbility(abLookup(caster)[1])
	caster:AddAbility(abLookup(caster)[2])
	caster:AddAbility(abLookup(caster)[3])
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_overload_custom")
	caster:AddAbility("greevil_guardian_angel_custom")
	caster:SetAbilityPoints(0)
	allAbilities(caster)

end
function ab1MM(event)
	local caster = event.caster

	caster.ab1 = "MM"

	caster:RemoveAbility("greevil_choice_SB")
	caster:RemoveAbility("greevil_choice_GR")
	caster:RemoveAbility("greevil_choice_Pen")
	caster:RemoveAbility("greevil_choice_SS")
	caster:RemoveAbility("greevil_choice_MM")
	caster:RemoveAbility("greevil_choice_SE")

	caster:AddAbility(abLookup(caster)[1])
	caster:AddAbility(abLookup(caster)[2])
	caster:AddAbility(abLookup(caster)[3])
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_overload_custom")
	caster:AddAbility("greevil_guardian_angel_custom")
	caster:SetAbilityPoints(0)
	allAbilities(caster)

end
function ab1SE(event)
	local caster = event.caster

	caster.ab1 = "SE"

	caster:RemoveAbility("greevil_choice_SB")
	caster:RemoveAbility("greevil_choice_GR")
	caster:RemoveAbility("greevil_choice_Pen")
	caster:RemoveAbility("greevil_choice_SS")
	caster:RemoveAbility("greevil_choice_MM")
	caster:RemoveAbility("greevil_choice_SE")

	caster:AddAbility(abLookup(caster)[1])
	caster:AddAbility(abLookup(caster)[2])
	caster:AddAbility(abLookup(caster)[3])
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_overload_custom")
	caster:AddAbility("greevil_guardian_angel_custom")
	caster:SetAbilityPoints(0)
	allAbilities(caster)

end














function ab1TT(event)
	local caster = event.caster

	caster.ab2 = "TT"

	caster:RemoveAbility("greevil_choice_TT")
	caster:RemoveAbility("greevil_choice_OG")
	caster:RemoveAbility("greevil_choice_FA")
	caster:RemoveAbility("greevil_choice_DP")
	caster:RemoveAbility("greevil_choice_SC")
	caster:RemoveAbility("greevil_choice_S")

	caster:AddAbility(abLookup(caster)[1])
	caster:AddAbility(abLookup(caster)[2])
	caster:AddAbility(abLookup(caster)[3])
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_overload_custom")
	caster:AddAbility("greevil_guardian_angel_custom")
	caster:SetAbilityPoints(0)
	allAbilities(caster)

end
function ab1OG(event)
	local caster = event.caster

	caster.ab2 = "OG"

	caster:RemoveAbility("greevil_choice_TT")
	caster:RemoveAbility("greevil_choice_OG")
	caster:RemoveAbility("greevil_choice_FA")
	caster:RemoveAbility("greevil_choice_DP")
	caster:RemoveAbility("greevil_choice_SC")
	caster:RemoveAbility("greevil_choice_S")

	caster:AddAbility(abLookup(caster)[1])
	caster:AddAbility(abLookup(caster)[2])
	caster:AddAbility(abLookup(caster)[3])
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_overload_custom")
	caster:AddAbility("greevil_guardian_angel_custom")
	caster:SetAbilityPoints(0)
	allAbilities(caster)

end
function ab1FA(event)
	local caster = event.caster

	caster.ab2 = "FA"

	caster:RemoveAbility("greevil_choice_TT")
	caster:RemoveAbility("greevil_choice_OG")
	caster:RemoveAbility("greevil_choice_FA")
	caster:RemoveAbility("greevil_choice_DP")
	caster:RemoveAbility("greevil_choice_SC")
	caster:RemoveAbility("greevil_choice_S")

	caster:AddAbility(abLookup(caster)[1])
	caster:AddAbility(abLookup(caster)[2])
	caster:AddAbility(abLookup(caster)[3])
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_overload_custom")
	caster:AddAbility("greevil_guardian_angel_custom")
	caster:SetAbilityPoints(0)
	allAbilities(caster)

end
function ab1DP(event)
	local caster = event.caster

	caster.ab2 = "DP"

	caster:RemoveAbility("greevil_choice_TT")
	caster:RemoveAbility("greevil_choice_OG")
	caster:RemoveAbility("greevil_choice_FA")
	caster:RemoveAbility("greevil_choice_DP")
	caster:RemoveAbility("greevil_choice_SC")
	caster:RemoveAbility("greevil_choice_S")

	caster:AddAbility(abLookup(caster)[1])
	caster:AddAbility(abLookup(caster)[2])
	caster:AddAbility(abLookup(caster)[3])
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_overload_custom")
	caster:AddAbility("greevil_guardian_angel_custom")
	caster:SetAbilityPoints(0)
	allAbilities(caster)

end
function ab1SC(event)
	local caster = event.caster

	caster.ab2 = "SC"

	caster:RemoveAbility("greevil_choice_TT")
	caster:RemoveAbility("greevil_choice_OG")
	caster:RemoveAbility("greevil_choice_FA")
	caster:RemoveAbility("greevil_choice_DP")
	caster:RemoveAbility("greevil_choice_SC")
	caster:RemoveAbility("greevil_choice_S")

	caster:AddAbility(abLookup(caster)[1])
	caster:AddAbility(abLookup(caster)[2])
	caster:AddAbility(abLookup(caster)[3])
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_overload_custom")
	caster:AddAbility("greevil_guardian_angel_custom")
	caster:SetAbilityPoints(0)
	allAbilities(caster)

end
function ab1S(event)
	local caster = event.caster

	caster.ab2 = "S"

	caster:RemoveAbility("greevil_choice_TT")
	caster:RemoveAbility("greevil_choice_OG")
	caster:RemoveAbility("greevil_choice_FA")
	caster:RemoveAbility("greevil_choice_DP")
	caster:RemoveAbility("greevil_choice_SC")
	caster:RemoveAbility("greevil_choice_S")

	caster:AddAbility(abLookup(caster)[1])
	caster:AddAbility(abLookup(caster)[2])
	caster:AddAbility(abLookup(caster)[3])
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_overload_custom")
	caster:AddAbility("greevil_guardian_angel_custom")
	caster:SetAbilityPoints(0)
	allAbilities(caster)

end










function ab1NA(event)
	local caster = event.caster

	caster.ab3 = "NA"

	caster:RemoveAbility("greevil_choice_NA")
	caster:RemoveAbility("greevil_choice_PN")
	caster:RemoveAbility("greevil_choice_IH")
	caster:RemoveAbility("greevil_choice_GT")
	caster:RemoveAbility("greevil_choice_NO")
	caster:RemoveAbility("greevil_choice_AS")

	caster:AddAbility(abLookup(caster)[1])
	caster:AddAbility(abLookup(caster)[2])
	caster:AddAbility(abLookup(caster)[3])
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_overload_custom")
	caster:AddAbility("greevil_guardian_angel_custom")
	caster:SetAbilityPoints(0)
	allAbilities(caster)

end
function ab1PN(event)
	local caster = event.caster

	caster.ab3 = "PN"

	caster:RemoveAbility("greevil_choice_NA")
	caster:RemoveAbility("greevil_choice_PN")
	caster:RemoveAbility("greevil_choice_IH")
	caster:RemoveAbility("greevil_choice_GT")
	caster:RemoveAbility("greevil_choice_NO")
	caster:RemoveAbility("greevil_choice_AS")

	caster:AddAbility(abLookup(caster)[1])
	caster:AddAbility(abLookup(caster)[2])
	caster:AddAbility(abLookup(caster)[3])
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_overload_custom")
	caster:AddAbility("greevil_guardian_angel_custom")
	caster:SetAbilityPoints(0)
	allAbilities(caster)

end
function ab1IH(event)
	local caster = event.caster

	caster.ab3 = "IH"

	caster:RemoveAbility("greevil_choice_NA")
	caster:RemoveAbility("greevil_choice_PN")
	caster:RemoveAbility("greevil_choice_IH")
	caster:RemoveAbility("greevil_choice_GT")
	caster:RemoveAbility("greevil_choice_NO")
	caster:RemoveAbility("greevil_choice_AS")

	caster:AddAbility(abLookup(caster)[1])
	caster:AddAbility(abLookup(caster)[2])
	caster:AddAbility(abLookup(caster)[3])
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_overload_custom")
	caster:AddAbility("greevil_guardian_angel_custom")
	caster:SetAbilityPoints(0)
	allAbilities(caster)

end
function ab1GT(event)
	local caster = event.caster

	caster.ab3 = "GT"

	caster:RemoveAbility("greevil_choice_NA")
	caster:RemoveAbility("greevil_choice_PN")
	caster:RemoveAbility("greevil_choice_IH")
	caster:RemoveAbility("greevil_choice_GT")
	caster:RemoveAbility("greevil_choice_NO")
	caster:RemoveAbility("greevil_choice_AS")

	caster:AddAbility(abLookup(caster)[1])
	caster:AddAbility(abLookup(caster)[2])
	caster:AddAbility(abLookup(caster)[3])
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_overload_custom")
	caster:AddAbility("greevil_guardian_angel_custom")
	caster:SetAbilityPoints(0)
	allAbilities(caster)

end
function ab1NO(event)
	local caster = event.caster

	caster.ab3 = "NO"

	caster:RemoveAbility("greevil_choice_NA")
	caster:RemoveAbility("greevil_choice_PN")
	caster:RemoveAbility("greevil_choice_IH")
	caster:RemoveAbility("greevil_choice_GT")
	caster:RemoveAbility("greevil_choice_NO")
	caster:RemoveAbility("greevil_choice_AS")

	caster:AddAbility(abLookup(caster)[1])
	caster:AddAbility(abLookup(caster)[2])
	caster:AddAbility(abLookup(caster)[3])
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_overload_custom")
	caster:AddAbility("greevil_guardian_angel_custom")
	caster:SetAbilityPoints(0)
	allAbilities(caster)

end
function ab1AS(event)
	local caster = event.caster

	caster.ab3 = "AS"

	caster:RemoveAbility("greevil_choice_NA")
	caster:RemoveAbility("greevil_choice_PN")
	caster:RemoveAbility("greevil_choice_IH")
	caster:RemoveAbility("greevil_choice_GT")
	caster:RemoveAbility("greevil_choice_NO")
	caster:RemoveAbility("greevil_choice_AS")

	caster:AddAbility(abLookup(caster)[1])
	caster:AddAbility(abLookup(caster)[2])
	caster:AddAbility(abLookup(caster)[3])
	caster:AddAbility("generic_hidden")
	caster:AddAbility("greevil_overload_custom")
	caster:AddAbility("greevil_guardian_angel_custom")
	caster:SetAbilityPoints(0)
	allAbilities(caster)

end





function abLookup(caster)
	local ab1 = caster.ab1
	local ab2 = caster.ab2
	local ab3 = caster.ab3

	if ab1 == "SB" then
		ab1 = "greevil_sticky_bomb"
	elseif ab1 == "GR" then
		ab1 = "greevil_gods_rebuke_custom"
	elseif ab1 == "Pen" then
		ab1 = "greevil_penitence_custom"
	elseif ab1 == "SS" then
		ab1 = "greevil_shackleshot_custom"
	elseif ab1 == "MM" then
		ab1 = "greevil_magic_missile_custom"
	elseif ab1 == "SE" then
		ab1 = "greevil_split_earth_custom"
	else
		ab1 = "greevil_choice_ab1"
	end
	
	if ab2 == "TT" then
		ab2 = "greevil_tag_team_custom"
	elseif ab2 == "OG" then
		ab2 = "greevil_overgrowth_custom"
	elseif ab2 == "FA" then
		ab2 = "greevil_frost_armor_custom"
	elseif ab2 == "DP" then
		ab2 = "greevil_demonic_purge_custom"
	elseif ab2 == "SC" then
		ab2 = "greevil_shield_crash_custom"
	elseif ab2 == "S" then
		ab2 = "greevil_surge_custom"
	else
		ab2 = "greevil_choice_ab2"
	end
	
	if ab3 == "NA" then
		ab3 = "greevil_natures_attendants_custom"
	elseif ab3 == "PN" then
		ab3 = "greevil_pulse_nova_custom"
	elseif ab3 == "IH" then
		ab3 = "greeil_feast_custom"
	elseif ab3 == "GT" then
		ab3 = "greevil_summon_turret_custom"
	elseif ab3 == "NO" then
		ab3 = "greevil_natural_order_custom"
	elseif ab3 == "AS" then
		ab3 = "greevil_astral_step_custom"
	else
		ab3 = "greevil_choice_ab3"
	end

	return {ab1,ab2,ab3}
end

function allAbilities(caster)
	if caster.ab1 ~= nil and caster.ab2 ~= nil and caster.ab3 ~= nil then
		caster:SetAbilityPoints(caster:GetLevel())
	end
	if caster.ab1 == nil then
		caster:UpgradeAbility(caster:GetAbilityByIndex(0))
	end
	if caster.ab2 == nil then
		caster:UpgradeAbility(caster:GetAbilityByIndex(1))
	end
	if caster.ab3 == nil then
		caster:UpgradeAbility(caster:GetAbilityByIndex(2))
	end
end