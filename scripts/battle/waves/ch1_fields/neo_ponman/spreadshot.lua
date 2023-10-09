local Spreadshot, super = Class(Wave)

function Spreadshot:init()
    super.init(self)
	
    self.time = 6
	
    self.enemies = self:getAttackers()
end

function Spreadshot:onStart()
    for _, enemy in ipairs(self.enemies) do
        enemy.sprite.eyecon = 20
    end
end

function Spreadshot:update()
    super.update(self)
end

function Spreadshot:onEnd()
    for _, enemy in ipairs(self.enemies) do
        enemy.sprite.eyecon = 0
    end
end

return Spreadshot