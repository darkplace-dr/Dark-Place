---@class DarkFountain : Event
local DarkFountain, super = Class("DarkFountain", true)

function DarkFountain:update()
    self.siner = self.siner + DTMULT

    self.hscroll = self.hscroll + DTMULT
    if self.hscroll > 240 then
        self.hscroll = self.hscroll - 240
    end

    local function fcolor(h, s, v)
        self.hue = (h / 255) % 1
        return Utils.hsvToRgb((h / 255) % 1, s / 255, v / 255)
    end

    if self.adjust == 0 then
        self:setColor(fcolor(self.siner / 4, 160 + (math.sin(self.siner / 32) * 60), 255))
        self.bg_color = {fcolor(self.siner / 4, 255, (math.sin(self.siner / 16) * 40) + 60)}
    elseif self.adjust == 1 then
        self:setColor(Utils.mergeColor(self.color, COLORS.white, 0.06 * DTMULT))
        self.bg_color = Utils.mergeColor(self.bg_color, COLORS.black, 0.06 * DTMULT)
    elseif self.adjust == 2 then
        self.slowdown = Utils.approach(self.slowdown, 1, 0.02 * DTMULT)
        self.siner = self.siner - self.slowdown * DTMULT
        self.bg_siner = self.bg_siner - (self.slowdown / 16) * DTMULT
        self.bg_color = Utils.mergeColor(self.bg_color, COLORS.white, 0.03 * DTMULT)
    elseif self.adjust == 3 then
        self.slowdown = Utils.approach(self.slowdown, 1, 0.01 * DTMULT)
        self.siner = self.siner - (self.slowdown * 0.5) * DTMULT
        self.bg_siner = self.bg_siner - (self.slowdown / 24) * DTMULT
        self.hscroll = self.hscroll - (self.slowdown * 0.8) * DTMULT
        self:setColor(Utils.mergeColor(self.bg_color, {fcolor(self.siner / 16, 160 + (math.sin(self.siner / 128) * 60), 255)}, self.slowdown))
        self.bg_color = Utils.mergeColor(self.bg_color, {fcolor(self.siner / 16, 255, (math.sin(self.siner / 64) * 40) + 60)}, self.slowdown * DTMULT)
    elseif self.adjust == 4 then -- Custom
        self.bg_color = Utils.mergeColor(self.bg_color, COLORS.white, 0.03 * DTMULT)
        -- IDK it would look awful if I don't do this
        self.eyebody = self.eyebody - 0.0125 * DTMULT
    end

    self.bg_siner = self.bg_siner + 0.0625 * DTMULT
    if self.bg_siner > 7 then
        self.bg_siner = self.bg_siner - 7
    end

    super.super.update(self)
end

return DarkFountain