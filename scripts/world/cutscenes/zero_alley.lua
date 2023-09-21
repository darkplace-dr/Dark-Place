return{

    -- very much wip
    start = function (cutscene, event)
        Game.lock_movement = false
        cutscene:detachFollowers()
        local susie = cutscene:getCharacter("susie")
        cutscene:setSprite(susie, "hold_axe")
        susie.graphics.shake_x = 1
        Assets.playSound("wing")
        Assets.playSound("sword_struggle")
        cutscene:wait(1.8)
        -- offsets are weird so we need to fake it with this
        susie.alpha = 0
        local swinganim = Sprite("party/susie/dark/battle/attack")
        swinganim.x = -26 swinganim.y = -25
        swinganim:play(1/15, false)
        susie:addChild(swinganim)
        susie.graphics.shake_x = 0
        Assets.playSound("laz_c")
        Assets.playSound("bigcut")
        cutscene:wait(2)
        swinganim:remove()
        susie.alpha = 1
        susie.actor.default = "walk_unhappy"
        susie:resetSprite()
        --cutscene:attachFollowers()
        
    end
}