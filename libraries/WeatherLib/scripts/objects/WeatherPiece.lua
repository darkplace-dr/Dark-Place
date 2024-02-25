


local WeatherPiece, super = Class("Object")

function WeatherPiece:init(path, sprite, x, y, speed, handler)
    super.init(self)

    self:setPosition(x, y)
    self.speed = speed or 20
    self.handler = handler

    self.sprite = Sprite(path.."/"..sprite)
    self.sprite:setScale(2)
    self.sprite.inherit_color = true
    self.initx, self.inity = self.x, self.y

    self.alpha = 1
    self.addto = self.handler.addto

    if handler.addto == Game.world then
        self:setLayer(WORLD_LAYERS["below_ui"] - 1)
    elseif handler.addto == Game.battle then
        self:setLayer(BATTLE_LAYERS["below_ui"] - 1)
    end

    self.blend_mode = "alpha"

    self.offscreen_sides = {} -- top, bottom, left, right (strings). the sides of the screen where the weather piece goes "offscreen"
end

function WeatherPiece:update()
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

    self:handleMovement(self.x, self.y, self.initx, self.inity)
    self:isOffscreen(self.offscreen_sides)
end

function WeatherPiece:handleMovement(x, y, initx, inity) end

function WeatherPiece:isOffscreen(sides)

    if type(sides) == "string" then sides = {sides} end

    local types = {
        ["top"] = false,
        ["bottom"] = false,
        ["right"] = false,
        ["left"] = false
    }

    for i,sd in ipairs(sides) do
        if types[sd] ~= nil then
            types[sd] = true
        else
            error("WEATHERLIB: "..sd.." is not a side of the screen!\nSides include: top, bottom, left, right")
        end
    end

    local y1 = Game.world.camera.y - (SCREEN_HEIGHT/2) -- top
    local x1 = Game.world.camera.x + (SCREEN_WIDTH/2)  -- right
    local y2 = Game.world.camera.y + (SCREEN_HEIGHT/2) -- bottom
    local x2 = Game.world.camera.x - (SCREEN_WIDTH/2)  -- left

    local x, y = self.x, self.y

    for side, bool in pairs(types) do

        if side == "top" and bool then
            if y < y1 then self:onOffscreen() --[[print("t")]] end
        end

        if side == "bottom" and bool then
            if y > y2 then self:onOffscreen() --[[print("b")]] end
        end

        if side == "right" and bool then
            if x > x1 then self:onOffscreen() --[[print("r")]] end
        end

        if side == "left" and bool then
            if x < x2 then self:onOffscreen() --[[print("l")]] end
        end

    end
end

function WeatherPiece:onOffscreen()
    self:remove()
end

function WeatherPiece:draw()
    super.draw(self)

    Draw.setColor(1, 1, 1, 0)

    love.graphics.setBlendMode(self.blend_mode)
    self.sprite:drawAlpha(self.alpha)
    love.graphics.setBlendMode("alpha")
end

return WeatherPiece