local VoidStarStorm, super = Class(Wave)

function VoidStarStorm:init()
    super.init(self)

	self:setArenaSize(200, 142)
    self.time = 10
end

function VoidStarStorm:onStart()
    self.attackers = self:getAttackers()
    if #self.attackers == 1 then
        self.timer:every(1/4, function()
            local x = Utils.random(Game.battle.arena.left, Game.battle.arena.right) + 200
            local y = -20
    
            Assets.stopAndPlaySound("stardrop", 1, 1)
            local bullet = self:spawnBullet("voidstar", x, y, math.rad(140), 8)
    
            bullet.remove_offscreen = false
        end)
    elseif #self.attackers == 2 then
        self.timer:every(1/2, function()
            local x = Utils.random(Game.battle.arena.left, Game.battle.arena.right) + 200
            local y = -20
    
            Assets.stopAndPlaySound("stardrop", 1, 0.8)
            local bullet = self:spawnBullet("voidstar_big", x, y, math.rad(140), 5)
    
            bullet.remove_offscreen = false
        end)
    elseif #self.attackers >= 3 then
        self.timer:every(2, function()
            local x = Utils.random(Game.battle.arena.left, Game.battle.arena.right) + 200
            local y = -60
    
            Assets.stopAndPlaySound("stardrop", 1, 0.4)
            local bullet = self:spawnBullet("voidstar_huge", x, y, math.rad(140), 4)
    
            bullet.remove_offscreen = false
        end)
    end
end

function VoidStarStorm:update()
    super.update(self)
end

return VoidStarStorm