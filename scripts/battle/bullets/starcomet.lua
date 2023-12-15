local Bullet, super = Class(Bullet)

function Bullet:init(x, y)
    -- Last argument = sprite path
    super.init(self, x, y, "battle/bullets/star")
	
    self.rotation = math.rad(0) + 15
    self.graphics.spin = 0.15

    self.physics.speed_x = love.math.random(-1, 1)
    self.physics.speed_y = 5
    self.physics.friction = -0.2
	
    self.destroy_on_hit = false
end

function Bullet:update()
    -- For more complicated bullet behaviours, code here gets called every update
	
	if self.y > Game.battle.arena.bottom then
        self:destroy()
    end

    super.update(self)
end

function Bullet:destroy()
    self:remove()
	Assets.playSound("bomb", 0.5)

    local effect = Sprite("effects/boxing_crescent", self.x, self.y)
    effect:setOrigin(0.5, 0.5)
    effect:setLayer(BATTLE_LAYERS["above_arena"] + 1)
    effect:setScale(1.5)
    effect:play(1/20, false, function() effect:remove() end)
    Game.battle:addChild(effect)
	
    for i = -1, 1 do
        local offset = i * 15
        local star = self.wave:spawnBullet("battle/bullets/star", self.x, self.y)
        star:setScale(1)
        star.physics.direction = math.atan2(Game.battle.soul.y - star.y, Game.battle.soul.x - star.x) + math.rad(offset)
        star.physics.speed = 5
        star.rotation = math.rad(0) + 15
        star.graphics.spin = 0.15
    end
end

return Bullet