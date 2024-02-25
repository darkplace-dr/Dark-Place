local LeafPiece, super = Class(Object)

function LeafPiece:init(x, y, speed, handler)
    super.init(self)
    self:setPosition(x, y)
    self.speed = speed or 2
    for i, p in ipairs(Game.stage.weather) do
        if p.type == "volcanic" then self.speed = self.speed * 1.5 end
    end
    if handler.addto == Game.world then
        self:setLayer(WORLD_LAYERS["below_ui"] - 1)
    elseif handler.addto == Game.battle then
        self:setLayer(BATTLE_LAYERS["below_ui"] - 1)
    end

    self.leafsprite = Sprite("world/wind/leaf")
    self:addChild(self.leafsprite)
    self.leafsprite:setScale(1)
    local spspeed = Utils.random(0.2, 0.5)
    self.leafsprite:play(spspeed)
    --self:setPosition(self.x, self.y - (self.snowsprite.height * 2))
    --self:addChild(self.rainsprite)
    self.initx, self.inity = self.x, self.y
    self.alpha_mult = Utils.random(0.4, 1.2)
    self.fade = self.alpha_mult
    
    self.width, self.height = 6, 6
    self:setRotationOrigin(1, 0)

    self.addto = handler.addto
    self.handler = handler
end

function LeafPiece:update()
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


    self.y = self.y + (self.speed/4) * DTMULT

    self: move(0, math.sin(RUNTIME * self.speed * 2)* 3, 0.2, DTMULT * self.speed * 2)
    self.x = self.x - (self.speed * 0.75) * DTMULT

    self.rotation = math.sin(RUNTIME * self.speed/3) + (0.5 * DTMULT)

    local _, y = self:getRelativePos(self.x, self.y, Game.stage)
    local y2 = Game.world.camera.y + (SCREEN_HEIGHT/2)
    local x2 = Game.world.camera.x - (SCREEN_WIDTH/2)

    if self.y > y2 + 15 then self:remove() end

    if self.x < x2 - 15 then self:remove() end
end

--[[function LeafPiece:draw()
    super.draw(self)

    --[[local premult_shader = love.graphics.newShader
[[
  vec4 effect(vec4 colour, Image tex, vec2 texpos, vec2 scrpos)
  {
    return colour.a * vec4(colour.rgb, 1.0) * Texel(tex, texpos);
  }


    --Draw.setColor(208/255, 199/255, 1, 131/255)
    --Draw.setColor(1, 1, 1, 0)

    --love.graphics.setShader(premult_shader)
    --love.graphics.setBlendMode("add")
    --self.rainsprite.width, self.rainsprite.height = 2, 2
    self.leafsprite:drawAlpha(1)
    --love.graphics.setBlendMode("alpha")
    --love.graphics.setShader()
end]]

return LeafPiece