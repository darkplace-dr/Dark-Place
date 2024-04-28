local Pendulum, super = Class(Wave)

function Pendulum:init()
    super.init(self)
	
	self.time = -1
	self:setArenaSize(110, 240)
	self:setArenaPosition(300, 175)

    self.sneo = Game.battle:getEnemyBattler("sneo")
end

function Pendulum:onStart()
	Game.battle:swapSoul(YellowSoul())

    self.sneo:setMode("move_up")
	
    self.timer:after(1, function()
        local d = self:spawnBullet("sneo/pendulum1", -1000, -1000)
        d:setSprite("battle/bullets/sneo/arm_l")
        d:setScale(2)
        d:setHitbox(0, 0, d.width, d.height)
		d.target_x = 300

        local d = self:spawnBullet("sneo/pendulum1", -1000, -1000)
        d.length = -40
        d.myspeed = -2
        d.place = -60
        d:setSprite("battle/bullets/sneo/arm_cannon")
        d:setScale(2)
        d:setHitbox(0, 0, d.width, d.height)
        d.target_x = 300
	end)
	
    self.timer:after(6, function()
        local d = self:spawnBullet("sneo/pendulum1", -1000, -1000)
        d.length = 310
        d:setSprite("battle/bullets/sneo/wing_l")
        d:setScale(2)
        d:setHitbox(0, 0, d.width, d.height)
		d.target_x = 300
	end)
	
    self.timer:after(12, function()
        local d = self:spawnBullet("sneo/pendulum1", -1000, -1000)
        d.length = 235
        d:setSprite("battle/bullets/sneo/head")
        d:setScale(2)
        d:setHitbox(0, 0, d.width, d.height)
		d.target_x = 300
	end)
end

return Pendulum