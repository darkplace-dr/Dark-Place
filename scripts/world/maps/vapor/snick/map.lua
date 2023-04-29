local SecretArea1, super = Class(Map)

function SecretArea1:onEnter()
    super.onEnter(self)
	
    local snick_bg = Sprite("world/maps/vapor/snick_bg", 0, 0)
    snick_bg:setScale(1)
    snick_bg:setLayer(Game.world:parseLayer("objects_bg"))
    snick_bg.wrap_texture_x = true
    snick_bg.wrap_texture_y = true
    --snick_bg.parallax_x = 0.9
    Game.world:addChild(snick_bg)
end

return SecretArea1