return {
	unfinished = function(cutscene, event, chara)

		local function jumpGoomba(event, text, label, before_text)
			cutscene:wait(cutscene:slideTo(event, event.x, event.y-25, 0.25, "out-quad"))
			cutscene:wait(cutscene:slideTo(event, event.x, event.y+25, 0.25, "in-quad"))

			if before_text then
				before_text()
			end

			event:setAnimation({"talk", 1/6, true})
			cutscene:showNametag("SMB Goomba "..label)
			cutscene:text(text)
			cutscene:hideNametag()
			event:setSprite("idle")
		end

		local goomba_a = Game.world:getEvent(18)
		local goomba_b = Game.world:getEvent(17)

		jumpGoomba(goomba_a, "* STOOOOOOOP!![wait:10]", "A", function()
			for i,member in ipairs(Game.party) do
				cutscene:alert(member.id, nil, {play_sound=false})
			end
		end)

		local pos = {
			{515, 260},
			{425, 215},
			{425, 260},
			{425, 315}
		}

		cutscene:detachFollowers()
		cutscene:detachCamera()
		for i,member in ipairs(Game.party) do
			cutscene:walkTo(member.id, pos[i][1], pos[i][2], 1, "right", true)
		end
		cutscene:wait(1.5)
		jumpGoomba(goomba_b, "* Stop!", "B")

		cutscene:wait(0.5)

		jumpGoomba(goomba_a, "* The land beyond us is unfinished, you cannooooot access it!", "A")
		jumpGoomba(goomba_b, "* It!", "B")
		jumpGoomba(goomba_a, "* Come back later when this quest will be doooooable!", "A")
		jumpGoomba(goomba_b, "* Able!", "B")

		cutscene:attachCamera()
		cutscene:wait(cutscene:attachFollowers())
	end
}