local GonerBackgroundPiece, super = Class(Object)

function GonerBackgroundPiece:init()
    super.init(self, SCREEN_WIDTH/2, SCREEN_WIDTH/2, SCREEN_WIDTH, SCREEN_WIDTH)
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
    local function drawPart(x_dir, y_dir)
        love.graphics.draw(self.sprite, 0, 0, 0,
            x_dir + x_dir * self.x_stretch,
            y_dir + y_dir * self.y_stretch
        )
    end

    love.graphics.setColor(1, 1, 1, self.alpha)
    drawPart(-1, -1) -- left up
    drawPart(-1,  1) -- left down
    drawPart( 1, -1) -- right up
    drawPart( 1,  1) -- right down
end

return GonerBackgroundPiece