return {
    start = function(cutscene, event)
        Game.world.map.sliding = true
    end,
    ending = function(cutscene, event)
        Game.world.map.sliding = false
		if Game.world.map.slide_time < Game:getFlag("slide_hs", 999) then
			Game:setFlag("slide_hs", Game.world.map.slide_time)
		end
    end,
    mario = function(cutscene, event)
		local mario = cutscene:getCharacter("mario")
		
		cutscene:showNametag("Mario")
		cutscene:text("* Hey,[wait:5] you-a very good!", "main", "mario")
		cutscene:text("* It's-a my turn now!", "main", "mario")
		cutscene:hideNametag()
		
		cutscene:detachFollowers()
		cutscene:detachCamera()
        local leader = Game.world.player
		local leaderx = leader.x
		local leadery = leader.y
		leader:explode(0, 0, true)
		cutscene:slideTo(leader, leader.x - 50, leader.y - 700, 1)
		cutscene:wait(1.5)
		
		if #Game.party >= Game:getFlag("party_max") then
			local prev_leader_pm = Game.party[1]
			Game:removePartyMember(prev_leader_pm)
			Game:setFlag(prev_leader_pm.id.."_party", false)
		end
		
		Game:addPartyMember("mario", 1)
		Game:setFlag("mario_party", true)
		Game:setFlag("mario_obtained", true)
		Game.world:spawnPlayer(mario.x, mario.y, "mario")
		mario:remove()
		Game.world:removeFollower(leader)
		cutscene:walkTo("mario", leaderx, leadery, 1, "up")
		cutscene:attachFollowers(1)
		cutscene:interpolateFollowers()
		cutscene:attachCamera(0.5)
		cutscene:wait(0.5)
		
		Game:setFlag("gotMario", true)
		Mod:unlockPartyMember("mario")
		
		if Game:hasPartyMember("brandon") then
			cutscene:showNametag("Brandon")
			cutscene:text("* That joke is only funny the first time.", "dissapointed", "brandon")
			
			cutscene:showNametag("Mario")
			cutscene:text("* There was a first time?", "main", "mario")
		end
		
		if Game:hasPartyMember("jamm") and not Game:getFlag("dungeonkiller") then
			cutscene:showNametag("Jamm")
			cutscene:text("* (Don't take anything he says or does to heart.)", "nervous", "jamm")
			cutscene:text("* (He's a good guy.)[wait:5]\n* (Just really stupid.)", "neutral", "jamm")
		end
		cutscene:hideNametag()
    end,
}
