AI_THINK_INTERVAL = 0.1
offset = 200

function Spawn( entityKeyValues )
	thisEntity:SetContextThink("GreevilThink", GreevilThink, 0.1)
	thisEntity.Chrono = thisEntity:FindAbilityByName("rex_chronosphere")
	thisEntity.state = 0
end

function GreevilThink()
	if not IsServer() then
		return
	end

	if ( not thisEntity:IsAlive() ) then
		AI_THINK_INTERVAL = -1
		return AI_THINK_INTERVAL
	end

	if GameRules:IsGamePaused() == true then
		AI_THINK_INTERVAL = 0.5
		return AI_THINK_INTERVAL
	end

	local team = thisEntity:GetTeam()

	if thisEntity.state == 0 then
		State0(team)
	elseif thisEntity.state == 1 then
		State1(team)
	elseif thisEntity.state == 2 then
		State2(team)
	elseif thisEntity.state == 3 then
		State3(team)
	elseif thisEntity.state == 4 then
		State4(team)
	elseif thisEntity.state == 5 then
		State5(team)
	elseif thisEntity.state == 6 then
		State6(team)
	elseif thisEntity.state == 7 then
		State7(team)
	elseif thisEntity.state == 8 then
		State8(team)
	elseif thisEntity.state == 9 then
		State9(team)
	elseif thisEntity.state == 10 then
		State10(team)
	elseif thisEntity.state == 11 then
		State11(team)
	elseif thisEntity.state == 12 then
		State12(team)
	elseif thisEntity.state == 13 then
		State13(team)
	elseif thisEntity.state == 14 then
		State14(team)
	elseif thisEntity.state == 15 then
		State15(team)
	elseif thisEntity.state == 16 then
		State16(team)
	elseif thisEntity.state == 17 then
		State17(team)
	elseif thisEntity.state == 18 then
		State18(team)
	elseif thisEntity.state == 19 then
		State19(team)
	elseif thisEntity.state == 20 then
		State20(team)
	elseif thisEntity.state == 21 then
		State21(team)
	elseif thisEntity.state == 22 then
		State22(team)
	elseif thisEntity.state == 23 then
		State23(team)
	elseif thisEntity.state == 24 then
		State24(team)
	end
	return AI_THINK_INTERVAL
end

function State0(team)
	if thisEntity:GetAbsOrigin()[2] > (5000 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, 5000, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, 5000, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		end
	else
		thisEntity.state = 1
	end
	return true
end

function State1(team)
	if thisEntity:GetAbsOrigin()[2] > (5000 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, 5000, 256)
			thisEntity:MoveToPosition(target)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, 5000, 256)
			thisEntity:MoveToPosition(target)
		end
	else
		thisEntity.state = 2
	end
	return true
end

function State2(team)
	if thisEntity:GetAbsOrigin()[2] > (4250 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, 4250, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, 4250, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		end
	else
		thisEntity.state = 3
	end
	return true
end

function State3(team)
	if thisEntity:GetAbsOrigin()[2] > (4250 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, 4250, 256)
			thisEntity:MoveToPosition(target)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, 4250, 256)
			thisEntity:MoveToPosition(target)
		end
	else
		thisEntity.state = 4
	end
	return true
end

function State4(team)
	if thisEntity:GetAbsOrigin()[2] > (3500 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, 3500, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, 3500, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		end
	else
		thisEntity.state = 5
	end
	return true
end

function State5(team)
	if thisEntity:GetAbsOrigin()[2] > (3500 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, 3500, 256)
			thisEntity:MoveToPosition(target)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, 3500, 256)
			thisEntity:MoveToPosition(target)
		end
	else
		thisEntity.state = 6
	end
	return true
end

function State6(team)
	if thisEntity:GetAbsOrigin()[2] > (2750 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, 2750, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, 2750, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		end
	else
		thisEntity.state = 7
	end
	return true
end

function State7(team)
	if thisEntity:GetAbsOrigin()[2] > (2750 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, 2750, 256)
			thisEntity:MoveToPosition(target)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, 2750, 256)
			thisEntity:MoveToPosition(target)
		end
	else
		thisEntity.state = 8
	end
	return true
end

function State8(team)
	if thisEntity:GetAbsOrigin()[2] > (2000 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, 2000, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, 2000, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		end
	else
		thisEntity.state = 9
	end
	return true
end

function State9(team)
	if thisEntity:GetAbsOrigin()[2] > (2000 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, 2000, 256)
			thisEntity:MoveToPosition(target)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, 2000, 256)
			thisEntity:MoveToPosition(target)
		end
	else
		thisEntity.state = 10
	end
	return true
end

function State10(team)
	if thisEntity:GetAbsOrigin()[2] > (1250 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, 1250, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, 1250, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		end
	else
		thisEntity.state = 11
	end
	return true
end

function State11(team)
	if thisEntity:GetAbsOrigin()[2] > (1250 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, 1250, 256)
			thisEntity:MoveToPosition(target)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, 1250, 256)
			thisEntity:MoveToPosition(target)
		end
	else
		thisEntity.state = 12
	end
	return true
end

function State12(team)
	if thisEntity:GetAbsOrigin()[2] > (500 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, 500, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, 500, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		end
	else
		thisEntity.state = 13
	end
	return true
end

function State13(team)
	if thisEntity:GetAbsOrigin()[2] > (500 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, 500, 256)
			thisEntity:MoveToPosition(target)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, 500, 256)
			thisEntity:MoveToPosition(target)
		end
	else
		thisEntity.state = 14
	end
	return true
end

function State14(team)
	if thisEntity:GetAbsOrigin()[2] > (-250 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, -250, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, -250, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		end
	else
		thisEntity.state = 15
	end
	return true
end

function State15(team)
	if thisEntity:GetAbsOrigin()[2] > (-250 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, -250, 256)
			thisEntity:MoveToPosition(target)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, -250, 256)
			thisEntity:MoveToPosition(target)
		end
	else
		thisEntity.state = 16
	end
	return true
end

function State16(team)
	if thisEntity:GetAbsOrigin()[2] > (-1000 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, -1000, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, -1000, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		end
	else
		thisEntity.state = 17
	end
	return true
end

function State17(team)
	if thisEntity:GetAbsOrigin()[2] > (-1000 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, -1000, 256)
			thisEntity:MoveToPosition(target)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, -1000, 256)
			thisEntity:MoveToPosition(target)
		end
	else
		thisEntity.state = 18
	end
	return true
end

function State18(team)
	if thisEntity:GetAbsOrigin()[2] > (-1750 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, -1750, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, -1750, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		end
	else
		thisEntity.state = 19
	end
	return true
end

function State19(team)
	if thisEntity:GetAbsOrigin()[2] > (-1750 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, -1750, 256)
			thisEntity:MoveToPosition(target)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, -1750, 256)
			thisEntity:MoveToPosition(target)
		end
	else
		thisEntity.state = 20
	end
	return true
end

function State20(team)
	if thisEntity:GetAbsOrigin()[2] > (-2500 + offset) then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, -2500, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, -2500, 256)
			thisEntity:CastAbilityOnPosition(target, thisEntity.Chrono, -1)
		end
	else
		thisEntity.state = 21
	end
	return true
end

function State21(team)
	if thisEntity:GetAbsOrigin()[2] > -3900 then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, -4000, 256)
			thisEntity:MoveToPosition(target)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, -4000, 256)
			thisEntity:MoveToPosition(target)
		end
	else
		thisEntity.state = 22
	end
	return true
end

function State22(team)
	if thisEntity:GetAbsOrigin()[2] < 5400 then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, 5500, 256)
			thisEntity:MoveToPosition(target)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, 5500, 256)
			thisEntity:MoveToPosition(target)
		end
	else
		thisEntity.state = 23
	end
	return true
end

function State23(team)
	if thisEntity:GetAbsOrigin()[2] > -3000 then
		if team == DOTA_TEAM_GOODGUYS then
			local target = Vector(6400, -3100, 256)
			thisEntity:MoveToPosition(target)
		elseif team == DOTA_TEAM_BADGUYS then
			local target = Vector(-6400, -3100, 256)
			thisEntity:MoveToPosition(target)
		end
	else
		thisEntity.state = 24
	end
	return true
end

function State24(team)
	thisEntity:ForceKill(false)
	return true
end
