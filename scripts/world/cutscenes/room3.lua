return {
	morshu = function(cutscene, event)
		local morshu = cutscene:getCharacter("morshu")

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
			
                    cutscene:wait(31)
                    Game.world.map.morshu_dance = false
                    Assets.stopSound("danceparty")
                    Game.world.music:resume("")
                    m_anim:remove()
                    cutscene:text("* (You stashed the Lamp Oil inside you [color:yellow]ITEMS[color:reset].)")
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
    end
}
