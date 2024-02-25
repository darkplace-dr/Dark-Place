local ThunderFlash, super = Class(Object)

function ThunderFlash:init(handler)
    super.init(self)
    self.parallax_x, self.parallax_y = 0, 0
    self.flashtimer, self.flashtime = 20, 30
    if handler.addto == Game.world then
        self:setLayer(WORLD_LAYERS["below_ui"] + 1)
    elseif handler.addto == Game.battle then
        self:setLayer(BATTLE_LAYERS["below_ui"] + 1)
    end
end

function ThunderFlash:update()
    self.flashtimer = self.flashtimer - DTMULT

    if self.flashtimer <= 0 then self:remove() end
    super.update(self)
end

function ThunderFlash:draw()
    super.draw(self)

    love.graphics.setBlendMode("add")
    Draw.setColor(1, 1, 1, self.flashtimer/self.flashtime)
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setBlendMode("alpha")
end

return ThunderFlash