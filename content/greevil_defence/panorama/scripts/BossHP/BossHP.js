GameEvents.Subscribe("BossSpawned", OnSpawn);
GameEvents.Subscribe("BossDied", OnKilled);

function OnSpawn(data)
{
	
	if (data.team == "radiant")
	{
		switch(data.colour) {
			case "red":
				cssAlive = "1Alive";
				cssDead = "1Dead";
				break;
			case "orange":
				cssAlive = "2Alive";
				cssDead = "2Dead";
				break;
			case "yellow":
				cssAlive = "3Alive";
				cssDead = "3Dead";
				break;
			case "green":
				cssAlive = "4Alive";
				cssDead = "4Dead";
				break;
			case "blue":
				cssAlive = "5Alive";
				cssDead = "5Dead";
				break;
			case "purple":
				cssAlive = "6Alive";
				cssDead = "6Dead";
				break;
			case "white":
				cssAlive = "7Alive";
				cssDead = "7Dead";
				break;
			case "black":
				cssAlive = "8Alive";
				cssDead = "8Dead";
				break;
			default:
				$.Msg("Colour check failed, ", data.colour," was given");
				break;
		}
	}
	if (data.team == "dire")
	{
		switch(data.colour) {
			case "red":
				cssAlive = "1Alive";
				cssDead = "1Dead";
				break;
			case "orange":
				cssAlive = "2Alive";
				cssDead = "2Dead";
				break;
			case "yellow":
				cssAlive = "3Alive";
				cssDead = "3Dead";
				break;
			case "green":
				cssAlive = "4Alive";
				cssDead = "4Dead";
				break;
			case "blue":
				cssAlive = "5Alive";
				cssDead = "5Dead";
				break;
			case "purple":
				cssAlive = "6Alive";
				cssDead = "6Dead";
				break;
			case "white":
				cssAlive = "7Alive";
				cssDead = "7Dead";
				break;
			case "black":
				cssAlive = "8Alive";
				cssDead = "8Dead";
				break;
			default:
				$.Msg("Colour check failed, ", data.colour," was given");
				break;
		}
	}
	
	BossID = data.team + "_" + data.colour;
	const bossPanel = $("#" + BossID);
	
	bossPanel.RemoveClass(cssDead);
	bossPanel.AddClass(cssAlive);
	
}

function OnKilled(data)
{
	
	if (data.team == "radiant")
	{
		switch(data.colour) {
			case "red":
				cssAlive = "1Alive";
				cssDead = "1Dead";
				break;
			case "orange":
				cssAlive = "2Alive";
				cssDead = "2Dead";
				break;
			case "yellow":
				cssAlive = "3Alive";
				cssDead = "3Dead";
				break;
			case "green":
				cssAlive = "4Alive";
				cssDead = "4Dead";
				break;
			case "blue":
				cssAlive = "5Alive";
				cssDead = "5Dead";
				break;
			case "purple":
				cssAlive = "6Alive";
				cssDead = "6Dead";
				break;
			case "white":
				cssAlive = "7Alive";
				cssDead = "7Dead";
				break;
			case "black":
				cssAlive = "8Alive";
				cssDead = "8Dead";
				break;
			default:
				$.Msg("Colour check failed, ", data.colour," was given");
				break;
		}
	}
	if (data.team == "dire")
	{
		switch(data.colour) {
			case "red":
				cssAlive = "1Alive";
				cssDead = "1Dead";
				break;
			case "orange":
				cssAlive = "2Alive";
				cssDead = "2Dead";
				break;
			case "yellow":
				cssAlive = "3Alive";
				cssDead = "3Dead";
				break;
			case "green":
				cssAlive = "4Alive";
				cssDead = "4Dead";
				break;
			case "blue":
				cssAlive = "5Alive";
				cssDead = "5Dead";
				break;
			case "purple":
				cssAlive = "6Alive";
				cssDead = "6Dead";
				break;
			case "white":
				cssAlive = "7Alive";
				cssDead = "7Dead";
				break;
			case "black":
				cssAlive = "8Alive";
				cssDead = "8Dead";
				break;
			default:
				$.Msg("Colour check failed, ", data.colour," was given");
				break;
		}
	}
	
	BossID = data.team + "_" + data.colour;
	const bossPanel = $("#" + BossID);
	
	$.Msg("killed: ", BossID);
	
	bossPanel.RemoveClass(cssAlive);
	bossPanel.AddClass(cssDead);
	
}