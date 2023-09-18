local Runner, super = Class(Wave)

function Runner:init()
    super.init(self)

    self.time = 14

    self:setArenaSize(300, 150)
    --self:setArenaPosition(320, 180)

    --soul starting position
    self:setSoulPosition(200, 205)
end

function Runner:onStart()
    --ground texture
    self.ground = self:spawnObjectTo(Game.battle.mask, Sprite("battle/bullets/dino_ground", 0, 220))
    self.ground:setScale(2)
    self.ground.wrap_texture_x = true
    
    --ground collision
    self.start_x = Game.battle.arena:getCenter()
    
    self.solid = self:spawnObject(Solid(false, Game.battle.arena:getCenter(), 222, 400, 4))
    self.solid:setLayer(BATTLE_LAYERS["above_arena"])
    self.solid:setOrigin(0.5, 0.5)

    local diff = self:getAttackers()[1].difficulty
    local ground_speed = 8
    local bullet_max_type = 0
    if diff == 2 then
        ground_speed = 10
        bullet_max_type = 1
    elseif diff == 3 then
        ground_speed = 12
        bullet_max_type = 2
    elseif diff >= 4 then
        ground_speed = 16
        bullet_max_type = 3 
    end
    self.ground.physics.speed_x = -ground_speed
    self.timer:after(0.8, function()
        self.timer:every(1.5, function()
            local x = Game.battle.arena.right + 20

            local bullet = self:spawnBulletTo(Game.battle.mask, "cactus", x, 222, math.rad(180), ground_speed)
            bullet.type = love.math.random(0, bullet_max_type)
        end)
    end)
end

return Runner
