local MachineLaser, super = Class(WorldBullet)

function MachineLaser:init(x, y, h, mode, damage)
    super.init(self, x, y, "bullets/smallbullet")

    self.debug_select = false

    self.color_options = {
        red = {1,0,0},
        green = {0,1,0},
        blue = {0,1,1},
        orange = {1,(148/255),0}
    }
    self.mode = mode
    self.damage = damage or 10
    --self.color = self.color_options[self.mode]
    self.battle_fade = false
    self.siner = 0
    self.height = h
    self:setOrigin(-0.8, 0)
    self.sprite.visible = false

    self:setHitbox(0,0, 5, (h/2))
end

function MachineLaser:update()
    super.update(self)
end

function MachineLaser:onCollide(soul)
    if not Game.world:inBattle() or not self.active then return end
    if self.mode == "red" then
        if soul.inv_timer == 0 then
            self:onDamage(soul)
        end
    elseif self.mode == "blue" and Game.world.player:isMoving() then
        if soul.inv_timer == 0 then
            self:onDamage(soul)
        end
    elseif self.mode == "orange" and not Game.world.player:isMoving() then
        if soul.inv_timer == 0 then
            self:onDamage(soul)
        end
    end
end

function MachineLaser:draw()
    if not self.active then return end
    super.draw(self)


end

return MachineLaser