local RainPiece, super = Class(Object)

function RainPiece:init(number, x, y, speed, handler)
    super.init(self)
    self:setPosition(x, y)
    self.number = number
    self.speed = speed or 2
    if handler.addto == Game.world then
        self:setLayer(WORLD_LAYERS["below_ui"] - 1)
    elseif handler.addto == Game.battle then
        self:setLayer(BATTLE_LAYERS["below_ui"] - 1)
    end
    self.alpha = 0.5

    self.rainsprite = Sprite("world/rain/"..number)
    self.rainsprite:setScale(2)
    self.rainsprite.inherit_color = true
    self:setPosition(self.x, self.y - (self.rainsprite.height * 2))
    --self:addChild(self.rainsprite)
    self.initx, self.inity = self.x, self.y

    self.addto = handler.addto
    self.handler = handler
end

function RainPiece:update()
    super.update(self)

    if self.handler.addto == Game.world then
        if self.parent ~= Game.world then
            local newx, newy = self.parent:getRelativePos(self.x, self.y, Game.world)
            self.parent:removeChild(self)
            Game.world:addChild(self)
            self:setPosition(newx, newy)
        end
        if self.layer ~= WORLD_LAYERS["below_ui"] - 1 then
            self:setLayer(WORLD_LAYERS["below_ui"] - 1)
        end
    elseif self.handler.addto == Game.battle then
        if self.parent ~= Game.battle then
            local newx, newy = self.parent:getRelativePos(self.x, self.y, Game.battle)
            self.parent:removeChild(self)
            Game.battle:addChild(self)
            self:setPosition(newx, newy)
        end

        if self.layer ~= BATTLE_LAYERS["below_ui"] - 1 then
            self:setLayer(BATTLE_LAYERS["below_ui"] - 1)
        end
    end
    
    self.x, self.y = self.x - self.speed * 0.5 * DTMULT, self.y + self.speed * DTMULT

    local _, y = self:getRelativePos(self.x, self.y, self.addto)
    local y2 = Game.world.camera.y + (SCREEN_HEIGHT/2)
    local x2 = Game.world.camera.x - (SCREEN_WIDTH/2)

    if self.y > y2 then self:remove() end
    --if self.x < x2 then self:remove() end

    if self.y - self.inity > (Game.world.map.height * Game.world.map.tile_height) + 120 then
        Utils.approach(self.rainsprite.alpha, 0, DTMULT)
        if self.alpha < 1 then self:remove() end
    end
end

function RainPiece:draw()
    super.draw(self)

    --[[local premult_shader = love.graphics.newShader
[[
  vec4 effect(vec4 colour, Image tex, vec2 texpos, vec2 scrpos)
  {
    return colour.a * vec4(colour.rgb, 1.0) * Texel(tex, texpos);
  }
]]

    --Draw.setColor(208/255, 199/255, 1, 131/255)
    Draw.setColor(1, 1, 1, 0)

    --love.graphics.setShader(premult_shader)
    love.graphics.setBlendMode("add")
    --self.rainsprite.width, self.rainsprite.height = 2, 2
    self.rainsprite:drawAlpha(0.4)
    love.graphics.setBlendMode("alpha")
    --love.graphics.setShader()
end

return RainPiece