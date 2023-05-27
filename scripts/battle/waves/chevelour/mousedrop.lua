local mousedrop, super = Class(Wave)

function mousedrop:init()
	super.init(self)
	
	self.time = 10
end

function mousedrop:onStart()
    self.timer:every(1/4.5, function()
        Assets.playSound("squeak")
        local x = Utils.random(Game.battle.arena.left - 12, Game.battle.arena.right + 12)
        local y = Utils.random(Game.battle.arena.top - 75, Game.battle.arena.top - 110)

        local bullet = self:spawnBullet("chevelour/mousetiny", x, y)
        bullet.physics.direction = math.rad(90)
        bullet.physics.speed = Utils.random(8,15)
    end)
end

return mousedrop