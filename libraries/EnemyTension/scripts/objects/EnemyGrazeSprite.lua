local EnemyGrazeSprite, super = Class(Object)

function EnemyGrazeSprite:init(x, y)
    self.texture = Assets.getTexture("battle/bullets/enemy_graze")

    super:init(self, x, y, self.texture:getWidth(), self.texture:getHeight())

    self.graze_scale = 1

    self.timer = 0
    self.visible = true
end

function EnemyGrazeSprite:update()
    if self.timer > 0 then
        --self.visible = true
        self.timer = Utils.approach(self.timer, 0, DT)
    else
        --self.visible = false
    end
end

function EnemyGrazeSprite:draw()
    local r,g,b,a = self:getDrawColor()

    love.graphics.setColor(r/2, g/2, b/2, self.timer / 0.2)
    love.graphics.draw(self.texture)

    love.graphics.setColor(1, 1, 1, (self.timer / 0.2) - 0.2)
    love.graphics.draw(self.texture)

    if self.graze_scale ~= 1 then
        love.graphics.push()

        love.graphics.translate(self.width/2, self.height/2)
        love.graphics.scale(self.graze_scale, self.graze_scale)
        love.graphics.translate(-self.width/2, -self.height/2)

        love.graphics.setColor(r/2, g/2, b/2, self.timer / 0.2)
        love.graphics.draw(self.texture)

        love.graphics.setColor(1, 1, 1, (self.timer / 0.2) - 0.2)
        love.graphics.draw(self.texture)

        love.graphics.pop()
    end

    super:draw(self)
end

return EnemyGrazeSprite