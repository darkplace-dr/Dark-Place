local Runner, super = Class(Wave)

function Runner:init()
    super:init(self)

    self.time = 14
	self:setArenaSize(300, 150)
	--self:setArenaPosition(320, 180)
	
	self.googledino = self:getAttackers()[1]
end

function Runner:onStart()
    Game.battle:swapSoul(BlueSoul())

    local arena = Game.battle.arena

    --soul starting position
    local soul = Game.battle.soul
    soul.x = 200
    soul.y = 210

    --ground texture
	self.ground = Sprite("battle/bullets/dino_ground", 0, 220)
    self.ground:setScale(2)
    self.ground.wrap_texture_x = true
    Game.battle.mask:addChild(self.ground)
	
    --ground collision
    self.start_x = Game.battle.arena:getCenter()
	
    self.solid = self:spawnObject(Solid(true, self.start_x, 222, 400, 4))
    self.solid:setLayer(BATTLE_LAYERS["above_arena"])
    self.solid:setOrigin(0.5, 0.5)
    self.solid.alpha = 0
	
    if self.googledino.difficulty == 1 then
        self.ground.physics.speed_x = -8
        self.timer:after(0.8, function()
            self.timer:every(1.5, function()
                local x = Game.battle.arena.right + 20

                local bullet = self:spawnBullet("cactus", x, 222, math.rad(180), 8)
                bullet:setParent(Game.battle.mask)
            end)
        end)
	end
    if self.googledino.difficulty == 2 then
        self.ground.physics.speed_x = -10
        self.timer:after(0.8, function()
            self.timer:every(1.5, function()
                local x = Game.battle.arena.right + 20

                local bullet = self:spawnBullet("cactus", x, 222, math.rad(180), 10)
				bullet.type = love.math.random(0, 1)
                bullet:setParent(Game.battle.mask)
            end)
        end)
	end
    if self.googledino.difficulty == 3 then
        self.ground.physics.speed_x = -12
        self.timer:after(0.8, function()
            self.timer:every(1.5, function()
                local x = Game.battle.arena.right + 20

                local bullet = self:spawnBullet("cactus", x, 222, math.rad(180), 12)
				bullet.type = love.math.random(0, 2)
                bullet:setParent(Game.battle.mask)
            end)
        end)
	end
    if self.googledino.difficulty >= 4 then
        self.ground.physics.speed_x = -16
        self.timer:after(0.8, function()
            self.timer:every(1.5, function()
                local x = Game.battle.arena.right + 20

                local bullet = self:spawnBullet("cactus", x, 222, math.rad(180), 16)
				bullet.type = love.math.random(0, 3)
                bullet:setParent(Game.battle.mask)
            end)
        end)
	end
end

function Runner:onEnd()
    self.ground:remove()
end

return Runner