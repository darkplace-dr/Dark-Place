local GonerBackgroundPiece, super = Class(Object)

function GonerBackgroundPiece:init()
    super.init(self,
        SCREEN_WIDTH/2/2, SCREEN_HEIGHT/2/2,
        SCREEN_WIDTH/2, SCREEN_HEIGHT/2
    )
    self:setOrigin(0.5, 0.5)
    self.sprite = Assets.getTexture("world/cutscenes/intro/DEPTH")

    self.timer = 0

    self.alpha = 0.2

    self.stretch_speed = 0.005
    self.x_stretch = 1
    self.y_stretch = 1

    self.alpha_out = 0
end

function GonerBackgroundPiece:update()
    self.timer = self.timer + DTMULT

    self.x_stretch = self.x_stretch + self.stretch_speed * DTMULT
    self.y_stretch = self.y_stretch + self.stretch_speed * DTMULT

    self.alpha = Utils.approach(0, 0.2, self.timer * 0.01) + math.sin(self.timer / 34) * 0.2
    if self.y_stretch > 2 then
        self.alpha_out = Utils.approach(self.alpha_out, 0.5, 0.01 * DTMULT)
        self.alpha = self.alpha - self.alpha_out
        if self.alpha_out >= 0.5 then
            self:remove()
        end
    end

    super.update(self)
end

function GonerBackgroundPiece:draw()
    love.graphics.setColor(1, 1, 1, self.alpha)
    love.graphics.draw(
        self.sprite, 0, 0, 0,
        1 + self.x_stretch, 1 + self.y_stretch,
        SCREEN_WIDTH/2/2, SCREEN_HEIGHT/2/2
    )
end

return GonerBackgroundPiece