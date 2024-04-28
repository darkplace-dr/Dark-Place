local WeirdEndPipis, super = Class(YellowSoulBullet)

function WeirdEndPipis:init(x, y)
    super.init(self, x, y, "battle/bullets/sneo/pipis/normal/pipis")

    self.damage = 2
	self.tp = 1

    self.alpha = 0
end

function WeirdEndPipis:onYellowShot(shot, damage)	
	Assets.playSound("damage", 0.3)
	
    --effect
    local effect = Sprite("effects/boxing_crescent", self.x, self.y)
    effect:setOrigin(0.5, 0.5)
    effect:setLayer(BATTLE_LAYERS["above_arena"])
    effect:setScale(1.5)
    effect:play(1/30, false, function() effect:remove() end)
    Game.battle:addChild(effect)
	
    self:destroy()
    return "a", false
end

function WeirdEndPipis:update()
    self.alpha = self.alpha + 0.08*DTMULT
    if self.alpha >= 2 then
		self:destroy()
    end
    super.update(self)
end

function WeirdEndPipis:destroy()
    self:remove()
	
	Assets.playSound("minigames/punch_out/explosion_8bit", 0.8, 1)

    local initangle = math.random(80)
    local initspeed = 4
    local bulcount = 9
	
    for r = 0,1 do	
        for i = 0,bulcount - 1 do
            local spamhead = self.wave:spawnBullet("sneo/weird_end_pipis_bullet", self.x, self.y)
            spamhead:setSprite("battle/bullets/sneo/pipis/spamtonhead")
            spamhead.sprite:setFrame(math.random(4))
            spamhead.sprite:play(0.25, true)
            spamhead.physics = {
            speed = 2 + initspeed,
            direction = initangle + math.random(math.rad(20)),
            }
            spamhead.layer = self.layer - 1
            initangle = initangle + (math.rad(360) / bulcount)
        end
	    initspeed = initspeed + 4
	    initangle = math.random(50)
    end
end

return WeirdEndPipis