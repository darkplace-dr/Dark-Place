local DiamondsAim, super = Class(Wave)

function DiamondsAim:init()
	super.init(self)
end

function DiamondsAim:onStart()
    self.timer:every(2/5, function()
        local x = MathUtils.random(Game.battle.arena.left - 100, Game.battle.arena.right + 100)
        local y = MathUtils.random(Game.battle.arena.top - 20, Game.battle.arena.top - 70)

        local bullet = self:spawnBullet("rudinn/diamond_black", x, y)
		self.timer:script(function(wait)
			wait(1/3)
			bullet.targeting = false
			bullet.graphics.grow = 0
			wait(1/3)
			local bullet2 = self:spawnBullet("rudinn/diamond_white", bullet.x, bullet.y, bullet.rotation)
			bullet2:setLayer(self.layer + 0.01)
			wait(1/4)
			bullet.graphics.grow = 0.2
			bullet:fadeOutAndRemove(0.2)
		end)
    end)
end

return DiamondsAim