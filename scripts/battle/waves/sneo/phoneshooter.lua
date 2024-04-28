local Basic, super = Class(Wave)

function Basic:init()
	super.init(self)
    self.time = 15

    self.sneo = Game.battle:getEnemyBattler("sneo")
    self.type = 1
	
    if self.type == 0 then
        self:setArenaPosition(240, 160)
    end
end

function Basic:onStart()
	Game.battle:swapSoul(YellowSoul())
    Game.battle.soul.can_rotate = true

    self.sneo:setMode("move_back")

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

function Basic:onEnd()
    self.sneo:setMode("normal")
    super.onEnd(self)
end

return Basic