local DiamondsUpLots, super = Class(Wave)

function DiamondsUpLots:init()
	super.init(self)
	
	self.time = 7
end

function DiamondsUpLots:onStart()
    self.timer:every(1/15, function()
        local x = Utils.random(Game.battle.arena.left - 20, Game.battle.arena.right + 20)
        local y = Utils.random(Game.battle.arena.bottom + 50, Game.battle.arena.bottom + 100)

        self:spawnBullet("grounder/diamond_mix", x, y, math.rad(270))
    end)
end

return DiamondsUpLots