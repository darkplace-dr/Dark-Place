local LightGauge, super = Class(Object)

function LightGauge:init(type, amount, x, y, enemy, color)
    super.init(self, x, y)

    self.layer = BATTLE_LAYERS["damage_numbers"]

    self.type = type
    self:setOrigin(0.5, 0)

    if not color then
        if self.type == "damage" then
            self.color = PALETTE["action_health"]
        elseif self.type == "mercy" then
            self.color = COLORS["yellow"]
        end
    else
        self.color = color
    end

    self.enemy = enemy
    self.width, self.height = Utils.unpack(self.enemy:getGaugeSize())

    self.amount = amount

    if self.type == "damage" then
        self.value = self.enemy.health
        self.real_value = self.enemy.health
        self.max_value = self.enemy.max_health
        self.extra_width = (self.width / self.max_value)
    elseif self.type == "mercy" then
        self.value = self.enemy.mercy
        self.real_value = self.enemy.mercy
        self.max_value = 100
        self.extra_width = (self.width / self.max_value)
    end

end

function LightGauge:update()
    super.update(self)

    if self.type == "damage" then
        if self.value > (self.real_value - self.amount) then
            self.value = self.value - (self.amount / 15) * DTMULT / 2
        else
            self.value = (self.real_value - self.amount)
        end

        if self.value < 0 then
            self.value = 0
        end
    elseif self.type == "mercy" then
        if self.value < (self.real_value + self.amount) then
            self.value = self.value + (self.amount / 15) * DTMULT / 2
        else
            self.value = (self.real_value + self.amount)
        end

        if self.value > 100 then
            self.value = 100
        end
    end
end

function LightGauge:draw()
    super.draw(self)

    if self.type == "mercy" then
        Draw.setColor(COLORS["black"])
        love.graphics.rectangle("fill", -1, 7, Utils.round(self.max_value * self.extra_width + 2), self.height + 2)
        Draw.setColor(64 / 255, 64 / 255, 64 / 255) -- temp
        love.graphics.rectangle("fill", 0, 8, Utils.round(self.max_value * self.extra_width), self.height)
        if self.value > 0 then
            Draw.setColor(self.color)
            love.graphics.rectangle("fill", 0, 8, Utils.round(self.value * self.extra_width), self.height)
        end
    end
    if self.type == "damage" then
        Draw.setColor(COLORS["black"])
        love.graphics.rectangle("fill", -1, 7, Utils.round(self.max_value * self.extra_width + 2), self.height + 2)
        Draw.setColor(64 / 255, 64 / 255, 64 / 255) -- temp
        love.graphics.rectangle("fill", 0, 8, Utils.round(self.max_value * self.extra_width), self.height)
        if self.value > 0 then
            Draw.setColor(self.color)
            love.graphics.rectangle("fill", 0, 8, Utils.round(self.value * self.extra_width), self.height)
        end
    end

end

return LightGauge