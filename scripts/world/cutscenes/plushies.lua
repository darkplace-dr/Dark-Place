return {
    dess_plush = function(cutscene)
        local dess_plush = cutscene:getCharacter("dess_plush")
        local dess = cutscene:getCharacter("dess")
        local susie = cutscene:getCharacter("susie")
        if dess then
            cutscene:showNametag("Dess")
            cutscene:text("* Dang,[wait:5] I wonder how this got here.", "genuine", dess)
            cutscene:text("* Dang,[wait:5] I REALLY wonder how this thing got here.", "kind", dess)
            cutscene:text("* Good Heavens,[wait:5] I REALLY feel like pondering on how this marketable stuffed version of myself had made it's way to the location we currently are standing on.", "condescending", dess)
            if susie then
                cutscene:showNametag("Susie")
                cutscene:text("* SHUT UP!!!", "teeth", susie)
                cutscene:showNametag("Dess")
                cutscene:text("* k.", "condescending", dess)
            end
        end
        cutscene:hideNametag()
        Assets.playSound("achievement")
        cutscene:text("* You found the Dess Plush!")
        Assets.playSound("item")
        dess_plush:remove()
        Game:setFlag("dess_plush", true)
    end,
    you_plush = function(cutscene)
        Game.world.music:stop()
        local YOU = cutscene:getCharacter("you_plush")
        cutscene:wait(2)

        local zoom_sfx = cutscene:playSound("emotion")
        local function zoom(scale, wait, overwrite_pos)
            local tx, ty = YOU:getRelativePos(YOU.width/2, YOU.height/2)
            Game.world.camera:setZoom(scale)
            if overwrite_pos then
                Game.world.camera:setPosition(overwrite_pos[1], overwrite_pos[2])
            else
                Game.world.camera:setPosition(tx, ty)
            end
            cutscene:wait(wait)
        end
        
        cutscene:detachCamera()
        zoom(2, 1/4)
        zoom(3, 1/4)
        zoom(4, 1/2)
        zoom(6, 1/2)
        local emotion = Sprite("world/cutscenes/react_to_YOU/bigemotion", -1.25, 6.5)
        emotion:setScale(0.0625, 0.0625)
        YOU:addChild(emotion)
        zoom(8, zoom_sfx, {Game.world.camera.x, Game.world.camera.y - 18})
        emotion:remove()
        zoom(1, 0)
        cutscene:attachCameraImmediate()

        Game.world.music:play()

        Assets.playSound("achievement")
        cutscene:text("* You found the YOU Plush!")
        Assets.playSound("item")
        YOU:remove()
        Game:setFlag("you_plush", true)
    end,
    brenda_plush = function(cutscene)
        local brenda_plush = cutscene:getCharacter("brenda_plush")
        Assets.playSound("achievement")
        cutscene:text("* You found the Brenda Plush!")
        Assets.playSound("item")
        brenda_plush:remove()
        Game:setFlag("brenda_plush", true)
    end,
    jamm_plush = function(cutscene)
        local plush = cutscene:getCharacter("jamm_plush")
        Assets.playSound("achievement")
        cutscene:text("* You found the Jamm Plush!")
        Assets.playSound("item")
        plush:remove()
        Game:setFlag("jamm_plush", true)
    end,
    starwalker_plush = function(cutscene)
        local plush = cutscene:getCharacter("starwalker_plush")
        Assets.playSound("achievement")
        cutscene:text("* You found the Starwalker Plush!")
        Assets.playSound("item")
        plush:remove()
        Game:setFlag("starwalker_plush", true)
    end,
}