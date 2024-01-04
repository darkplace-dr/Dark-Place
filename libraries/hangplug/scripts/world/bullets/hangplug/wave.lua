local PlugWave, super = Class(WorldBullet, "hangplug/wave")

function PlugWave:init(x, y, dir, damage)
    super:init(self, x, y, "world/bullets/hangplug/wave")

    self:setScale(dir == "left" and 2 or -2, 0.1)
    self:setOrigin(0.5, 1)

    self:setHitbox(0, 20, 20, 20)

    self.speed = dir == "left" and -12 or 12
    self.physics.speed_x = dir == "left" and -0.1 or 0.1

    self.damage = damage or 18

    self.battle_fade = false
    self.fade_away = false
    self.afterimg_timer = 0
end

function PlugWave:onAdd(parent)
    super:onAdd(self, parent)

    self:setLayer(self.world.map.object_layer)
end

function PlugWave:update()
    self.afterimg_timer = self.afterimg_timer + DTMULT
    if self.afterimg_timer >= 1 then
        self.afterimg_timer = self.afterimg_timer - 1

        local afterimg = Sprite("world/bullets/hangplug/wave", self.x, self.y)
        afterimg:setOrigin(0.5, 1)
        afterimg:setScale(self.scale_x, self.scale_y)
        afterimg:fadeOutAndRemove(0.15)
        afterimg.alpha = self.alpha * 0.5
        afterimg.layer = self.layer - 0.001
        afterimg.debug_select = false
        self.world:addChild(afterimg)
    end

    self.physics.speed_x = Utils.approach(self.physics.speed_x, self.speed, (math.abs(self.physics.speed_x) * 0.5) * DTMULT)

    if self.scale_y < 2 then
        self.alpha = self.scale_y / 2
        self.scale_y = Utils.approach(self.scale_y, 2, (self.scale_y * 0.3) * DTMULT)
    end

    if not self.fade_away then
        self.fade_away = true
        for _,area in ipairs(self.world.map.battle_areas) do
            if area:collidesWith(self.collider) then
                self.fade_away = false
                break
            end
        end
    end

    if self.fade_away then
        self.collidable = false
        self.alpha = self.alpha - (self.alpha * 0.4) * DTMULT
        if self.alpha < 0.05 then
            self:remove()
            return
        end
    end

    super:update(self)
end

return PlugWave