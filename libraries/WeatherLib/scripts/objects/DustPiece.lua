local DustPiece, super = Class(Object)

function DustPiece:init(letter, x, y, speed, handler)
    super.init(self)
    self:setPosition(x, y)
    self.speed = speed or 2
    if Game.stage.weather.both then self.speed = self.speed * 1.4 end
    if handler.addto == Game.world then
        self:setLayer(WORLD_LAYERS["below_ui"] - 1)
    elseif handler.addto == Game.battle then
        self:setLayer(BATTLE_LAYERS["below_ui"] - 1)
    end

    self.dustsprite = Sprite("world/dust/"..letter)
    self:addChild(self.dustsprite)
    self.dustsprite:setScale(1)
    --local spspeed = MathUtils.random(0.2, 0.5)
    --self.dustsprite:play(spspeed)
    --self:setPosition(self.x, self.y - (self.snowsprite.height * 2))
    --self:addChild(self.rainsprite)
    self.initx, self.inity = self.x, self.y
    self.alpha_mult = MathUtils.random(0.4, 1.2)
    self.fade = self.alpha_mult
    
    self.width, self.height = 6, 6
    self:setRotationOrigin(1, 0)

    self.addto = handler.addto
    self.handler = handler
end

function DustPiece:update()
    super.update(self)

    --self.y = self.y + self.speed/4

    self: move( - self.speed * 5, math.sin(RUNTIME * self.speed * 0.1)* 4, 0.15, DTMULT * self.speed * 2)
    --self.x = self.x - self.speed * 0.75

    self.rotation = math.sin(RUNTIME * self.speed/3) + 0.5

    local _, y = self:getRelativePos(self.x, self.y, Game.stage)
    local y2 = Game.world.camera.y + (SCREEN_HEIGHT/2)
    local x2 = Game.world.camera.x - (SCREEN_WIDTH/2)

    if self.y > y2 + 15 then self:remove() end

    if self.x < x2 - 15 then self:remove() end
end

function DustPiece:draw()
    
    love.graphics.setBlendMode("add")
    self.dustsprite:drawAlpha(self.fade)
    love.graphics.setBlendMode("alpha")

end

return DustPiece