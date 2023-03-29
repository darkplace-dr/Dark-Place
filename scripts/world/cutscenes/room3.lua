return {
	morshu = function(cutscene, event)
		local morshu = cutscene:getCharacter("morshu")
		local doobie = cutscene:getCharacter("doobie")
        local magolor = cutscene:getCharacter("magolor")

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
                    magolor:setAnimation("speen")

                    cutscene:wait(31)
                    Game.world.map.morshu_dance = false
                    Assets.stopSound("danceparty")
                    Game.world.music:resume("")
                    m_anim:remove()

                    -- character idle animations
                    if Game:getFlag("room3_doobie") then 
                        doobie:setAnimation("idle")
                    end
                    magolor:setSprite("shop")

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
	end,
    garbage = function(cutscene, event)
        local garbage = cutscene:getCharacter("diamond_trash")
        Game.world.music:pause()
        if event.interacted then
            cutscene:showNametag("Trash Rudinn")
            Assets.playSound("stillgarbage")
            cutscene:text("[noskip][voice:nil]* Oh hi,[wait:1] thanks for checking in.[wait:2]\n* I'm...", nil, garbage, {auto = true})
            cutscene:hideNametag()

            local text1 = Game.world:spawnObject(Text("still", 210, 40, 300, 500, {style = "dark"}))
            text1:setScale(2)
            text1.fake_alpha = 1
            text1.parallax_x = 0
            text1.parallax_y = 0
            cutscene:wait(0.2)

            local text2 = Game.world:spawnObject(Text("a", 380, 40, 300, 500, {style = "dark"}))
            text2:setScale(2)
            text2.fake_alpha = 1
            text2.parallax_x = 0
            text2.parallax_y = 0
            cutscene:wait(0.2)

            local text3 = Game.world:spawnObject(Text("piece", 205, 110, 300, 500, {style = "dark"}))
            text3:setScale(2)
            text3.fake_alpha = 1
            text3.parallax_x = 0
            text3.parallax_y = 0
            cutscene:wait(0.2)

            local text4 = Game.world:spawnObject(Text("of", 370, 110, 300, 500, {style = "dark"}))
            text4:setScale(2)
            text4.fake_alpha = 1
            text4.parallax_x = 0
            text4.parallax_y = 0
            cutscene:wait(0.2)
            cutscene:fadeIn(2, {color = {1, 1, 1}})

            local text5 = Game.world:spawnObject(Text("GARBAGE", 35, 160, 300, 500, {style = "GONER"}))
            text5:setScale(6)
            text5.alpha = 1
            text5.parallax_x = 0
            text5.parallax_y = 0
		
            local flash = Rectangle(0, 0, 640, 480)
            flash.layer = 100
            flash.color = {1, 1, 1}
            flash.alpha = 1
            flash.parallax_x = 0
            flash.parallax_y = 0
            Game.world:addChild(flash)
		
            Game.world.timer:tween(1.5, flash, {alpha = 0}, "linear", function()
                flash:remove()
            end)
		
            cutscene:wait(2)

            Game.world.timer:tween(2, text1, {alpha = 0}, "linear", function()
                text1:remove()
            end)
            Game.world.timer:tween(2, text2, {alpha = 0}, "linear", function()
                text2:remove()
            end)
            Game.world.timer:tween(2, text3, {alpha = 0}, "linear", function()
                text3:remove()
            end)
            Game.world.timer:tween(2, text4, {alpha = 0}, "linear", function()
                text4:remove()
            end)
            Game.world.timer:tween(2, text5, {alpha = 0}, "linear", function()
                text5:remove()
            end)

            cutscene:wait(3)
            cutscene:look("down")
        end
        if not event.interacted then
            cutscene:showNametag("Trash Rudinn")
            Assets.playSound("garbage")
            cutscene:text("[noskip][voice:nil]* Hellooo...[wait:1.5]", nil, garbage, {auto = true})
            cutscene:hideNametag()

            local text1 = Game.world:spawnObject(Text("I'm", 240, 40, 300, 500, {style = "dark"}))
            text1:setScale(2)
            text1.fake_alpha = 1
            text1.parallax_x = 0
            text1.parallax_y = 0
            cutscene:wait(0.2)

            local text2 = Game.world:spawnObject(Text("a", 360, 40, 300, 500, {style = "dark"}))
            text2:setScale(2)
            text2.fake_alpha = 1
            text2.parallax_x = 0
            text2.parallax_y = 0
            cutscene:wait(0.1)

            local text3 = Game.world:spawnObject(Text("piece", 205, 110, 300, 500, {style = "dark"}))
            text3:setScale(2)
            text3.fake_alpha = 1
            text3.parallax_x = 0
            text3.parallax_y = 0
            cutscene:wait(0.2)

            local text4 = Game.world:spawnObject(Text("of", 370, 110, 300, 500, {style = "dark"}))
            text4:setScale(2)
            text4.fake_alpha = 1
            text4.parallax_x = 0
            text4.parallax_y = 0
            cutscene:wait(0.2)
            cutscene:fadeIn(2, {color = {1, 1, 1}})

            local text5 = Game.world:spawnObject(Text("GARBAGE", 35, 160, 300, 500, {style = "GONER"}))
            text5:setScale(6)
            text5.alpha = 1
            text5.parallax_x = 0
            text5.parallax_y = 0
		
            local flash = Rectangle(0, 0, 640, 480)
            flash.layer = 100
            flash.color = {1, 1, 1}
            flash.alpha = 1
            flash.parallax_x = 0
            flash.parallax_y = 0
            Game.world:addChild(flash)
		
            Game.world.timer:tween(1.5, flash, {alpha = 0}, "linear", function()
                flash:remove()
            end)
		
            cutscene:wait(2)

            Game.world.timer:tween(2, text1, {alpha = 0}, "linear", function()
                text1:remove()
            end)
            Game.world.timer:tween(2, text2, {alpha = 0}, "linear", function()
                text2:remove()
            end)
            Game.world.timer:tween(2, text3, {alpha = 0}, "linear", function()
                text3:remove()
            end)
            Game.world.timer:tween(2, text4, {alpha = 0}, "linear", function()
                text4:remove()
            end)
            Game.world.timer:tween(2, text5, {alpha = 0}, "linear", function()
                text5:remove()
            end)

            cutscene:wait(3)
            cutscene:look("down")

            event.interacted = true
        end
        Game.world.music:resume()
    end,
    magshop = function (cutscene, event)
        cutscene:showNametag("Magolor")
        cutscene:text("* Welcome to my shoppe!", "happy", "magolor")
        cutscene:text("* What would you like to buy?", "neutral", "magolor")
        cutscene:hideNametag()
        local opinion = cutscene:choicer({"Food", "Weapons", "Armor", "None"}, options)
        if opinion == 1 then
            cutscene:showNametag("Magolor")
            cutscene:text("* What kind of food would you like?", "happy", "magolor")
            cutscene:hideNametag()
            local food = cutscene:choicer({"Pep Brew", "Apple", "Maxim Tomato", "None"}, options)
            if food == 1 then
                cutscene:showNametag("Magolor")
                cutscene:text("* Do you want to buy some Pep Brew for 100D$?", "neutral", "magolor")
                cutscene:hideNametag()
                local buy = cutscene:choicer({"Yes", "No"}, options)
                if buy == 1 then
                    if Game.money >= 100 then
                        local itemcheck = Game.inventory:addItem("pepbrew")
                        if itemcheck then
                            Game.money = Game.money - 100
                            cutscene:showNametag("Magolor")
                            cutscene:text("* Here you go!", "happy", "magolor")
                            cutscene:text("* Pleasure doing business with you!", "wink", "magolor")
                            cutscene:hideNametag()
                        else
                            cutscene:showNametag("Magolor")
                            cutscene:text("* Your pockets look to full for this...", "unamused", "magolor")
                            cutscene:hideNametag()
                        end
                    else
                        cutscene:showNametag("Magolor")
                        cutscene:text("* Come back when you can actually afford this...", "unamused", "magolor")
                        cutscene:hideNametag()
                    end
                else
                    cutscene:showNametag("Magolor")
                    cutscene:text("* Uh,[wait:5] okay then.", "pensive", "magolor")
                    cutscene:text("* Nobody likes a window shopper.", "unamused", "magolor")
                    cutscene:hideNametag()
                end
            elseif food == 2 then
                cutscene:showNametag("Magolor")
                cutscene:text("* Do you want to buy an Apple for 250D$?", "neutral", "magolor")
                cutscene:hideNametag()
                local buy = cutscene:choicer({"Yes", "No"}, options)
                if buy == 1 then
                    if Game.money >= 250 then
                        local itemcheck = Game.inventory:addItem("apple_uneaten")
                        if itemcheck then
                            Game.money = Game.money - 250
                            cutscene:showNametag("Magolor")
                            cutscene:text("* Here you go!", "happy", "magolor")
                            cutscene:text("* Pleasure doing business with you!", "wink", "magolor")
                            cutscene:hideNametag()
                        else
                            cutscene:showNametag("Magolor")
                            cutscene:text("* Your pockets look to full for this...", "unamused", "magolor")
                            cutscene:hideNametag()
                        end
                    else
                        cutscene:showNametag("Magolor")
                        cutscene:text("* Come back when you can actually afford this...", "unamused", "magolor")
                        cutscene:hideNametag()
                    end
                else
                    cutscene:showNametag("Magolor")
                    cutscene:text("* Uh,[wait:5] okay then.", "pensive", "magolor")
                    cutscene:text("* Nobody likes a window shopper.", "unamused", "magolor")
                    cutscene:hideNametag()
                end
            elseif food == 3 then
                cutscene:showNametag("Magolor")
                cutscene:text("* Do you want to buy a Maxim Tomato for 5000D$?", "neutral", "magolor")
                cutscene:hideNametag()
                local buy = cutscene:choicer({"Yes", "No"}, options)
                if buy == 1 then
                    if Game.money >= 5000 then
                        local itemcheck = Game.inventory:addItem("maximtomato")
                        if itemcheck then
                            Game.money = Game.money - 5000
                            cutscene:showNametag("Magolor")
                            cutscene:text("* Here you go!", "happy", "magolor")
                            cutscene:text("* Pleasure doing business with you!", "wink", "magolor")
                            cutscene:hideNametag()
                        else
                            cutscene:showNametag("Magolor")
                            cutscene:text("* Your pockets look to full for this...", "unamused", "magolor")
                            cutscene:hideNametag()
                        end
                    else
                        cutscene:showNametag("Magolor")
                        cutscene:text("* Come back when you can actually afford this...", "unamused", "magolor")
                        cutscene:hideNametag()
                    end
                else
                    cutscene:showNametag("Magolor")
                    cutscene:text("* Uh,[wait:5] okay then.", "pensive", "magolor")
                    cutscene:text("* Nobody likes a window shopper.", "unamused", "magolor")
                    cutscene:hideNametag()
                end
            else
                cutscene:showNametag("Magolor")
                cutscene:text("* Uh,[wait:5] okay then.", "pensive", "magolor")
                cutscene:text("* Nobody likes a window shopper.", "unamused", "magolor")
                cutscene:hideNametag()
            end
        elseif opinion == 2 then
            cutscene:showNametag("Magolor")
            --cutscene:text("* What weapon would you like to buy?", "happy", "magolor")
            cutscene:text("* Sorry,[wait:5] I don't have any weapons right now.", "sad", "magolor")
            cutscene:hideNametag()
        elseif opinion == 3 then
            cutscene:showNametag("Magolor")
            --cutscene:text("* What sort of armor are you looking for?", "happy", "magolor")
            cutscene:text("* Sorry,[wait:5] I don't have any armor right now.", "sad", "magolor")
            cutscene:hideNametag()
        else
            cutscene:showNametag("Magolor")
            cutscene:text("* Uh,[wait:5] okay then.", "pensive", "magolor")
            cutscene:text("* Nobody likes a window shopper.", "unamused", "magolor")
            cutscene:hideNametag()
        end
    end,


    transition = function(cutscene, event)
        if math.random(1, 50) <= 5 then
            Game.world:mapTransition("pizzatower", "entrance")
        else
            Game.world:mapTransition("room1", "entry2")
        end
    end
}
