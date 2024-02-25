local CustomWeatherOverlay, super = Class(Object)

function CustomWeatherOverlay:init(handler)
    super.init(self)
    self.type = handler.type
    self.parallax_x, self.parallax_y = 0, 0
    self.handler = handler
    if handler.addto == Game.world then
        self:setLayer(WORLD_LAYERS["below_ui"])
    elseif handler.addto == Game.battle then
        self:setLayer(BATTLE_LAYERS["below_ui"])
    end
    self.paused = false
    if self.handler.pause then self.paused = true self.pause = true end
    
end

function CustomWeatherOverlay:draw()
    super.draw(self)

    if self.handler.addto == Game.world then
        if self.parent ~= Game.world then
            --local newx, newy = self.parent:getRelativePos(self.x, self.y, Game.world)
            self.parent:removeChild(self)
            Game.world:addChild(self)
            --self:setPosition(newx, newy)
        end
        if self.layer ~= WORLD_LAYERS["below_ui"] then
            self:setLayer(WORLD_LAYERS["below_ui"])
        end
    elseif self.handler.addto == Game.battle then
        if self.parent ~= Game.battle then
            --local newx, newy = self.parent:getRelativePos(self.x, self.y, Game.battle)
            self.parent:removeChild(self)
            Game.battle:addChild(self)
            --self:setPosition(newx, newy)
        end

        if self.layer ~= BATTLE_LAYERS["below_ui"] then
            self:setLayer(BATTLE_LAYERS["below_ui"])
        end
    end

end

return CustomWeatherOverlay