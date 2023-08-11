local EnemySoul, super = Class(Bullet)

function EnemySoul:init(x, y, dir, speed)
    
    super:init(self, x, y, "battle/bullets/enemy_heart")
    self:setScale(1,1)
    self:setOrigin(0.5, 0.5)
    self.collider = CircleCollider(self, 10, 10, 8)
    --self.color = {247/255, 143/255, 159/255}

    self.xspeed = 0
    self.yspeed = 0

    self.alpha = 0
    
    self.remove_offscreen = false

    -- This bullet does no damage and cannot be grazed for TP.
    self.damage = 0
    self.tp = 0

    self.destroy_on_hit=false

    self.graze_timer = 0

    self.graze_size_factor = 1

    -- This hitbox matches the player soul's graze range.
    self.graze_collider = CircleCollider(self, 10, 10, 25 * self.graze_size_factor)

    self.graze_sprite = EnemyGrazeSprite()
    self.graze_sprite:setOrigin(0.30, 0.30)
    self.graze_sprite.inherit_color = true
    self.graze_sprite.graze_scale = self.graze_size_factor
    self.graze_sprite.collider = self.graze_collider
    self:addChild(self.graze_sprite)

end

function EnemySoul:update()
    
    if self.alpha < 1 then
        self.alpha = Utils.approach(self.alpha, 1, DT)
    end

    if self.graze_timer > 0 then
        self.graze_timer = self.graze_timer - DTMULT
    end

    -- Shameless port of one of CYF's bullettest waves, changed slightly so it tries to get closer.
    local xdifference = (Game.battle.soul.x+Game.battle.soul.width*2) - self.x - 40
    local ydifference = (Game.battle.soul.y+Game.battle.soul.height*2) - self.y - 40
    local xspeed = self.xspeed / 2 + xdifference / 100
    local yspeed = self.yspeed / 2 + ydifference / 100
    self.x, self.y=self.x+xspeed, self.y+yspeed
    self.xspeed = xspeed
    self.yspeed = yspeed
    super:update(self)

    -- This bullet will try to graze YOU to steal your TP instead of doing damage.
    -- It SHOULD be at about the same rate you'd gain TP from grazing enemy bullets, but grazing is complicated enough that it may be slightly off.
    -- Nothing happens if you're out of TP. You can't steal what ain't there.
    if Game.battle.soul:collidesWith(self.graze_collider) and Game.tension > 0 then
        if self.graze_timer <= 0 then
            self.graze_timer = 5
            self.graze_sprite.timer = 0.3
            Game:removeTension(1.6)
            Game.battle.encounter.enemy_tension = Game.battle.encounter.enemy_tension + 1.6
            Assets.playSound("graze")
        end
    end

end

function EnemySoul:onCollide(soul)
-- Do literally nothing
end

return EnemySoul