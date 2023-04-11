local DiamondsAimMimic, super = Class(Wave)

function DiamondsAimMimic:init()
	super.init(self)
end

function DiamondsAimMimic:onStart()
	local mimic = Game.battle:getEnemyBattler("mimic")
    if mimic.current_actor ~= "grounder" then
		mimic.current_actor = "grounder"
        self.timer:script(function(wait)
			mimic:fadeTo(0.2, 0.05)
			wait(0.1)
			mimic:setActor("grounder")
			mimic:fadeTo(0.2, 0)
			mimic:fadeTo(1, 0.05)
		end)
    end
    self.timer:every(1/7, function()
        local x = Utils.random(Game.battle.arena.left - 100, Game.battle.arena.right + 100)
        local y = Utils.random(Game.battle.arena.top - 20, Game.battle.arena.top - 70)

        local bullet = self:spawnBullet("grounder/diamond_black", x, y)
		self.timer:script(function(wait)
			wait(1/3)
			bullet.targeting = false
			bullet.graphics.grow = 0
			wait(1/3)
			local bullet2 = self:spawnBullet("grounder/diamond_white", bullet.x, bullet.y, bullet.rotation)
			bullet2:setLayer(self.layer + 0.01)
			wait(1/4)
			bullet.graphics.grow = 0.2
			bullet:fadeOutAndRemove(0.2)
		end)
    end)
end

return DiamondsAimMimic