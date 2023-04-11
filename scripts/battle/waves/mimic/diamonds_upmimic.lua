local DiamondsUpMimic, super = Class(Wave)

function DiamondsUpMimic:init()
	super.init(self)
	
	self.time = 7
end

function DiamondsUpMimic:onStart()
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
    self.timer:every(1/15, function()
        local x = Utils.random(Game.battle.arena.left - 20, Game.battle.arena.right + 20)
        local y = Utils.random(Game.battle.arena.bottom + 50, Game.battle.arena.bottom + 100)

        self:spawnBullet("grounder/diamond_mix", x, y, math.rad(270))
    end)
end

return DiamondsUpMimic