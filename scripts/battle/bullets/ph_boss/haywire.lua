local PizzaheadHaywire, super = Class(Bullet)

function PizzaheadHaywire:init(x, y)
    super.init(self, x, y, "battle/bullets/ph_boss/haywire/idle")

    self.sprite:play(0.1)

    self.collider = CircleCollider(self, self.width/2, self.height/2, 24)
	
	self.floatdir = 1
    self.physics.speed_x = (self.floatdir * 5)
    self.physics.speed_y = 1
    self.physics.gravity = 0

    self.timer = 0
    self.idle_frame = 1
    self.attack_frame = 1
    self.movedir = false

    self.haywire_snd = Assets.playSound("ph_boss/haywire", 0.15, 1)
    self.haywire_snd:setLooping(true)
	
    self.destroy_on_hit = false
	
	self:addChild(ParticleEmitter(self.width/2, self.height/2, 20, 20, {
		layer = self.layer - 1,
        amount = 1,
        every = 0.2,
        time = -1,

        texture = "cakesmoke",
        path = "particles",

        rotation = {0, 0},
        spin = 0,

        color = {1, 1, 1},
        alpha = 1,
        blend = "alpha",

        scale = 10,
        scale_x = 5,
        scale_y = 5,

        grow_time = 0.5,
        grow_x_time = 0,
        grow_y_time = 0,

        fade_in = 0,
        fade_in_time = 0.2,
        fade = 0,
        fade_time = 0.75,
        fade_after = 0.25,
        fade_to = 0,

        remove_after = 1,

        physics = {
            speed_x = {-2, 2},
            speed_y = -1,
            speed = 0,
            friction = 0.2,
            gravity = -0.5,
            gravity_direction = math.pi/2,
        },
        angle = {0, math.pi*2},

        dist = 0
	}))
end

function PizzaheadHaywire:update()
	super.update(self)
	
    self.timer = self.timer + DTMULT
	
    if self.movedir == false then
        self.physics.speed_x = (self.floatdir * 5)
    else
        self.physics.speed_x = -(self.floatdir * 5)
    end
	
    if self.pause == true then
        self.physics.speed_x = 0
    else
        if self.x < Game.battle.arena.left + 20 then
            self.movedir = false
        elseif self.x > Game.battle.arena.right - 20 then
            self.movedir = true
        end
    end
	
    if self.y == Game.battle.arena.top - 44 then
        self.y = Game.battle.arena.top - 44
        self.physics.speed_y = 0
    end
	
	if self.timer >= 160 then
        self:fire()
    end
end

function PizzaheadHaywire:fire()
    self.pause = true
    self.attack_frame = self.attack_frame + 1*DTMULT

    self:setSprite("battle/bullets/ph_boss/haywire/attack_"..self.attack_frame)
    
    if self.attack_frame == 7 then
        local cog = self.wave:spawnBullet("ph_boss/cog", self.x, self.y + 38)
        Assets.playSound("ph_boss/spit")
    end
    if self.attack_frame >= 14 then
        self.pause = false
        self:setSprite("battle/bullets/ph_boss/haywire/idle")
        self.sprite:play(0.1)
        self.timer = 0
        self.attack_frame = 0
    end
end

return PizzaheadHaywire