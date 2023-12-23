---@class ActorSprite
---@overload fun(...) : ActorSprite
local ActorSprite, super = Class("ActorSprite", true)

function ActorSprite:init(actor)
	super.init(self, actor)


	self.run_away_2 = false
    self.run_away_timer_2 = 0
end

function ActorSprite:update()
    if self.run_away_2 then
        self.run_away_timer_2 = self.run_away_timer_2 + DTMULT
    end

    super.update(self)
end

function ActorSprite:draw()
    if self.actor:preSpriteDraw(self) then
        return
    end

    if self.texture and self.run_away then
        local r,g,b,a = self:getDrawColor()
        for i = 0, 80 do
            local alph = a * 0.4
            Draw.setColor(r,g,b, ((alph - (self.run_away_timer / 8)) + (i / 200)))
            Draw.draw(self.texture, i * 2, 0)
        end
        return
    end

    if self.texture and self.run_away_2 then
        local r,g,b,a = self:getDrawColor()
        for i = 0, 80 do
            local alph = a * 0.4
            Draw.setColor(r,g,b, ((alph - (self.run_away_timer_2 / 8)) + (i / 200)))
            Draw.draw(self.texture, -i * 2, 0)
        end
        return
    end

    if self.texture and self.aura then
        for i = 1, 5 do
            local aura = (i * 9) + ((self.aura_siner * 3) % 9)
            local aurax = (aura * 0.75) + (math.sin(aura / 4) * 4)
            --var auray = (45 * scr_ease_in((aura / 45), 1))
            local auray = 45 * Ease.inSine(aura / 45, 0, 1, 1)
            local aurayscale = math.min(1, 80 / self.texture:getHeight())

            Draw.setColor(1, 0, 0, (1 - (auray / 45)) * 0.5)
            Draw.draw(self.texture, -((aurax / 180) * self.texture:getWidth()), -((auray / 82) * self.texture:getHeight() * aurayscale), 0, 1 + ((aurax/36) * 0.5), 1 + (((auray / 36) * aurayscale) * 0.5))
        end
        Draw.setColor(self:getDrawColor())
    end

    super.super.draw(self)

    if self.texture and self.frozen then
        if self.freeze_progress < 1 then
            Draw.pushScissor()
            Draw.scissorPoints(nil, self.texture:getHeight() * (1 - self.freeze_progress), nil, nil)
        end

        local last_shader = love.graphics.getShader()
        local shader = Kristal.Shaders["AddColor"]
        love.graphics.setShader(shader)
        shader:send("inputcolor", {0.8, 0.8, 0.9})
        shader:send("amount", 1)

        local r,g,b,a = self:getDrawColor()

        Draw.setColor(0, 0, 1, a * 0.8)
        Draw.draw(self.texture, -1, -1)
        Draw.setColor(0, 0, 1, a * 0.4)
        Draw.draw(self.texture, 1, -1)
        Draw.draw(self.texture, -1, 1)
        Draw.setColor(0, 0, 1, a * 0.8)
        Draw.draw(self.texture, 1, 1)

        love.graphics.setShader(last_shader)

        love.graphics.setBlendMode("add")
        Draw.setColor(0.8, 0.8, 0.9, a * 0.4)
        Draw.draw(self.texture)
        love.graphics.setBlendMode("alpha")

        if self.freeze_progress < 1 then
            Draw.popScissor()
        end
    end

    self.actor:onSpriteDraw(self)
end

return ActorSprite