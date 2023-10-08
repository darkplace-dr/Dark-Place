local GreenRoomSparkles, super = Class(Event)

function GreenRoomSparkles:init(x, y, w, h)
    super.init(self, x, y, w, h)
	
    self.solid = false
    self.sparkle_timer = 0
end

function GreenRoomSparkles:update()
    super.update(self)
    if (self.sparkle_timer < 5) then
        self.sparkle_timer = self.sparkle_timer + DTMULT
    else
        local sparkle = Sprite("world/maps/floor3/gr_star")
        sparkle:setScale(2)
        sparkle:play(1/6, false, function()
            sparkle:remove()
        end)
        self:addChild(sparkle)
        sparkle.x = math.random(0, self.width)
        sparkle.y = math.random(0, self.height)
        self.sparkle_timer = 0
    end
end

return GreenRoomSparkles