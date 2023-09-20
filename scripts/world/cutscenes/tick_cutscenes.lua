local baatp = false

return {
    banana = function(cutscene, event)
        cutscene:text("* It's a banana reserve.")
    end,
    potassium = function(cutscene, event)
        cutscene:text("* It's a potassium reserve.")
    end,
    blood = function(cutscene, event)
        cutscene:text("* There is a K+ on the wall.")
        cutscene:text("* It's written with [color:red][wait:30]blood[color:white]?")
    end,
    clock = function(cutscene, event)
        cutscene:text("* It's a clock.")
        cutscene:text("* It indicates 3:58 AM..?")
        cutscene:text("* The clock is broken.")
    end,
    smell = function(cutscene, event)
        cutscene:text("* It smells potassium.")
    end,
    k = function(cutscene, event)
        cutscene:text("* Potassium.")
    end,
    bed = function(cutscene, event)

        if not Game:getFlag("bananabed") then
            Game.world.music:pause()
            
            local texts = {}
            local function genBigText(text, x, y, scale, goner, wait_time)
                scale = scale or 2
                wait_time = wait_time or 0.2

                local text = Game.world:spawnObject(Text(text, x, y, 300, 500, { style = goner and "GONER" or "dark" }))
                text:setScale(scale)
                text.parallax_x = 0
                text.parallax_y = 0
                text.layer = 1000
                if goner then
                    text.alpha = 1
                end
                table.insert(texts, text)

                cutscene:wait(wait_time)

                return text
            end
            
            local function removeBigText()
                for _, v in ipairs(texts) do
                    v:remove()
                end
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

            local function zoom(scale, wait, overwrite_pos)
                Game.world.camera:setZoom(scale)
                if overwrite_pos then
                    Game.world.camera:setPosition(overwrite_pos[1], overwrite_pos[2])
                else
                    Game.world.camera:setPosition(600, 250)
                end
                cutscene:wait(wait)
            end

            local dancing_banana = Sprite("kristal/banana")
            dancing_banana:setScale(4)
            dancing_banana.layer = WORLD_LAYERS["ui"]
            dancing_banana:play(1/100, true)
            dancing_banana.x = 425
            dancing_banana.y = 200
            local dancing_banana2 = Sprite("kristal/banana")
            dancing_banana2:setScale(4)
            dancing_banana2.layer = WORLD_LAYERS["ui"]
            dancing_banana2:play(1/100, true)
            dancing_banana2.x = 675
            dancing_banana2.y = 200
            
            cutscene:detachCamera()
            cutscene:wait(1)

            Assets.playSound("bananabed")
            cutscene:wait(0.8)

            Game.world:addChild(dancing_banana)
            Game.world:addChild(dancing_banana2)
            zoom(2, 0)
            flashScreen()
            genBigText("SACREBLEU", 195, 115, 2)
            cutscene:wait(3.2)
            genBigText("LE BANANA BED", 195, 318, 1.5)
        
            cutscene:wait(8)
            removeBigText()
            Game.world.music:resume()
            zoom(1, 0)
            Game.world:removeChild(dancing_banana)
            Game.world:removeChild(dancing_banana2)
            cutscene:attachCameraImmediate()
            cutscene:text("* It looks uncomfortable.")
            Game:setFlag("bananabed", true)
        else
            cutscene:text("* It looks uncomfortable.")
        end
    end,
    news = function(cutscene, event)
        cutscene:text("* There is a newspaper article on the wall.")
        cutscene:text("* \"News: Grand Opening of [color:yellow]the Croustissium Towers!\"")
        cutscene:text("* \"By Raf Heure and Perzival Lumcigare\"")
        cutscene:text("* There is also a ripped photograph of someone.")
        Game:setFlag("croustissium", true)
    end,
    picture = function(cutscene, event)
        local tick = cutscene:getCharacter("tick")
        if not Game:getFlag("croustissium") then
                cutscene:text("* This is a picture of two weird towers.")
                cutscene:text("* There is also a note written in red.")
                cutscene:text("* [color:red]\"07/10, never forget...\"")
                if not Game:getFlag("gone_tick") then
                    cutscene:setSpeaker(tick)
                    cutscene:text("* ...", "head")
                end
        else
                cutscene:text("* This is a picture of the Croustissium Towers.")
                cutscene:text("* There is also a note written in red.")
                cutscene:text("* [color:red]\"07/10, never forget...\"")
                if not Game:getFlag("gone_tick") then
                    cutscene:setSpeaker(tick)
                    cutscene:text("* ...", "head")
                end
        end
    end,
    targe = function(cutscene, event)
        cutscene:text("* It's a target with a drawing of a potato.")
    end,
    pc = function(cutscene, event)
        local tick = cutscene:getCharacter("tick")
        local susie = cutscene:getCharacter("susie")
        if not Game:getFlag("gone_tick") then
            if not baatp then
                cutscene:text("* You turn the PC on.")
                Game.world.music:fade(0, 0.5, function() 
                    Game.world.music:stop() 
                    cutscene:wait(1.5)
                    Game.world.music:play("baatp") 
                    Game.world.music:setVolume(1) 
                end)
                cutscene:wait(2)
                cutscene:text("* You've just started Battle Against A True Potassium.")
                cutscene:text("* It sounds bad.")
                baatp = true    
            elseif baatp then
                cutscene:setSpeaker(tick)
                cutscene:text("* Don't turn this off, you croustibat!", "mhh")
            end
        else
            cutscene:setSpeaker(susie)
            cutscene:text("* Don't put that shit back on.", "sus_nervous")
        end
    end,
    tick = function(cutscene, event)
        local tick = cutscene:getCharacter("tick")
        if not baatp then
            cutscene:setSpeaker(tick)
            cutscene:text("* I am the Tick!", "head")
            cutscene:text("* And I am speaking for the potassium!", "k")
        elseif baatp then
            cutscene:setSpeaker(tick)
            cutscene:text("* It's the theme of a battle against me.", "mhh")
            cutscene:text("* Tick,[wait:15]\n[color:yellow]the true POTASSIUM[color:white]!", "head")
            cutscene:text("* .[wait:15].[wait:15].", "mhh")
            cutscene:text("* Hmmm, this music definitely needs a makeover.", "mhh")
            cutscene:text("* I guess you can say it was the demo of my theme.", "head")
            cutscene:text("* Because.", "head")
            cutscene:text("* You know, I made it for a demo.", "head")
            cutscene:text("* And yeah, a demo.", "head")
            cutscene:text("* You see.", "head")
            cutscene:text("* Like my theme.", "head")
            cutscene:text("* .[wait:15].[wait:15].", "mhh")
            cutscene:text("* How did i make something so bad xd?", "head")
            cutscene:text("* I mean who would want to fight someone that has a theme this awful?", "head")
            cutscene:text("* I wouldn't.", "classe")
            cutscene:text("* I'm sure the reason the theme is bad is Patate.", "head")
            cutscene:text("* He probably influenced me into making shit.", "head")
            cutscene:text("* DAMN YOU PATATE.", "head")
            cutscene:text("* Well, I have nothing better to tell you, see you soon.", "head")
            cutscene:text("* - [wait:15]Tick.", "mhh")
            cutscene:text("* PS: Gotcha you were reading a note all along.")
            Assets.playSound("mysterygo")
            Game.world.timer:tween(1, tick.sprite, {alpha = 0}, "linear", function()
                tick:remove()
                Game:setFlag("gone_tick", true)
            end)
        end
    end,
    removetick = function(cutscene, event)
        local tick = cutscene:getCharacter("tick")
        tick:remove()
    end,
}