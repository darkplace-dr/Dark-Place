return {
    wobblything = function(cutscene, wobblything)
        local wobblything = cutscene:getEvent("wobblything")
        
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
            local tx, ty = wobblything:getRelativePos(wobblything.width/2, wobblything.height/2)
            Game.world.camera:setZoom(scale)
            if overwrite_pos then
                Game.world.camera:setPosition(overwrite_pos[1], overwrite_pos[2])
            else
                Game.world.camera:setPosition(tx, ty)
            end
            cutscene:wait(wait)
        end
        
        cutscene:detachCamera()
        cutscene:wait(5)
        
        Assets.playSound("vineboom")
        Game.world.music:play("wobblything_loop")
        zoom(2, 0)
        flashScreen()
        genBigText("HOLY SHIT", 200, 115, 2)
        
        cutscene:wait(3)
        Assets.playSound("vineboom")
        genBigText("IT'S A WOBBLY THING", 200, 318, 1)
        
        cutscene:wait(3)
        Assets.playSound("vineboom")
        removeBigText()
        genBigText("11/10", 250, 115, 2)
        
        cutscene:wait(3)
        Assets.playSound("vineboom")
        genBigText("BEST LIBRARY", 161, 298, 2)
        
        cutscene:wait(3)
        local nyako = Sprite("world/cutscenes/wobblything/nyako_quote", 200, 180)
        nyako:setScale(0.7525, 1)
        nyako:setLayer(9999)
        Game.world:addChild(nyako)
		
        Assets.playSound("vineboom", 5)
    
        cutscene:wait(0.3)
        removeBigText()
        nyako:remove()
        Assets.stopSound("vineboom")
        Game.world.music:stop()
        zoom(1, 0)
        cutscene:attachCameraImmediate()
    end,
}