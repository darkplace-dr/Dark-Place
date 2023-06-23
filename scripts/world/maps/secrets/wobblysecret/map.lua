local WobblySecret, super = Class(Map)

function WobblySecret:onEnter()
    super.onEnter(self)

    local bg = Sprite("objects/pt_secretbg")
    bg:setWrap(true)
    bg.physics.speed_x = 1
    bg.physics.speed_y = 1

    bg:setScale(1)
    bg.parallax_x = 0
    bg.parallax_y = 0
    Game.world:addChild(bg)
end

return WobblySecret