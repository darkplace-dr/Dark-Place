---@class EnemyTensionBar : Object
local EnemyTensionBar, super = Class(Object)

--[[
    A copy of TensionBar, meant to be used by enemies.
    Enemy TP is stored in Game.battle.encounter.enemy_tension, and is separate from Player TP.
    If enemy_tension isn't defined during encounter init, the bar will be disabled.
]]

function EnemyTensionBar:init(x, y, dont_animate)
    if Game.world and (not x) then
        local x2 = Game.world.camera:getRect()
        x = x2 - 25
    end

    -- TP bar colors
    self.tension_back = {128/255, 0, 0}                  -- Color for the empty part of the TP bar
    self.tension_fill = {255/255, 160/255, 64/255}       -- Color for the filled part of the TP bar
    self.tension_max  = {255/255, 208/255, 32/255}       -- Color the TP bar uses when at Max TP
    self.tension_maxtext = {1, 1, 0}                     -- Color used by the MAX text when at Max TP, which I didn't even notice was different until I made this


    super:init(self, x or 639, y or 40)

    self.layer = BATTLE_LAYERS["ui"] - 1

    if Game:getConfig("oldTensionBar") then
        self.tp_bar_fill = Assets.getTexture("ui/battle/tp_bar_fill_old")
        self.tp_bar_outline = Assets.getTexture("ui/battle/tp_bar_outline_old")
    else
        self.tp_bar_fill = Assets.getTexture("ui/battle/enemy_tp_bar_fill")
        self.tp_bar_outline = Assets.getTexture("ui/battle/enemy_tp_bar_outline")
    end

    self.width = self.tp_bar_outline:getWidth()
    self.height = self.tp_bar_outline:getHeight()

    self.apparent = 0
    self.current = 0

    self.change = 0
    self.changetimer = 15
    self.font = Assets.getFont("main")
    self.tp_text = Assets.getTexture("ui/battle/tp_text")

    self.parallax_y = 0

    -- still dont understand nil logic
    if dont_animate then
        self.animating_in = false
    else
        self.animating_in = true
    end

    self.animation_timer = 0

    self.tsiner = 0

    self.tension_preview = 0
    self.shown = false
end

function EnemyTensionBar:show()
    if not self.shown then
        self:resetPhysics()
        self.x = self.init_x
        self.shown = true
        self.animating_in = true
        self.animation_timer = 0
    end
end

function EnemyTensionBar:getDebugInfo()
    local info = super.getDebugInfo(self)
    table.insert(info, "Tension: "  .. Utils.round(self:getPercentageFor(Game.battle.encounter.enemy_tension) * 100) .. "%")
    table.insert(info, "Apparent: " .. Utils.round(self.apparent / 2.5))
    table.insert(info, "Current: "  .. Utils.round(self.current / 2.5))
    return info
end

function EnemyTensionBar:getTension250()
    return self:getPercentageFor(Game.battle.encounter.enemy_tension) * 250
end

function EnemyTensionBar:setTensionPreview(amount)
    self.tension_preview = amount
end

function EnemyTensionBar:getPercentageFor(variable)
    return variable / Game:getMaxTension()
end

function EnemyTensionBar:getPercentageFor250(variable)
    return variable / 250
end


function EnemyTensionBar:update()
    if self.animating_in then
        self.animation_timer = self.animation_timer + DTMULT
        if self.animation_timer > 12 then
            self.animation_timer = 12
            self.animating_in = false
        end

        self.x = Ease.outCubic(self.animation_timer, self.init_x,  -63, 12)
    end

    if (math.abs((self.apparent - self:getTension250())) < 20) then
        self.apparent = self:getTension250()
    elseif (self.apparent < self:getTension250()) then
        self.apparent = self.apparent + (20 * DTMULT)
    elseif (self.apparent > self:getTension250()) then
        self.apparent = self.apparent - (20 * DTMULT)
    end
    if (self.apparent ~= self.current) then
        self.changetimer = self.changetimer + (1 * DTMULT)
        if (self.changetimer > 15) then
            if ((self.apparent - self.current) > 0) then
                self.current = self.current + (2 * DTMULT)
            end
            if ((self.apparent - self.current) > 10) then
                self.current = self.current + (2 * DTMULT)
            end
            if ((self.apparent - self.current) > 25) then
                self.current = self.current + (3 * DTMULT)
            end
            if ((self.apparent - self.current) > 50) then
                self.current = self.current + (4 * DTMULT)
            end
            if ((self.apparent - self.current) > 100) then
                self.current = self.current + (5 * DTMULT)
            end
            if ((self.apparent - self.current) < 0) then
                self.current = self.current - (2 * DTMULT)
            end
            if ((self.apparent - self.current) < -10) then
                self.current = self.current - (2 * DTMULT)
            end
            if ((self.apparent - self.current) < -25) then
                self.current = self.current - (3 * DTMULT)
            end
            if ((self.apparent - self.current) < -50) then
                self.current = self.current - (4 * DTMULT)
            end
            if ((self.apparent - self.current) < -100) then
                self.current = self.current - (5 * DTMULT)
            end
            if (math.abs((self.apparent - self.current)) < 3) then
                self.current = self.apparent
            end
        end
    end

    if (self.tension_preview > 0) then
        self.tsiner = self.tsiner + DTMULT
    end

    if Game.battle.encounter.enemy_tension < 0 then
        Game.battle.encounter.enemy_tension = 0
    elseif Game.battle.encounter.enemy_tension > 100 then
        Game.battle.encounter.enemy_tension = 100
    end


    super.update(self)
end

function EnemyTensionBar:draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.tp_bar_outline, 0, 0)

    love.graphics.setColor(self.tension_back)
    Draw.pushScissor()
    Draw.scissorPoints(0, 0, 25, 196 - (self:getPercentageFor250(self.current) * 196) + 1)
    love.graphics.draw(self.tp_bar_fill, 0, 0)
    Draw.popScissor()

    if (self.apparent < self.current) then
        love.graphics.setColor(PALETTE["tension_decrease"])
        Draw.pushScissor()
        Draw.scissorPoints(0, 196 - (self:getPercentageFor250(self.current) * 196) + 1, 25, 196)
        love.graphics.draw(self.tp_bar_fill, 0, 0)
        Draw.popScissor()

        love.graphics.setColor(self.tension_fill)
        Draw.pushScissor()
        Draw.scissorPoints(0, 196 - (self:getPercentageFor250(self.apparent) * 196) + 1 + (self:getPercentageFor(self.tension_preview) * 196), 25, 196)
        love.graphics.draw(self.tp_bar_fill, 0, 0)
        Draw.popScissor()
    elseif (self.apparent > self.current) then
        love.graphics.setColor(1, 1, 1, 1)
        Draw.pushScissor()
        Draw.scissorPoints(0, 196 - (self:getPercentageFor250(self.apparent) * 196) + 1, 25, 196)
        love.graphics.draw(self.tp_bar_fill, 0, 0)
        Draw.popScissor()

        love.graphics.setColor(self.tension_fill)
        if (self.maxed) then
            love.graphics.setColor(self.tension_max)
        end
        Draw.pushScissor()
        Draw.scissorPoints(0, 196 - (self:getPercentageFor250(self.current) * 196) + 1 + (self:getPercentageFor(self.tension_preview) * 196), 25, 196)
        love.graphics.draw(self.tp_bar_fill, 0, 0)
        Draw.popScissor()
    elseif (self.apparent == self.current) then
        love.graphics.setColor(self.tension_fill)
        if (self.maxed) then
            love.graphics.setColor(self.tension_max)
        end
        Draw.pushScissor()
        Draw.scissorPoints(0, 196 - (self:getPercentageFor250(self.current) * 196) + 1 + (self:getPercentageFor(self.tension_preview) * 196), 25, 196)
        love.graphics.draw(self.tp_bar_fill, 0, 0)
        Draw.popScissor()
    end

    if (self.tension_preview > 0) then
        local alpha = (math.abs((math.sin((self.tsiner / 8)) * 0.5)) + 0.2)
        local color_to_set = {1, 1, 1, alpha}

        local theight = 196 - (self:getPercentageFor250(self.current) * 196)
        local theight2 = theight + (self:getPercentageFor(self.tension_preview) * 196)
        -- Note: causes a visual bug.
        if (theight2 > ((0 + 196) - 1)) then
            theight2 = ((0 + 196) - 1)
            color_to_set = {COLORS.dkgray[1], COLORS.dkgray[2], COLORS.dkgray[3], 0.7}
        end

        Draw.pushScissor()
        Draw.scissorPoints(0, theight2 + 1, 25, theight + 1)

        -- No idea how Deltarune draws this, cause this code was added in Kristal:
        local r,g,b,_ = love.graphics.getColor()
        love.graphics.setColor(r, g, b, 0.7)
        love.graphics.draw(self.tp_bar_fill, 0, 0)
        -- And back to the translated code:
        love.graphics.setColor(color_to_set)
        love.graphics.draw(self.tp_bar_fill, 0, 0)
        Draw.popScissor()

        love.graphics.setColor(1, 1, 1, 1)
    end


    if ((self.apparent > 20) and (self.apparent < 250)) then
        love.graphics.setColor(1, 1, 1, 1)
        Draw.pushScissor()
        Draw.scissorPoints(0, 196 - (self:getPercentageFor250(self.current) * 196) + 1, 25, 196 - (self:getPercentageFor250(self.current) * 196) + 3)
        love.graphics.draw(self.tp_bar_fill, 0, 0)
        Draw.popScissor()
    end

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.tp_text, 30, 30)

    local tamt = math.floor(self:getPercentageFor250(self.apparent) * 100)
    self.maxed = false
    love.graphics.setFont(self.font)
    if (tamt < 100) then
        love.graphics.print(tostring(math.floor(self:getPercentageFor250(self.apparent) * 100)), 30, 70)
        love.graphics.print("%", 34, 95)
    end
    if (tamt >= 100) then
        self.maxed = true

        love.graphics.setColor(self.tension_maxtext)

        love.graphics.print("M", 28, 70)
        love.graphics.print("A", 32, 90)
        love.graphics.print("X", 36, 110)
    end

    super.draw(self)
end

return EnemyTensionBar