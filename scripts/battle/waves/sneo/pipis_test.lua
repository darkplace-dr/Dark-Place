local Basic, super = Class(Wave)

function Basic:init()
	super.init(self)
    self.time = -1
	
    self:setArenaPosition(240, 160)
end

function Basic:onStart()
	Game.battle:swapSoul(YellowSoul())

    self.timer:every(1.2, function()
        local x = SCREEN_WIDTH - 60
        local y = Utils.random(Game.battle.arena.top, Game.battle.arena.bottom)

        local bullet = love.math.random(2)
		
        if bullet == 1 then
            local pipis = self:spawnBullet("sneo/pipis", x, y, math.rad(180), -6)
        else
            local bomb = self:spawnBullet("sneo/sneobomb", x, y, math.rad(180), -6)
        end
    end)
end

return Basic