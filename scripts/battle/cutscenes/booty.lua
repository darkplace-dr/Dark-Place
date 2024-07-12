return {
    surrender = function(cutscene, battler, enemy)
		Game.battle.music:stop()
		local booty = cutscene:getCharacter("booty")
		cutscene:battlerText(booty, "Okay, I give!\nI give, okay!?", {x=booty.x - 20, y=booty.y - 25})
		cutscene:battlerText(booty, "You kids sure\nare tough", {x=booty.x - 20, y=booty.y - 25})
		cutscene:battlerText(booty, "...", {x=booty.x - 20, y=booty.y - 25})
		cutscene:battlerText(booty, "Alright, I know\nI lied", {x=booty.x - 20, y=booty.y - 25})
		cutscene:battlerText(booty, "I wanted to con\na bunch of kids\nout of everything\nthey got", {x=booty.x - 20, y=booty.y - 25})
		cutscene:battlerText(booty, "I just ask that\nyou spare me", {x=booty.x - 20, y=booty.y - 25})
		cutscene:battlerText(booty, "I'll never bother\nyou again", {x=booty.x - 20, y=booty.y - 25})
		Game.battle.enemies[1].mercy = 100
		Game.battle.enemies[1].health = 1
		Game.battle.enemies[1].defeat_once = true
		Game.battle.enemies[1].waves = {"empty"}
		Game.battle.enemies[1].check = "AT 4 DF 0\n* A greed for cash,[wait:5] and his button eyes were on you."
		Game.battle:setState("ACTIONSELECT")
    end,
}