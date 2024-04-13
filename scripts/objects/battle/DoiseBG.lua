local BG, super = Class(Object)

function BG:init()
    super.init(self)

    local bg1 = Sprite("battle/doise_battlebg1")
	bg1.wrap_texture_x = true
	bg1.wrap_texture_y = true
	bg1:setScale(2)
	bg1.physics.speed_x = 0.5
	bg1.physics.speed_y = 0.5
	self:addChild(bg1)

    local bg2 = Sprite("battle/doise_battlebg2")
	bg2.wrap_texture_x = true
	bg2.wrap_texture_y = true
	bg2:setScale(2)
	bg2.physics.speed_x = -1
	bg2.physics.speed_y = -1
	self:addChild(bg2)

    self.layer = BATTLE_LAYERS["bottom"]
end

function BG:update()
    super.update(self)
end

function BG:draw()
    super.draw(self)
end

return BG