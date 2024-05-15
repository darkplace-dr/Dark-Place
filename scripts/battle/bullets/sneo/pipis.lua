local Pipis, super = Class(YellowSoulBullet)

function Pipis:init(x, y)
    super.init(self, x, y, "battle/bullets/sneo/pipis/normal/pipis")
    
    self.shot_health = 4

    self.damage = 40 

    self.timer = 0

    self.remove_offscreen = false

    self.type = 1

    self.drawlabel = false
    self.boom = false
end

function Pipis:onYellowShot(shot, damage)
    --self.physics = {}
    --self.collidable = false
	
	Assets.playSound("damage")

    self.shot_health = self.shot_health - damage
	
	if self.shot_health >= 1 then
        local piece = Sprite("battle/bullets/sneo/pipis/normal/piece", self.x, self.y)
        piece.layer = 800
        piece:play(0.05, true)
        piece:setScale(1)
        piece.physics.direction = math.rad(Utils.random(360))
        piece.rotation = math.rad(0) + 15
        piece.graphics.spin = 0.15
        piece.physics.speed = 4
        piece.physics.gravity = 0.2
        piece.alpha = 4
        piece.graphics.fade_to = 0
        piece.graphics.fade_callback = function() piece:remove() end
        piece.graphics.fade = 0.1
        Game.battle:addChild(piece)
    end

    if self.shot_health == 3 then
        self:setSprite("battle/bullets/sneo/pipis/normal/pipis_broken1")
    elseif self.shot_health == 2 then
        self:setSprite("battle/bullets/sneo/pipis/normal/pipis_broken2")
    elseif self.shot_health == 1 then
        self:setSprite("battle/bullets/sneo/pipis/normal/pipis_broken3")
    elseif self.shot_health <= 0 then
        --effect
        local effect = Sprite("effects/boxing_crescent", self.x, self.y)
        effect:setOrigin(0.5, 0.5)
        effect:setLayer(BATTLE_LAYERS["above_arena"] + 1)
        effect:setScale(1.5)
        effect:play(1/20, false, function() effect:remove() end)
        Game.battle:addChild(effect)

		self:destroy()
    end
    return "a", false
end

function Pipis:update()
    super.update(self)
	
    if self.type == 2 then
        self.rotation = self.rotation + math.rad(45) * DTMULT
        if self:collidesWith(self.wave.wall) then
            Assets.playSound("bump")
            self.physics.gravity = 0.24
            self.physics.speed_y = (-5 - Utils.random(3))
        end
	
        if self.boom == false and ((self.x < (Game.battle.arena.x + (Game.battle.arena.width / 2) + 20)) and not (self.y >= self.wave.wall.y)) then
            Assets.playSound("damage")
            self.physics = {}
            self.boom = true
            self:destroy()

            local initangle = math.random(80)
            local initspeed = 4
            local bulcount = 9
	
            for r = 0,1 do	
               for i = 0,bulcount - 1 do
                    local spamhead = self.wave:spawnBullet("sneo/weird_end_pipis_bullet", self.x, self.y)
                    spamhead:setSprite("battle/bullets/sneo/pipis/spamtonhead")
                    spamhead.sprite:setFrame(math.random(4))
                    spamhead.sprite:play(0.25, true)
                    spamhead.remove_offscreen = true
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
        elseif self.y >= SCREEN_HEIGHT and self.boom == false then
            Assets.playSound("damage")
            self.physics = {}
            self.boom = true
            self:destroy()

            local initangle = math.random(80)
            local initspeed = 4
            local bulcount = 9
	
            for r = 0,1 do	
                for i = 0,bulcount - 1 do
                    local spamhead = self.wave:spawnBullet("sneo/weird_end_pipis_bullet", self.x, self.y)
                    spamhead:setSprite("battle/bullets/sneo/pipis/spamtonhead")
                    spamhead.sprite:setFrame(math.random(4))
                    spamhead.sprite:play(0.25, true)
                    spamhead.remove_offscreen = true
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
    end
end

function Pipis:destroy(shot)
    Game:giveTension(self.shot_tp)
    for i=1,3 do
        local piece = Sprite("battle/bullets/sneo/pipis/normal/piece", self.x, self.y)
		piece.layer = 800
        piece:play(0.05, true)
        piece:setScale(2)
        piece.physics.direction = math.rad(Utils.random(360))
		piece.rotation = math.rad(0) + 15
		piece.graphics.spin = 0.15
        piece.physics.speed = 4
        piece.physics.gravity = 0.2
        piece.alpha = 3
        piece.graphics.fade_to = 0
        piece.graphics.fade_callback = function() piece:remove() end
        piece.graphics.fade = 0.1
        Game.battle:addChild(piece)
    end
    --if self.indication then self.indication:remove() end
    self:remove()
	
    --[[for i=0,11 do
        local diamond = self.wave:spawnBullet("spamtonneo/diamond_white", self.x, self.y)
        diamond:setLayer(self.layer - 1)
        diamond.rotation = i*0.523
        diamond.physics = {
            speed = 6,
			direction = self.dir + i*0.523
        }
    end]]
end

return Pipis