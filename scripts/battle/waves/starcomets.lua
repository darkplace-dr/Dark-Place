local Starwings, super = Class(Wave)

function Starwings:init()
    super.init(self)
    self.time = 12
    self.starwalker = self:getAttackers()[1]
end

function Starwings:onArenaEnter()
	if self.encounter.id == "seawalker" then
		Game.battle.arena.bg_color = {0, 0, 0.2}
	end
end

function Starwings:onStart()
	if self.encounter.id == "seawalker" then
		Game.battle.soul.speed = 2
	end
    self.encounter:setMode("shoot")

    self.timer:every(1, function()
        Assets.playSound("stardrop")
        local x = Utils.random(Game.battle.arena.left - 20, Game.battle.arena.right + 20)
        local bullet = self:spawnBullet("starcomet", x, -20)
    end)
end

function Starwings:onEnd()
    self.encounter:setMode("normal")
    super.onEnd(self)
end

function Starwings:update()
    super.update(self)
end

return Starwings
