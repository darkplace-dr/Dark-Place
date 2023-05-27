return {
    terrorize = function(cutscene, battler, enemy)
		
		local randomText = Utils.random(0, 3, 1)
		
		if randomText == 0 then
			cutscene:text("* Alright pipsqueak![wait:10]\n* Go away unless you wanna be double-dead!", "teeth_smile", "susie")
		elseif randomText == 1 then
			cutscene:text("* Sitck around if you wanna find out if it's possible to cut a ghost in half.", "teeth_smile", "susie")
		elseif randomText == 2 then
			cutscene:text("* I could punt you 5 yards y'know.", "teeth_smile", "susie")
		elseif randomText == 3 then
			cutscene:text("* You call that sharp?[wait:10] I think I can introduce you to something sharper.", "teeth_smile", "susie")
		end
		
		dialogue_override = ".........."
		
		cutscene:text("* The enemy's ATTACK dropped sharply!\n* The enemy's DEFENSE rose sharply!")
    end,
	
	bescared = function(cutscene, battler, enemy)
		
		cutscene:text("* ...!", "shock", "noelle")
		enemy.dialogue_override = "...!"
		
		cutscene:text("* The enemy's DEFENSE dropped sharply!\n* The enemy's ATTACK rose sharply!")
    end,
	
	befriend = function(cutscene, battler, enemy)
		
		cutscene:text("* Aww...[wait:5] look![wait:10] It's harmless!", "blush_smile", "ralsei")
		cutscene:text("* You don't have to try and scare us,[wait:5] little guy!", "smile", "ralsei")
		
		enemy.dialogue_override = "... :)"
		
		cutscene:text("* The enemy's DEFENSE and ATTACK dropped sharply!")
    end,
	
	exorcise = function(cutscene, battler, enemy)
	
		cutscene:text("* Noyno tried exorcising the enemy.")
		Assets.playSound("damage")
		enemy:hurt(200, battler)
		cutscene:wait(1)
		if not Game:getFlag("hitHHaunt") then
			cutscene:text("* Whoops.", "smol", "noyno")
			Game:setFlag("hitHHaunt", true)
		else
			cutscene:text("* I did it again.", "oh_god", "noyno")
		end
		
		enemy.dialogue_override = "... >:("
	end,
}