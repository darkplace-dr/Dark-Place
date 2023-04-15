local DiamondsUp, super = Class(Wave)

function DiamondsUp:init()
	super.init(self)
	
	self.time = 7
end

function DiamondsUp:onStart()
    self.timer:every(1/3, function()
        local x = Utils.random(Game.battle.arena.left - 20, Game.battle.arena.right + 20)
        local y = Utils.random(Game.battle.arena.bottom + 50, Game.battle.arena.bottom + 100)

        self:spawnBullet("grounder/diamond_mix", x, y, math.rad(270))
    end)
end

return DiamondsUp