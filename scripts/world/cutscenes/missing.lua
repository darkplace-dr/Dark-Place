return {

	reaction = function(cutscene, event)
		local susie = cutscene:getCharacter("susie")
		local dess = cutscene:getCharacter("dess")
		if susie then
			cutscene:showNametag("Susie")
			cutscene:text("* ...[wait:5] Hey, what's going on here?", "neutral_side", "susie")
			if dess then
				cutscene:showNametag("Dess")
				cutscene:text("* Just some dumb Garry's Mod modder-", "kind", "dess")
				cutscene:text("* Who didn't think of testing their mod first before releasing it.", "kind", "dess")
				cutscene:text("* Lame LMAO", "condescending", "dess")
			end
			cutscene:showNametag("Susie")
			cutscene:text("* Let's just hope it won't kill us.", "sus_nervous", "susie")
			cutscene:hideNametag()
		end
	end,
    
    tpose_mario = function(cutscene, event)
        local SM = Registry.createItem("super_mushroom")
        cutscene:showShop()
        cutscene:showNametag("Mario")
        cutscene:text("* Hello![wait:5] It's a me Super Mario on the PS4.[wait:5] Whohooo!")
        cutscene:text(string.format("* I got some spare Super Mushrooms to sell.\nThey're %dD$,[wait:5] interested?", SM:getPrice()))
        cutscene:hideNametag()

        local buying = cutscene:choicer({"Buy", "Do not"}) == 1
        
        cutscene:showNametag("Mario")
        if not buying then
            cutscene:text("* Mamma mia...")
        elseif Game.money < SM:getPrice() then
            cutscene:text("* Oh no...[wait:5] You don't have the money...")
        else
            local success, result_text = Game.inventory:tryGiveItem(SM)
            if success then
                Game.money = Game.money - SM:getPrice()
                cutscene:playSound("equip")
                cutscene:text("* Whohooo![wait:5] Here's your mushroom.\n"..result_text)
            else
                cutscene:text("* Oh no...[wait:5] You don't have enough space...")
            end
        end
        cutscene:hideShop()
        cutscene:hideNametag()
	end,
    
	pauling = function(cutscene, event)
		cutscene:text("* The girl gives you a contract.\n* Sign it?")
		
		if cutscene:choicer({"Sign", "Do not"}) == 1 then
			local contract = Sprite("ui/pauling_sign/_contract", -320, 240)
			contract:setOrigin(0.5,0.5)
			Game.stage:addChild(contract)
			cutscene:wait(cutscene:slideTo(contract, 320, 240, 1))
			
			cutscene:wait(0.5)
			
			local player = Game.world.player
			local id = player.actor.id
			local signature = Sprite("ui/pauling_sign/" .. id, 319, 391)
			signature:setOrigin(0.5,0.5)
			Game.stage:addChild(signature)
			
			cutscene:wait(1)
			
			cutscene:slideTo(signature, 959, 391, 1)
			cutscene:wait(cutscene:slideTo(contract, 960, 240, 1))
			
			cutscene:text("* Ms. Pauling joins you!")
			
			if #Game.party >= Game:getFlag("party_max") then
				cutscene:hideNametag()
				
				cutscene:wait(cutscene:fadeOut(0.75))
				event:remove()
				cutscene:wait(cutscene:fadeIn(0.75))
			
				cutscene:attachFollowers()
				cutscene:wait(2)
			else
				cutscene:hideNametag()
				Game:addPartyMember("pauling")
				Game:setFlag("pauling_party", true)
				event:convertToFollower(#Game.party - 1)
				cutscene:attachFollowers()
				cutscene:wait(0.5)
			end
			Game:setFlag("pauling_inparty", true)
			Mod:unlockPartyMember("pauling")
		else
			cutscene:text("* You signn't.")
		end
	end,
}
