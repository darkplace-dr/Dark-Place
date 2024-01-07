return {
    ---@param cutscene WorldCutscene
    i_remember_youre = function(cutscene, event)
        local sans_meme = cutscene:getCharacter("sans_meme")
		
        if not Game.world.sanscheck then
            Game.world.sanscheck = 0
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
		
		local function remembering()
            Game.world.music:pause()
            if Game.world.sanscheck == 1 then
                sans_meme:setSprite("neutrals")
            elseif Game.world.sanscheck == 2 then
                sans_meme:setSprite("pacifists")
            elseif Game.world.sanscheck == 3 then
                sans_meme:setSprite("non_binary")
            elseif Game.world.sanscheck == 4 then
                sans_meme:setSprite("search_history")
            end
		end

        if Game.world.sanscheck == 0 then
            cutscene:showNametag("[font:sans]sans?")
            cutscene:text("[font:sans]* human..[wait:5] i rememeber you're [wait:10][facec:sans/meme/genocides][func:1][func:2][sound:vineboom][style:GONER][color:red][instant]genocides.[stopinstant][color:reset]", "serious", "sans", {
                functions = {
                    flashScreen,
                    remembering,
                }
            })
            cutscene:hideNametag()
        elseif Game.world.sanscheck == 1 then
            cutscene:showNametag("[font:sans]sans?")
            cutscene:text("[font:sans]* human..[wait:5] i rememeber you're [wait:10][facec:sans/meme/neutrals][func:1][func:2][sound:mercyadd][style:GONER][instant][color:yellow]neutrals.[stopinstant][color:reset]", "serious", "sans", {
                functions = {
                    flashScreen,
                    remembering,
                }
            })
            cutscene:hideNametag()
        elseif Game.world.sanscheck == 2 then
            cutscene:showNametag("[font:sans]sans?")
            cutscene:text("[font:sans]* human..[wait:5] i rememeber you're [wait:10][facec:sans/meme/pacifists][func:1][func:2][sound:sparkle_glock][style:GONER][color:green][instant]pacifists.[stopinstant][color:reset]", "serious", "sans", {
                functions = {
                    flashScreen,
                    remembering,
                }
            })
            cutscene:hideNametag()
        elseif Game.world.sanscheck == 3 then
            cutscene:showNametag("[font:sans]sans?")
            cutscene:text("[font:sans]* human..[wait:5] i rememeber you're [wait:10][facec:sans/meme/nonbinary][func:1][func:2][sound:sparkle_gem][style:GONER][instant][color:yellow]no[color:white]n-[color:purple]bin[color:404040]ary.[stopinstant][color:reset]", "serious", "sans", {
                functions = {
                    flashScreen,
                    remembering,
                }
            })
            cutscene:hideNametag()
        elseif Game.world.sanscheck == 4 then
            cutscene:showNametag("[font:sans]sans?")
            cutscene:text("[font:sans]* human..[wait:5] i rememeber you're [wait:10][facec:sans/meme/searchhistory][func:1][func:2][sound:fartrevshort][style:GONER][instant][color:ff8000]search history.[stopinstant][color:reset]", "serious", "sans", {
                functions = {
                    flashScreen,
                    remembering,
                }
            })
            cutscene:hideNametag()
        elseif Game.world.sanscheck >= 5 then
            cutscene:showNametag("[font:sans]sans?")
            cutscene:text("[font:sans]* human..[wait:5] i rememeber you're...", "serious", "sans")
            cutscene:text("[font:sans]* ...", "serious", "sans")
            cutscene:hideNametag()
            cutscene:wait(2)
            Assets.playSound("wing")
            sans_meme:setSprite("forgor")
            sans_meme:shake(4, 0)
            cutscene:wait(0.5)
            cutscene:text("[font:sans]* uhhh [wait:5][func:1][func:2][sound:vineboom][style:GONER][color:red][instant]shit[stopinstant][style:none][color:reset][wait:5] uhhh[wait:10] the [func:1][func:2][sound:vineboom][style:GONER][color:red][instant]fuck[stopinstant][style:none][color:reset]\n was i gonna say uhh", "meme/forgor", "sans", {
                functions = {
                    flashScreen,
                    remembering,
                }
            })
            cutscene:hideNametag()
        end
        sans_meme:resetSprite()
		
        if Game.world.sanscheck < 5 then
            Game.world.sanscheck = Game.world.sanscheck + 1
        end
        Game.world.music:resume()
    end,
}