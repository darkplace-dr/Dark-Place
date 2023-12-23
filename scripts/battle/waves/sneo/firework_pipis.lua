local FireworkPipis, super = Class(Wave)

function FireworkPipis:init()
	super.init(self)
    self.time = 3
	
    self:setArenaPosition(245, 172)
	
	--[[local attackers = self:getAttackers()
	for _,attacker in ipairs(attackers) do
		attacker.sprite:setPartSine("head", 2)
		attacker:slideTo(attacker.x + 200, attacker.y, 0.25)
	end]]
end

function FireworkPipis:onStart()
    Game.battle:swapSoul(YellowSoul())
    self:spawnBullet("sneo/weird_end_pipis", 530, 100)
    self:spawnBullet("sneo/weird_end_pipis", 448, 168)
    self:spawnBullet("sneo/weird_end_pipis", 510, 250)
end

function FireworkPipis:onEnd()
	--[[local attackers = self:getAttackers()
	for _,attacker in ipairs(attackers) do
		attacker.sprite:setPartSine("head", 0)
		attacker:slideTo(attacker.x - 200, attacker.y, 0.25)
	end]]
    super.onEnd(self)
end

return FireworkPipis