return function(script, chara)
    local kris = Game.world:getCharacter("kris")
    if kris then
        local x = Game.world.player.x - 198
        local y = Game.world.player.y - 20

        kris:explode()
        Game.world.timer:after(0.25, function()
            Kristal.hideBorder(0)

            Game.state = "GAMEOVER"
            if Game.battle   then Game.battle  :remove() end
            if Game.world    then Game.world   :remove() end
            if Game.shop     then Game.shop    :remove() end
            if Game.gameover then Game.gameover:remove() end
            
            Game.gameover = GetFucked(x or 0, y or 0)
            Game.stage:addChild(Game.gameover)
        end)
    end
end