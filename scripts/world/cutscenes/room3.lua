return {
    morshu = function(cutscene, morshu)
        local magolor = cutscene:getCharacter("magolor")
        local doobie = cutscene:getCharacter("doobie")

        local cust_wait_timer = 0

        local function waitForTimeOrUserCancellation(time)
            cust_wait_timer = time
            return function()
                cust_wait_timer = Utils.approach(cust_wait_timer, 0, DT)
                if morshu.interact_count > 1 and Input.pressed("cancel") then
                    cust_wait_timer = 0
                    return true
                end
                return cust_wait_timer == 0
            end
        end
        local function showMorshuAnim(sprite, speed)
            local m_anim = Sprite("world/cutscenes/room3_morshu/" .. sprite)
            m_anim:play(speed, true)
            m_anim.layer = WORLD_LAYERS["ui"]
            m_anim.parallax_x = 0
            m_anim.parallax_y = 0
            m_anim:setScale(2)
            Game.world:addChild(m_anim)
            return m_anim, function(time, disallow_cancel)
                if time > 0 then
                    cutscene:wait(not disallow_cancel and waitForTimeOrUserCancellation(time) or time)
                end
                m_anim:remove()
            end
        end
        local function showMorshuAnimWithVoc(sprite, speed, clip, time, disallow_cancel)
            local anim, rem = showMorshuAnim(sprite, speed)
            Game.world.music:pause()
            Assets.playSound(clip)
            rem(time, disallow_cancel)
            Assets.stopSound(clip)
            Game.world.music:resume()
            return anim
        end

        Input.clear("cancel")

        showMorshuAnimWithVoc("rubies", 0.095, "vo_mline", 8.8)

        cutscene:text("* (Buy Lamp Oil for 40 dolla-[wait:5] er-[wait:5] rupee-[wait:5] er-[wait:5] rubies?)")
        cutscene:showShop()
        local choice = cutscene:choicer({ "Buy", "Do not" })
        cutscene:hideShop()

        if choice == 2 then
            showMorshuAnimWithVoc("menacing", 1, "menace", 18.8, false)
            return
        end

        if Game.money < 40 then
            showMorshuAnimWithVoc("richer", 0.095, "vo_mline2", 7)
            return
        end

        if not Game.inventory:addItem("lampoil") then
            cutscene:text('* (There is no "inventory full" clip for Morshu,[wait:5] so all you get is this dinky-ass text box.)')
            return
        end

        Game.money = Game.money - 40

        Game.world.music:pause()
        local danceparty = Music("danceparty", 0.8)
        danceparty:play()

        -- show character dance animations
        local svfx = Kristal.Config["simplifyVFX"]
        local svfx_suffix = svfx and "_svfx" or ""
        morshu.dance = true
        local _, dance_anim_rem = showMorshuAnim("dance", svfx and 0.05 or 0.0001)
        magolor.dance = true
        magolor:setAnimation("speen".. svfx_suffix)
        if doobie then
            doobie:setAnimation("dance" .. svfx_suffix)
        end
        dance_anim_rem(svfx and (9.694 * 2) or 31, true)

        -- show character idle animations
        morshu.dance = false
        magolor.dance = false
        magolor:setSprite("shop")
        if doobie then
            doobie:setAnimation("idle")
        end

        danceparty:remove()
        Game.world.music:resume()

        cutscene:text("* (You stashed the Lamp Oil inside your [color:yellow]ITEMS[color:reset].)")
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
        if not Game:getFlag("room3_doobie") then
            return
        end

        local susie = cutscene:getCharacter("susie")
        local doobie = cutscene:getCharacter("doobie")

        cutscene:setSpeaker(doobie)
        cutscene:showNametag("Ralsei?")
        cutscene:text("* doobie", "default")

        cutscene:setSpeaker(susie)
        cutscene:showNametag("Susie")
        cutscene:text("* RALSEI!! WHY ARE YOU SMOKING WEED?!", "teeth_b")
        cutscene:text("* JUST COME WITH US!", "teeth")
        cutscene:hideNametag()

        local alpha = doobie:addFX(AlphaFX())
        Game.world.timer:tween(1, alpha, { alpha = 0 })
        Assets.playSound("hypnosis")
        cutscene:wait(2)
        doobie:remove()
        Game:setFlag("room3_doobie", false)

        cutscene:look("down")

        if not Mod:hasAch("doobie") then
            Kristal.callEvent("completeAchievement", "doobie")
        end
    end,

    garbage = function(cutscene, event)
        local texts = {}
        local function genBigText(text, x, y, scale, goner, wait_time)
            scale = scale or 2
            wait_time = wait_time or 0.2

            local text = Game.world:spawnObject(Text(text, x, y, 300, 500, { style = goner and "GONER" or "dark" }))
            text:setScale(scale)
            text.parallax_x = 0
            text.parallax_y = 0
            if goner then
                text.alpha = 1
            end
            table.insert(texts, text)

            cutscene:wait(wait_time)

            return text
        end
        local function flashScreen()
            local flash = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
            flash.layer = 100
            flash.color = { 1, 1, 1 }
            flash.alpha = 1
            flash.parallax_x = 0
            flash.parallax_y = 0
            Game.world:addChild(flash)
            Game.world.timer:tween(1.5, flash, { alpha = 0 }, "linear", function()
                flash:remove()
            end)
        end
        local function fadeOutBigText()
            for _, v in ipairs(texts) do
                Game.world.timer:tween(2, v, { alpha = 0 }, "linear", function()
                    v:remove()
                end)
            end
            cutscene:wait(2)
        end

        local garbage = cutscene:getCharacter("diamond_trash")

        Game.world.music:pause()

        if event.interact_count == 1 then
            cutscene:showNametag("Trash Rudinn")
            Assets.playSound("garbage")
            cutscene:text("[noskip][voice:nil]* Hellooo...[wait:1.5]", nil, garbage, { auto = true })
            cutscene:hideNametag()
            genBigText("I'm", 240, 40)
            genBigText("a", 360, 40, 2, false, 0.1)
            genBigText("piece", 205, 110)
            genBigText("of", 370, 110)
            flashScreen()
            genBigText("GARBAGE", 35, 160, 6, true, 2)
            fadeOutBigText()
        else
            cutscene:showNametag("Trash Rudinn")
            Assets.playSound("stillgarbage")
            cutscene:text("[noskip][voice:nil]* Oh hi,[wait:1] thanks for checking in.[wait:2]\n* I'm...", nil, garbage, { auto = true })
            cutscene:hideNametag()
            genBigText("still", 210, 40)
            genBigText("a", 380, 40, 2, false, 0.1)
            genBigText("piece", 205, 110)
            genBigText("of", 370, 110)
            flashScreen()
            genBigText("GARBAGE", 35, 160, 6, true, 2)
            fadeOutBigText()
        end

        cutscene:wait(1)
        cutscene:look("down")
        Game.world.music:resume()
    end,

    magshop = function(cutscene, event)
        local menu = {
            {
                name = "food",
                first_level_disp = "Food",
                prompt = "kind of food",
                items = {
                    { id = "pepbrew", name = "Pep Brew", price = 100, some = "some" },
                    { id = "apple_uneaten", name = "Apple", price = 250, some = "an" },
                    { id = "maximtomato", name = "Maxim Tomato", price = 5000 },
                }
            },
            {
                name = "weapon",
                name_counted = "weapons",
                first_level_disp = "Weapons",
                items = {
                    { id = "mets_bat", name = "Mets Bat", price = 700, post_purchase = function()
                        cutscene:text("* Actually,[wait:10] did you know...", "happy", "magolor")
                        cutscene:text("* that this bat is signed and autographed by Daniel Vogelbach?", "wink",
                        "magolor")
                        cutscene:text("* I know![wait:10] I thought it was crazy too!", "pensive", "magolor")
                        cutscene:text("* But it's true![wait:10] I met Daniel Vogelbach and I got this bat signed!", "happy", "magolor")
                        cutscene:text("* Y'know I think it's really been a shame that...", "angry", "magolor")
                        cutscene:text("* The Mets have been on a drystreak lately!", "angry", "magolor")
                        cutscene:text("* And people keep making fun of them!", "upset", "magolor")
                        cutscene:text("* BUT NOT ANYMORE BABY!!", "wink", "magolor")
                        cutscene:text("* It's not about the theme parks anymore!", "sad", "magolor")
                        cutscene:text("* IT'S ABOUT THE METS BABY, THE METS!", "happy", "magolor")
                        if cutscene:getCharacter("dess") then
                            cutscene:showNametag("Dess")
                            cutscene:text("* YEAHHHHHH!", "condescending", "dess")
                        end
                    end },
                    { id = "powerring", name = "PowerRing", price = 1000 },
                }
            },
            {
                name = "armor",
                name_counted = "armors",
                first_level_disp = "Armor",
                items = {}
            }
        }

        local function onDeclined()
            cutscene:showNametag("Magolor")
            cutscene:text("* Uh,[wait:5] okay then.", "pensive", "magolor")
            cutscene:text("* Nobody likes a window shopper.", "unamused", "magolor")
            cutscene:hideNametag()
        end
        local function onCateHasNoItems(category_name)
            cutscene:showNametag("Magolor")
            cutscene:text(string.format("* Sorry,[wait:5] I don't have any %s right now.", category_name), "sad", "magolor")
            cutscene:hideNametag()
        end
        local function onCateSelected(prompt)
            cutscene:showNametag("Magolor")
            cutscene:text(string.format("* What %s would you like?", prompt), "happy", "magolor")
            cutscene:hideNametag()
        end
        local function onItemSelected(item)
            cutscene:showNametag("Magolor")
            cutscene:text(string.format("* Do you want to buy %s %s for %dD$?", item.some or "a", item.name, item.price), "neutral", "magolor")
            cutscene:hideNametag()
        end
        local function onMoneyNotEnough()
            cutscene:showNametag("Magolor")
            cutscene:text("* Come back when you can actually afford this...", "unamused", "magolor")
            cutscene:hideNametag()
        end
        local function onInventoryFull()
            cutscene:showNametag("Magolor")
            cutscene:text("* Your pockets look too full for this...", "unamused", "magolor")
            cutscene:hideNametag()
        end
        local function onPurchaseComplete(special_message)
            special_message = special_message or function() end

            cutscene:playSound("locker")
            cutscene:showNametag("Magolor")
            cutscene:text("* Here you go!", "happy", "magolor")
            cutscene:text("* Pleasure doing business with you!", "wink", "magolor")
            special_message()
            cutscene:hideNametag()
        end

        cutscene:showNametag("Magolor")
        cutscene:text("* Welcome to my shoppe!", "happy", "magolor")
        cutscene:text("* What would you like to buy?", "neutral", "magolor")
        cutscene:hideNametag()

        local fstlvl_opinion_list = {}
        for _, v in ipairs(menu) do
            table.insert(fstlvl_opinion_list, v.first_level_disp)
        end
        table.insert(fstlvl_opinion_list, "None")
        local fstlvl_opinion = cutscene:choicer(fstlvl_opinion_list)
        if fstlvl_opinion == #fstlvl_opinion_list then
            onDeclined()
            return
        end

        local cate = menu[fstlvl_opinion]
        if #cate.items < 1 then
            onCateHasNoItems(cate.name_counted or cate.name)
            return
        end
        onCateSelected(cate.prompt or cate.name)
        local sndlvl_opinion_list = {}
        for _, v in ipairs(cate.items) do
            table.insert(sndlvl_opinion_list, v.name)
        end
        table.insert(sndlvl_opinion_list, "None")
        local sndlvl_opinion = cutscene:choicer(sndlvl_opinion_list)
        if sndlvl_opinion == #sndlvl_opinion_list then
            onDeclined()
            return
        end

        local item = cate.items[sndlvl_opinion]
        --cutscene:showShop()
        onItemSelected(item)
        local buy = cutscene:choicer({ "Yes", "No" })
        --cutscene:hideShop()
        if buy == 2 then
            onDeclined()
            return
        end

        if Game.money <= item.price then
            onMoneyNotEnough()
            return
        end

        local itemcheck = Game.inventory:addItem(item.id)
        if not itemcheck then
            onInventoryFull()
            return
        end
        Game.money = Game.money - item.price

        onPurchaseComplete(item.post_purchase)
    end,

    whitedoor = function(cutscene, event)
        cutscene:text("* A white door casts a faint shadow...")
        cutscene:text("* Will you enter it?")

        local choice = cutscene:choicer({"Yes", "No"})
        if choice == 2 then
            cutscene:text("* You doorn't.")
            return
        end

        cutscene:text("* You opened the door...")
        cutscene:fadeOut(2, {color = {1, 1, 1}, music = true, blend = "add"})
        cutscene:wait(2)
        Game.fader.fade_color = {1, 1, 1} -- overwrite default for mapTransition
        if Game.world.map.id == "room3" then
            cutscene:mapTransition("whitespace", "entry")
        elseif Game.world.map.id == "whitespace" then
            cutscene:mapTransition("room3", "exit_whitespace")
        end
        cutscene:look("down")
        cutscene:wait(cutscene:fadeIn(2, {color = {1, 1, 1}}))
    end,

    transition = function(cutscene, event)
        if love.math.random(1, 50) <= 5 then
            Game.world:mapTransition("pizzatower", "entrance")
        else
            Game.world:mapTransition("room1", "entry2")
        end
    end,
}
