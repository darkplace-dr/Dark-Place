return {
	morshu = function(cutscene, event)
		local morshu = cutscene:getCharacter("morshu")
		local doobie = cutscene:getCharacter("doobie")

	    Game.world.music:pause("")

        local m_anim = Sprite("m_anim/rubies")
		m_anim:play(0.095, false)
		m_anim.layer = 1000
		m_anim.parallax_x = 0
		m_anim.parallax_y = 0
		m_anim:setScale(2)
		Assets.playSound("vo_mline")
		Game.world:addChild(m_anim)
		
		cutscene:wait(8.8)
		Game.world.music:resume("")
		m_anim:remove()
		
        cutscene:text("* (Buy Lamp Oil for 40 dolla-[wait:5]\ner-[wait:5] rupee-[wait:5] er-[wait:5] rubies?)")
		cutscene:showShop()

        choice = cutscene:choicer({"Buy", "Do not"}, options)
		
        cutscene:hideShop()
		
        if choice == 1 then
           if Game.money >= 40 then
               itemget = Game.inventory:addItem("lampoil")
               if itemget then
                    Game.money = Game.money - 40
                    Game.world.music:pause("")
					
                    Game.world.map.morshu_dance = true
			
                    local danceparty = Assets.playSound("danceparty")
                    danceparty:setLooping(true)

                    local m_anim = Sprite("m_anim/dance")
                    m_anim:play(0.0001, true)
                    m_anim.layer = 1000
                    m_anim.parallax_x = 0
                    m_anim.parallax_y = 0
                    m_anim:setScale(2)
                    Game.world:addChild(m_anim)
					
                    --character dance animations
                    if Game:getFlag("room3_doobie") then 
                        doobie:setAnimation("dance")
                    end

                    cutscene:wait(31)
                    Game.world.map.morshu_dance = false
                    Assets.stopSound("danceparty")
                    Game.world.music:resume("")
                    m_anim:remove()

                    -- character idle animations
                    if Game:getFlag("room3_doobie") then 
                        doobie:setAnimation("idle")
                    end

                    cutscene:text("* (You stashed the Lamp Oil inside your [color:yellow]ITEMS[color:reset].)")
                else
                    cutscene:text('* (There is no "inventory full"\nclip for Morshu,[wait:5] so all you get\nis this dinky-ass text box).')
                end
            else
                local m_anim = Sprite("m_anim/richer")
                m_anim:play(0.095, false)
                m_anim.layer = 1000
                m_anim.parallax_x = 0
                m_anim.parallax_y = 0
                m_anim:setScale(2)
                Assets.playSound("vo_mline2")
                Game.world:addChild(m_anim)
				
                cutscene:wait(7)
                m_anim:remove()
                Game.world.music:resume("")
            end
        else
            Game.world.music:pause("")
            Assets.playSound("menace")
            local menacing = Sprite("m_anim/menacing")
            menacing.layer = 1000
            menacing.parallax_x = 0
            menacing.parallax_y = 0
            menacing:setScale(2)
            Game.world:addChild(menacing)
			
            cutscene:wait(18.8)
            menacing:remove()
            Game.world.music:resume("")
        end
    end,
    spam_graffiti = function(cutscene, event)
        local susie = cutscene:getCharacter("susie")
        cutscene:setSpeaker(susie)
        cutscene:showNametag("Susie")
        cutscene:text("* Isn't that the big shot guy who attacked us in Queen's Basement?", "suspicious")
	    if Game:hasPartyMember("YOU") then
            cutscene:text("* Oh right,[wait:5] you don't know who this guy is,[wait:5] do ya YOU?", "sus_nervous")
            cutscene:text("* Basically,[wait:5] he was some weird dude that scammed my friend Kris.", "neutral")
            cutscene:text("* All he ever said was a bunch of weird stuff that didn't make sense.", "annoyed")
            cutscene:text("* Stuff like puppets,[wait:5] strings,[wait:5] hands...", "annoyed_down")
            cutscene:text("* Ralsei said he was just a corrupted program,[wait:5] or something like that...", "neutral_side")
            cutscene:text("* But something tells me there was something else going on with that guy.", "suspicious")
        else
            cutscene:text("* The hell is he doing here?", "sus_nervous")
        end
        cutscene:hideNametag()
    end,
    doobie = function(cutscene, event)
        if Game:getFlag("room3_doobie") then
            local susie = cutscene:getCharacter("susie")
            local doobie = cutscene:getCharacter("doobie")
            cutscene:setSpeaker(doobie)
            cutscene:showNametag("Ralsei?")
            cutscene:text("* doobie", "default")
            cutscene:hideNametag()
            cutscene:setSpeaker(susie)
            cutscene:showNametag("Susie")
            cutscene:text("* RALSEI!! WHY ARE YOU SMOKING WEED?!", "teeth_b")
            cutscene:text("* JUST COME WITH US!", "teeth")
            cutscene:hideNametag()
            local alpha = doobie:addFX(AlphaFX())

            Game.stage.timer:tween(1, alpha, {alpha = 0})
            Assets.playSound("hypnosis")

            cutscene:wait(2)
            doobie:remove()
            Game:setFlag("room3_doobie", false)

            cutscene:look("down")
        end
	end
}
