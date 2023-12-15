local Basic, super = Class(Wave)

function Basic:init()
	super:init(self)
    self.time = 15

    self.type = 1
	
    if self.type == 0 then
        self:setArenaPosition(240, 160)
    end
end

function Basic:onStart()
	Game.battle:swapSoul(YellowSoul())

    if self.type == 0 then
        local phone = self:spawnBullet("sneo/phoneshooter", Game.battle.arena.right + 200, Game.battle.arena.y - 40)
    end
	
    if self.type == 1 then
        local phone = self:spawnBullet("sneo/phoneshooter", Game.battle.arena.right + 150, Game.battle.arena.y - 40)
        phone.type = 1
        phone.side = 0
		
        self.timer:after(0.5, function()
            local phone = self:spawnBullet("sneo/phoneshooter", Game.battle.arena.left - 150, Game.battle.arena.y - 40)
            phone.type = 1
            phone.side = 1
        end)
    end
end

return Basic