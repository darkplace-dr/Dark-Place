local SnowPiece, super = Class(Object)

function SnowPiece:init(number, x, y, speed, rotspeed, sinerspeed, lifespan, handler)
    super.init(self)
    self:setPosition(x, y)
    self.number = number
    self.speed = speed or 2
    
    for i, p in ipairs(Game.stage.weather) do
        if p.type == "rain" then self.speed = self.speed * 1.2
        elseif p.type == "thunder" then self.speed = self.speed * 1.6 end
    end
    self.rotspeed = rotspeed or 0.2
    self.sinerspeed = sinerspeed or 1
    self.lifespan = lifespan
    if handler.addto == Game.world then
        self:setLayer(WORLD_LAYERS["below_ui"] - 1)
    elseif handler.addto == Game.battle then
        self:setLayer(BATTLE_LAYERS["below_ui"] - 1)
    end

    self.snowsprite = Sprite("world/snow/"..number)
    --self:setPosition(self.x, self.y - (self.snowsprite.height * 2))
    --self:addChild(self.rainsprite)
    self.initx, self.inity = self.x, self.y
    self.alpha_mult = Utils.random(0.4, 1.95)
    self.fade = self.alpha_mult
    
    self.width, self.height = 6, 6
    self:setRotationOrigin(1, 1)

    self.handler = handler
end

function SnowPiece:update()
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

    for i, p in ipairs(Game.stage.weather) do
        if p.type == "rain" or p.type == "thunder" or p.type == "wind" then self.rain_move = true end
    end
    self.y = self.y + (self.speed * DTMULT)

    if self.rain_move then self.x = self.x - (self.speed/2 * DTMULT) end

    self: move(math.cos(RUNTIME * self.sinerspeed) * (4^DTMULT), math.sin(RUNTIME * self.sinerspeed)* (1^DTMULT), 0.2, DTMULT * self.speed)

    self.rotation = self.rotation + (self.rotspeed/24 * DTMULT)

    local _, y = self:getRelativePos(self.x, self.y, Game.stage)
    local y2 = Game.world.camera.y + (SCREEN_HEIGHT/2)
    local x2 = Game.world.camera.x - (SCREEN_WIDTH/2)

    if self.y > y2 then self:remove() end
    --if self.x < x2 then self:remove() end

    if self.y - self.inity > self.lifespan then
        self.fade = self.fade - DTMULT * 0.01
        if self.fade < 0.05 then self:remove() end
    end
end

function SnowPiece:draw()
    super.draw(self)

    --[[local premult_shader = love.graphics.newShader
[[
  vec4 effect(vec4 colour, Image tex, vec2 texpos, vec2 scrpos)
  {
    return colour.a * vec4(colour.rgb, 1.0) * Texel(tex, texpos);
  }
]]

    --Draw.setColor(208/255, 199/255, 1, 131/255)
    --Draw.setColor(1, 1, 1, 0)

    --love.graphics.setShader(premult_shader)
    love.graphics.setBlendMode("add")
    --self.rainsprite.width, self.rainsprite.height = 2, 2
    self.snowsprite:drawAlpha(self.fade)
    love.graphics.setBlendMode("alpha")
    --love.graphics.setShader()
end

return SnowPiece