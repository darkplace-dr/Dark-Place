local Spreadshot, super = Class(Wave)

function Spreadshot:init()
    super.init(self)
	
    self.time = 6
	
    self.enemies = self:getAttackers()
end

function Spreadshot:onStart()
    for _, enemy in ipairs(self.enemies) do
        enemy.sprite.eyecon = 20
		
        self.timer:after(5.5, function()
            enemy.sprite.eyecon = 10
        end)
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