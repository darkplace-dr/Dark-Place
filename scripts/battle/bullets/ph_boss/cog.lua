local Cog, super = Class(Bullet)

function Cog:init(x, y)
    super.init(self, x, y, "battle/bullets/ph_boss/cog")

    self.collider = CircleCollider(self, self.width/2, self.height/2, 8)

    self.physics.speed_x = 0
    self.physics.speed_y = 0
	self.physics.gravity = 0.5

    self.landed = false
    self.roll = false
    self.destroy_on_hit = false
	
    Assets.playSound("ph_boss/enemyprojectile")
end

function Cog:onRoll()
    if self.landed == true then
        self.rolling_snd = Assets.playSound("chain_extend", 0.8)
        self.rolling_snd:setLooping(true)
    end
end

function Cog:update()
	super.update(self)

    if self.y > Game.battle.arena.bottom - 24 then
        self.y = Game.battle.arena.bottom - 24
        if self.landed ~= true then
            self.roll = true
            self.landed = true
            self:onRoll()
            if self.x ~= Game.battle.soul.x then
                self.movedir = Utils.sign(Game.battle.soul.x - self.x)
            end
        end
        if self.landed == true then
            self.physics.speed_x = self.movedir * 4
            self.physics.gravity = 0
        end
    end
	
	if self.roll ~= true then
        self.graphics.spin = 0
    else
        self.graphics.spin = self.movedir * 0.07
    end

    if self.x < -50 or self.x > SCREEN_WIDTH + 50 or self.y > SCREEN_HEIGHT + 50 then
        self:remove()
        self.rolling_snd:stop()
    end
end

return Cog