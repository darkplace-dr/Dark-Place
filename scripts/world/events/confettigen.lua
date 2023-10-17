local ConfettiGen, super = Class(Event)

function ConfettiGen:init(data)
    super.init(self, data.center_x, data.center_y, data.width, data.height)


    self:setOrigin(0.5, 1)
    --self:setSprite("kristal/banana", 0.25)
    self.month = tonumber(os.date("%m"))
    self.day = tonumber(os.date("%d"))
    
    Game.world.timer:every(0.5, function ()
        for i = 1, love.math.random(1,3) do
            local confetti = Confetti()
            self:addChild(confetti)
            confetti.x = confetti.x + Utils.random(-50, 50)
            confetti.y = confetti.y + Utils.random(-50, 0)
        end
    end)
end

return ConfettiGen